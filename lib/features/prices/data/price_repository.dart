import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../products/domain/product.dart';
import '../../stores/domain/store.dart';
import '../domain/price_rules.dart';

part 'price_repository.g.dart';

@Riverpod(keepAlive: true)
PriceRepository priceRepository(Ref ref) =>
    PriceRepository(FirebaseFirestore.instance);

enum PriceFailure {
  duplicateRecently,
  dailyLimit,
  notAllowed,
  network,
  unknown;

  String message(AppLocalizations l) => switch (this) {
    duplicateRecently => l.errorDuplicatePrice,
    dailyLimit => l.errorDailyLimit,
    notAllowed => l.errorActionNotAllowed,
    network => l.errorNetwork,
    unknown => l.errorGeneric,
  };
}

class PriceException implements Exception {
  const PriceException(this.failure, [this.cause]);
  final PriceFailure failure;
  final Object? cause;
  @override
  String toString() => 'PriceException($failure, $cause)';
}

/// `queuedOffline`: no signal, Firestore saved the write on the phone and will
/// send it when the connection returns.
enum SubmitResult { synced, queuedOffline }

const reportReasons = ['wrong price', 'wrong product', 'spam', 'offer ended'];

/// One point on the price-history chart.
class PricePoint {
  const PricePoint(this.storeId, this.chainId, this.priceBaisa, this.reportedAt);
  final String storeId;
  final String chainId;
  final int priceBaisa;
  final DateTime reportedAt;
}

/// All price writes. Each is a single batch that also keeps the denormalized
/// `products.latestPrices` in step, so the app works without Cloud Functions.
/// Firestore rules re-check everything (limits, ownership, derived values).
class PriceRepository {
  PriceRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _prices =>
      _db.collection('prices');

  /// Days are UTC to match `request.time` in the security rules.
  static String dayId(DateTime now) {
    final u = now.toUtc();
    return '${u.year * 10000 + u.month * 100 + u.day}';
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> _tryGet(
    DocumentReference<Map<String, dynamic>> ref,
  ) async {
    try {
      final s = await ref.get();
      return s.exists ? s : null;
    } catch (_) {
      return null; // offline with nothing cached: let the rules decide
    }
  }

  Future<SubmitResult> submit({
    required Product product,
    required Store store,
    required String uid,
    required int priceBaisa,
    bool isOffer = false,
    DateTime? offerEndDate,
    String? photoUrl,
    bool needsReview = false,
  }) async {
    assert(isValidPrice(priceBaisa));
    final now = DateTime.now();
    final rateRef = _db
        .collection('rateLimits')
        .doc('${uid}_${product.id}_${store.id}');
    final dailyRef = _db.collection('dailyCounts').doc('${uid}_${dayId(now)}');

    final (rate, daily) = await (_tryGet(rateRef), _tryGet(dailyRef)).wait;
    final last = (rate?.data()?['lastAt'] as Timestamp?)?.toDate();
    if (last != null && now.difference(last) < duplicateWindow) {
      throw const PriceException(PriceFailure.duplicateRecently);
    }
    final count = (daily?.data()?['count'] as num?)?.toInt() ?? 0;
    if (count >= maxDailySubmissions) {
      throw const PriceException(PriceFailure.dailyLimit);
    }

    final priceRef = _prices.doc();
    final stamp = FieldValue.serverTimestamp();
    final offerEnd = isOffer && offerEndDate != null
        ? Timestamp.fromDate(offerEndDate)
        : null;

    final batch = _db.batch()
      ..set(priceRef, {
        'productId': product.id,
        'storeId': store.id,
        'chainId': store.chainId,
        'priceBaisa': priceBaisa,
        'isOffer': isOffer,
        'offerEndDate': ?offerEnd,
        'photoUrl': ?photoUrl,
        'reportedBy': uid,
        'reportedAt': stamp,
        'confirmations': 0,
        'confirmedBy': <String>[],
        'flags': 0,
        'status': 'active',
        'needsReview': needsReview,
      })
      ..set(rateRef, {'lastAt': stamp})
      ..update(_db.collection('products').doc(product.id), {
        'latestPrices.${store.id}': {
          'priceId': priceRef.id,
          'storeId': store.id,
          'chainId': store.chainId,
          'branchName': store.branchName,
          'lat': store.lat,
          'lng': store.lng,
          'priceBaisa': priceBaisa,
          'isOffer': isOffer,
          'offerEndDate': offerEnd,
          'reportedAt': stamp,
          'confirmations': 0,
          'verified': false,
          'hasPhoto': photoUrl != null,
          'flags': 0,
          'reportedBy': uid,
        },
        'lastPriceAt': stamp,
        'lastPriceId': priceRef.id,
      });
    if (daily == null) {
      batch.set(dailyRef, {'count': 1, 'lastAt': stamp});
    } else {
      batch.update(dailyRef, {'count': FieldValue.increment(1), 'lastAt': stamp});
    }
    return _commit(batch);
  }

  /// "This price is still correct". Only valid for another user's price that
  /// this user hasn't confirmed yet (rules enforce it).
  Future<SubmitResult> confirm({
    required String productId,
    required LatestPrice entry,
    required String uid,
  }) {
    final key = 'latestPrices.${entry.storeId}';
    final batch = _db.batch()
      ..update(_prices.doc(entry.priceId), {
        'confirmations': FieldValue.increment(1),
        'confirmedBy': FieldValue.arrayUnion([uid]),
      })
      ..update(_db.collection('products').doc(productId), {
        '$key.confirmations': FieldValue.increment(1),
        '$key.verified': isVerified(
          confirmations: entry.confirmations + 1,
          hasPhoto: entry.hasPhoto,
        ),
        'lastPriceId': entry.priceId,
      });
    return _commit(batch);
  }

  /// One report per user per price (the report id enforces it). The 3rd flag
  /// removes the price from the product's latest prices.
  Future<SubmitResult> flag({
    required String productId,
    required LatestPrice entry,
    required String uid,
    required String reason,
  }) {
    assert(reportReasons.contains(reason));
    final key = 'latestPrices.${entry.storeId}';
    final hide = isHiddenByFlags(entry.flags + 1);
    final batch = _db.batch()
      ..set(_db.collection('reports').doc('${entry.priceId}_$uid'), {
        'priceId': entry.priceId,
        'reportedBy': uid,
        'reason': reason,
        'createdAt': FieldValue.serverTimestamp(),
      })
      ..update(_prices.doc(entry.priceId), {'flags': FieldValue.increment(1)})
      ..update(
        _db.collection('products').doc(productId),
        hide
            ? {key: FieldValue.delete(), 'lastPriceId': entry.priceId}
            : {
                '$key.flags': FieldValue.increment(1),
                'lastPriceId': entry.priceId,
              },
      );
    return _commit(batch);
  }

  /// Last [days] days of active prices for the chart (max 200 documents).
  Future<List<PricePoint>> history(String productId, {int days = 90}) async {
    final since = DateTime.now().subtract(Duration(days: days));
    final snap = await _prices
        .where('productId', isEqualTo: productId)
        .where('status', isEqualTo: 'active')
        .where('reportedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(since))
        .orderBy('reportedAt')
        .limit(200)
        .get();
    return [
      for (final d in snap.docs)
        if (!isHiddenByFlags((d['flags'] as num?)?.toInt() ?? 0))
          PricePoint(
            d['storeId'] as String,
            d['chainId'] as String,
            (d['priceBaisa'] as num).toInt(),
            (d['reportedAt'] as Timestamp).toDate(),
          ),
    ];
  }

  Future<SubmitResult> _commit(WriteBatch batch) async {
    final done = batch.commit();
    try {
      await done.timeout(const Duration(seconds: 4));
      return SubmitResult.synced;
    } on TimeoutException {
      // No signal: Firestore keeps the write queued and syncs it later.
      unawaited(
        done.catchError(
          (Object e, StackTrace s) =>
              FirebaseCrashlytics.instance.recordError(e, s),
        ),
      );
      return SubmitResult.queuedOffline;
    } on FirebaseException catch (e) {
      throw PriceException(switch (e.code) {
        'permission-denied' => PriceFailure.notAllowed,
        'unavailable' => PriceFailure.network,
        _ => PriceFailure.unknown,
      }, e);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/location/user_location.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/utils/geo.dart';
import '../domain/store.dart';

part 'store_repository.g.dart';

@Riverpod(keepAlive: true)
StoreRepository storeRepository(Ref ref) =>
    StoreRepository(FirebaseFirestore.instance);

/// A store plus how far it is from the user (null when location is unknown).
typedef StoreDistance = (Store store, double? km);

class StoreRepository {
  StoreRepository(this._db);
  final FirebaseFirestore _db;

  /// Stores within [radiusKm], nearest first. One cheap geohash range query per
  /// neighbouring cell, then an exact distance filter.
  Future<List<(Store, double)>> nearby(
    double lat,
    double lng, {
    double radiusKm = 10,
  }) async {
    final snaps = await Future.wait([
      for (final p in geohashPrefixes(lat, lng, radiusKm))
        _db
            .collection('stores')
            .orderBy('geo.geohash')
            .startAt([p])
            .endAt(['$p\uf8ff'])
            .get(),
    ]);
    final result = <(Store, double)>[];
    for (final snap in snaps) {
      for (final doc in snap.docs) {
        final store = Store.fromDoc(doc);
        final km =
            Geolocator.distanceBetween(lat, lng, store.lat, store.lng) / 1000;
        if (km <= radiusKm) result.add((store, km));
      }
    }
    return result..sort((a, b) => a.$2.compareTo(b.$2));
  }

  Future<List<Store>> byCity(String cityId) async {
    final snap = await _db
        .collection('stores')
        .where('city', isEqualTo: cityId)
        .limit(100)
        .get();
    return snap.docs.map(Store.fromDoc).toList();
  }

  /// Users can add branches that are missing. Not verified until an admin
  /// confirms it.
  Future<Store> create({
    required String uid,
    required String chainId,
    required String branchName,
    required String city,
    String? area,
    required double lat,
    required double lng,
  }) async {
    final ref = await _db.collection('stores').add({
      'chainId': chainId,
      'branchName': branchName,
      'city': city,
      'area': ?area,
      'geo': {
        'geopoint': GeoPoint(lat, lng),
        'geohash': encodeGeohash(lat, lng),
      },
      'addedBy': uid,
      'verified': false,
    });
    return Store(
      id: ref.id,
      chainId: chainId,
      branchName: branchName,
      city: city,
      area: area,
      lat: lat,
      lng: lng,
    );
  }
}

/// Stores to offer in the Add price flow: nearest within 10 km, then 50 km;
/// without location (or nothing nearby) the stores of the user's city.
@riverpod
Future<List<StoreDistance>> candidateStores(Ref ref) async {
  final repo = ref.watch(storeRepositoryProvider);
  final location = await ref.watch(userLocationProvider.future);
  if (location != null) {
    for (final radius in [10.0, 50.0]) {
      final near = await repo.nearby(location.lat, location.lng, radiusKm: radius);
      if (near.isNotEmpty) return near;
    }
  }
  final city = ref.read(settingsControllerProvider).cityId;
  if (city == null) return const [];
  return [for (final s in await repo.byCity(city)) (s, null)];
}

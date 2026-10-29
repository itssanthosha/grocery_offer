// ignore_for_file: invalid_annotation_target
// (documented freezed pattern for per-class json_serializable options)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../prices/domain/freshness.dart';
import '../../prices/domain/price_rules.dart';

part 'product.freezed.dart';
part 'product.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();
  @override
  DateTime fromJson(Object json) => (json as Timestamp).toDate();
  @override
  Object toJson(DateTime object) => Timestamp.fromDate(object);
}

class NullableTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const NullableTimestampConverter();
  @override
  DateTime? fromJson(Object? json) => (json as Timestamp?)?.toDate();
  @override
  Object? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

/// The newest price at one store. Stored inside `products.latestPrices`
/// (keyed by storeId) together with the store's name and location, so a
/// product screen needs a single document read.
@freezed
abstract class LatestPrice with _$LatestPrice {
  const factory LatestPrice({
    required String priceId,
    required String storeId,
    required String chainId,
    required String branchName,
    required double lat,
    required double lng,
    required int priceBaisa,
    @Default(false) bool isOffer,
    @NullableTimestampConverter() DateTime? offerEndDate,
    @TimestampConverter() required DateTime reportedAt,
    @Default(0) int confirmations,
    @Default(false) bool verified,
    @Default(false) bool hasPhoto,
    @Default(0) int flags,
    @Default('') String reportedBy,
  }) = _LatestPrice;

  factory LatestPrice.fromJson(Map<String, dynamic> json) =>
      _$LatestPriceFromJson(json);
}

extension LatestPriceX on LatestPrice {
  Freshness freshness([DateTime? now]) => Freshness.of(reportedAt, now: now);

  /// Hidden once older than 60 days, flagged by 3+ users, or when it was an
  /// offer that has ended.
  bool isVisible([DateTime? now]) {
    final t = now ?? DateTime.now();
    if (freshness(t).isHidden || isHiddenByFlags(flags)) return false;
    return !(isOffer && offerEndDate != null && offerEndDate!.isBefore(t));
  }
}

@freezed
abstract class Product with _$Product {
  const Product._();

  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory Product({
    @JsonKey(includeToJson: false) required String id,
    String? barcode,
    required String name,
    String? nameAr,
    String? brand,
    String? size,
    String? unit,
    required String categoryId,
    String? imageUrl,
    required String createdBy,
    @Default([]) List<String> searchKeywords,
    @Default({}) Map<String, LatestPrice> latestPrices,
    @NullableTimestampConverter() DateTime? lastPriceAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Product.fromJson({...doc.data()!, 'id': doc.id});

  String displayName(String languageCode) =>
      languageCode == 'ar' && (nameAr?.isNotEmpty ?? false) ? nameAr! : name;

  /// Visible prices, cheapest first.
  List<LatestPrice> visiblePrices([DateTime? now]) =>
      latestPrices.values.where((p) => p.isVisible(now)).toList()
        ..sort((a, b) => a.priceBaisa.compareTo(b.priceBaisa));
}

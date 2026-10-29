// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatestPrice _$LatestPriceFromJson(Map<String, dynamic> json) => _LatestPrice(
  priceId: json['priceId'] as String,
  storeId: json['storeId'] as String,
  chainId: json['chainId'] as String,
  branchName: json['branchName'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  priceBaisa: (json['priceBaisa'] as num).toInt(),
  isOffer: json['isOffer'] as bool? ?? false,
  offerEndDate: const NullableTimestampConverter().fromJson(
    json['offerEndDate'],
  ),
  reportedAt: const TimestampConverter().fromJson(json['reportedAt'] as Object),
  confirmations: (json['confirmations'] as num?)?.toInt() ?? 0,
  verified: json['verified'] as bool? ?? false,
  hasPhoto: json['hasPhoto'] as bool? ?? false,
  flags: (json['flags'] as num?)?.toInt() ?? 0,
  reportedBy: json['reportedBy'] as String? ?? '',
);

Map<String, dynamic> _$LatestPriceToJson(_LatestPrice instance) =>
    <String, dynamic>{
      'priceId': instance.priceId,
      'storeId': instance.storeId,
      'chainId': instance.chainId,
      'branchName': instance.branchName,
      'lat': instance.lat,
      'lng': instance.lng,
      'priceBaisa': instance.priceBaisa,
      'isOffer': instance.isOffer,
      'offerEndDate': const NullableTimestampConverter().toJson(
        instance.offerEndDate,
      ),
      'reportedAt': const TimestampConverter().toJson(instance.reportedAt),
      'confirmations': instance.confirmations,
      'verified': instance.verified,
      'hasPhoto': instance.hasPhoto,
      'flags': instance.flags,
      'reportedBy': instance.reportedBy,
    };

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  barcode: json['barcode'] as String?,
  name: json['name'] as String,
  nameAr: json['nameAr'] as String?,
  brand: json['brand'] as String?,
  size: json['size'] as String?,
  unit: json['unit'] as String?,
  categoryId: json['categoryId'] as String,
  imageUrl: json['imageUrl'] as String?,
  createdBy: json['createdBy'] as String,
  searchKeywords:
      (json['searchKeywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  latestPrices:
      (json['latestPrices'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, LatestPrice.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  lastPriceAt: const NullableTimestampConverter().fromJson(json['lastPriceAt']),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'barcode': ?instance.barcode,
  'name': instance.name,
  'nameAr': ?instance.nameAr,
  'brand': ?instance.brand,
  'size': ?instance.size,
  'unit': ?instance.unit,
  'categoryId': instance.categoryId,
  'imageUrl': ?instance.imageUrl,
  'createdBy': instance.createdBy,
  'searchKeywords': instance.searchKeywords,
  'latestPrices': instance.latestPrices.map((k, e) => MapEntry(k, e.toJson())),
  'lastPriceAt': ?const NullableTimestampConverter().toJson(
    instance.lastPriceAt,
  ),
};

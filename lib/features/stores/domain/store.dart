import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store.freezed.dart';

@freezed
abstract class Store with _$Store {
  const factory Store({
    required String id,
    required String chainId,
    required String branchName,
    required String city,
    String? area,
    required double lat,
    required double lng,
    @Default(false) bool verified,
  }) = _Store;

  factory Store.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    final point = (d['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint;
    return Store(
      id: doc.id,
      chainId: d['chainId'] as String,
      branchName: d['branchName'] as String,
      city: d['city'] as String,
      area: d['area'] as String?,
      lat: point.latitude,
      lng: point.longitude,
      verified: d['verified'] as bool? ?? false,
    );
  }
}

import 'package:dart_geohash/dart_geohash.dart';

final _hasher = GeoHasher();

/// Stored on every store as `geo.geohash` (precision 9, same as the seed script).
String encodeGeohash(double lat, double lng, {int precision = 9}) =>
    _hasher.encode(lng, lat, precision: precision);

/// Geohash prefixes whose cells together cover a circle of [radiusKm] around
/// the point: the centre cell plus its 8 neighbours. A cell must be wider than
/// the radius (with margin for longitude shrinking away from the equator).
/// Query each with `startAt(prefix).endAt(prefix + '\uf8ff')`, then filter by
/// exact distance.
List<String> geohashPrefixes(double lat, double lng, double radiusKm) {
  final precision = radiusKm <= 4 ? 5 : (radiusKm <= 16 ? 4 : 3);
  final center = encodeGeohash(lat, lng, precision: precision);
  return _hasher.neighbors(center).values.toSet().toList();
}

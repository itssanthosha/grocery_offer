import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/core/utils/geo.dart';
import 'package:pricemate/features/products/data/open_food_facts_client.dart';
import 'package:pricemate/features/products/domain/product.dart';

LatestPrice _price(
  String store,
  int baisa, {
  DateTime? at,
  bool offer = false,
  DateTime? offerEnd,
}) => LatestPrice(
  priceId: 'p$store',
  storeId: store,
  chainId: 'lulu',
  branchName: 'Branch $store',
  lat: 23.6,
  lng: 58.4,
  priceBaisa: baisa,
  isOffer: offer,
  offerEndDate: offerEnd,
  reportedAt: at ?? DateTime.now(),
);

void main() {
  group('Product.visiblePrices', () {
    final now = DateTime(2026, 10, 29);

    test('sorted cheapest first; >60 days and ended offers are hidden', () {
      final product = Product(
        id: 'x',
        name: 'Milk',
        categoryId: 'dairyEggs',
        createdBy: 'u',
        latestPrices: {
          'a': _price('a', 500, at: now),
          'b': _price('b', 300, at: now.subtract(const Duration(days: 40))),
          'c': _price('c', 100, at: now.subtract(const Duration(days: 61))),
          'd': _price(
            'd',
            50,
            at: now,
            offer: true,
            offerEnd: now.subtract(const Duration(days: 1)),
          ),
          'e': _price(
            'e',
            400,
            at: now,
            offer: true,
            offerEnd: now.add(const Duration(days: 3)),
          ),
        },
      );
      expect(product.visiblePrices(now).map((p) => p.storeId), ['b', 'e', 'a']);
    });

    test('Arabic display name falls back to English', () {
      const p = Product(
        id: 'x',
        name: 'Rice',
        categoryId: 'riceGrains',
        createdBy: 'u',
      );
      expect(p.displayName('ar'), 'Rice');
      expect(p.copyWith(nameAr: 'أرز').displayName('ar'), 'أرز');
      expect(p.copyWith(nameAr: 'أرز').displayName('en'), 'Rice');
    });
  });

  group('Open Food Facts', () {
    test('parses a hit, taking the first brand', () {
      final p = OpenFoodFactsClient.parse({
        'status': 1,
        'product': {
          'product_name': 'Fresh Milk',
          'brands': 'Almarai,Other',
          'quantity': '1 L',
          'image_front_small_url': 'https://img/x.jpg',
        },
      })!;
      expect(p.name, 'Fresh Milk');
      expect(p.brand, 'Almarai');
      expect(p.size, '1 L');
      expect(p.imageUrl, 'https://img/x.jpg');
    });

    test('unknown barcode or nameless product gives null', () {
      expect(OpenFoodFactsClient.parse({'status': 0}), isNull);
      expect(
        OpenFoodFactsClient.parse({
          'status': 1,
          'product': {'product_name': ' '},
        }),
        isNull,
      );
    });
  });

  group('geohash', () {
    test('matches the seed script (ngeohash) so queries find seeded stores', () {
      // node -e "require('ngeohash').encode(23.588, 58.3829, 9)"
      expect(encodeGeohash(23.588, 58.3829), 'tk1w0w14h');
    });

    test('encodes at the requested precision, nearby points share a prefix', () {
      final a = encodeGeohash(23.588, 58.3829);
      final b = encodeGeohash(23.589, 58.3835);
      expect(a, hasLength(9));
      expect(a.substring(0, 5), b.substring(0, 5));
    });

    test('9 prefixes, centre cell included', () {
      final prefixes = geohashPrefixes(23.588, 58.3829, 10);
      expect(prefixes, hasLength(9));
      expect(prefixes, contains(encodeGeohash(23.588, 58.3829, precision: 4)));
      expect(prefixes.every((p) => p.length == 4), isTrue);
    });

    test('radius picks the cell size', () {
      expect(geohashPrefixes(23.5, 58.4, 3).first.length, 5);
      expect(geohashPrefixes(23.5, 58.4, 30).first.length, 3);
    });
  });
}

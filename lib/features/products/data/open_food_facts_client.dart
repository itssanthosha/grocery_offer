import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_food_facts_client.g.dart';

@Riverpod(keepAlive: true)
OpenFoodFactsClient openFoodFactsClient(Ref ref) => OpenFoodFactsClient();

/// What Open Food Facts knows about a barcode; used only to pre-fill the
/// "new product" form.
class OffProduct {
  const OffProduct({this.name, this.nameAr, this.brand, this.size, this.imageUrl});
  final String? name;
  final String? nameAr;
  final String? brand;
  final String? size;
  final String? imageUrl;
}

class OpenFoodFactsClient {
  OpenFoodFactsClient([http.Client? client]) : _http = client ?? http.Client();
  final http.Client _http;

  /// `null` when unknown or when the lookup fails: pre-fill is a convenience
  /// and must never block adding a product by hand.
  Future<OffProduct?> lookup(String barcode) async {
    try {
      final uri = Uri.https(
        'world.openfoodfacts.org',
        '/api/v2/product/$barcode.json',
        {
          'fields':
              'product_name,product_name_en,product_name_ar,brands,quantity,image_front_small_url',
        },
      );
      final res = await _http
          .get(uri, headers: {'User-Agent': 'PriceMate/1.0 (Oman grocery prices)'})
          .timeout(const Duration(seconds: 8));
      if (res.statusCode != 200) return null;
      return parse(jsonDecode(res.body) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static OffProduct? parse(Map<String, dynamic> json) {
    if (json['status'] != 1) return null;
    final p = json['product'] as Map<String, dynamic>?;
    if (p == null) return null;
    String? clean(Object? v) {
      final s = (v as String?)?.trim();
      return s == null || s.isEmpty ? null : s;
    }

    final product = OffProduct(
      name: clean(p['product_name_en']) ?? clean(p['product_name']),
      nameAr: clean(p['product_name_ar']),
      // "Almarai,Other" -> first brand
      brand: clean((p['brands'] as String?)?.split(',').first),
      size: clean(p['quantity']),
      imageUrl: clean(p['image_front_small_url']),
    );
    return product.name == null && product.nameAr == null ? null : product;
  }
}

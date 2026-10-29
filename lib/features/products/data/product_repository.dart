import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/product.dart';
import '../domain/search_keywords.dart';

part 'product_repository.g.dart';

const pageSize = 20;

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) =>
    ProductRepository(FirebaseFirestore.instance);

class ProductPage {
  const ProductPage(this.items, this.cursor, this.hasMore);
  final List<Product> items;
  final DocumentSnapshot<Map<String, dynamic>>? cursor;
  final bool hasMore;
}

class ProductRepository {
  ProductRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _products =>
      _db.collection('products');

  Future<ProductPage> _page(
    Query<Map<String, dynamic>> query,
    DocumentSnapshot<Map<String, dynamic>>? after, {
    bool Function(Product)? where,
  }) async {
    var q = query.limit(pageSize);
    if (after != null) q = q.startAfterDocument(after);
    final snap = await q.get();
    final items = snap.docs.map(Product.fromDoc);
    return ProductPage(
      (where == null ? items : items.where(where)).toList(),
      snap.docs.lastOrNull,
      snap.docs.length == pageSize,
    );
  }

  /// English or Arabic, any word order, prefixes allowed. Firestore narrows by
  /// the longest word; the remaining words are checked on the results.
  Future<ProductPage> search(
    String input, {
    DocumentSnapshot<Map<String, dynamic>>? after,
  }) {
    final parsed = parseSearchQuery(input);
    if (parsed == null) return Future.value(const ProductPage([], null, false));
    return _page(
      _products.where('searchKeywords', arrayContains: parsed.queryToken),
      after,
      where: (p) => parsed.tokens.every(p.searchKeywords.contains),
    );
  }

  Future<ProductPage> byCategory(
    String categoryId, {
    DocumentSnapshot<Map<String, dynamic>>? after,
  }) => _page(
    _products.where('categoryId', isEqualTo: categoryId).orderBy('name'),
    after,
  );

  /// Products whose price was reported most recently.
  Future<ProductPage> recentlyUpdated({
    DocumentSnapshot<Map<String, dynamic>>? after,
  }) => _page(_products.orderBy('lastPriceAt', descending: true), after);

  Future<Product?> byBarcode(String barcode) async {
    final snap = await _products
        .where('barcode', isEqualTo: barcode)
        .limit(1)
        .get();
    return snap.docs.isEmpty ? null : Product.fromDoc(snap.docs.first);
  }

  /// One document read: includes `latestPrices`.
  Stream<Product?> watch(String id) => _products
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Product.fromDoc(d) : null);

  /// Returns the new product id. Keywords and unit are derived here so every
  /// caller stores them consistently.
  Future<String> create({
    required String createdBy,
    required String name,
    String? nameAr,
    String? brand,
    String? size,
    String? unit,
    required String categoryId,
    String? barcode,
    String? imageUrl,
  }) async {
    final product = Product(
      id: '',
      barcode: barcode,
      name: name,
      nameAr: nameAr,
      brand: brand,
      size: size,
      unit: unit,
      categoryId: categoryId,
      imageUrl: imageUrl,
      createdBy: createdBy,
      searchKeywords: buildSearchKeywords(
        name: name,
        nameAr: nameAr,
        brand: brand,
        barcode: barcode,
      ),
    );
    final ref = await _products.add(product.toJson());
    return ref.id;
  }
}

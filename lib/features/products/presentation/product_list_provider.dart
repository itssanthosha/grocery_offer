import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/product_repository.dart';
import '../domain/product.dart';

part 'product_list_provider.freezed.dart';
part 'product_list_provider.g.dart';

@freezed
sealed class ProductQuery with _$ProductQuery {
  const factory ProductQuery.recent() = RecentQuery;
  const factory ProductQuery.search(String text) = SearchQuery;
  const factory ProductQuery.category(String categoryId) = CategoryQuery;
}

@freezed
abstract class PagedProducts with _$PagedProducts {
  const factory PagedProducts({
    required List<Product> items,
    required bool hasMore,
    @Default(false) bool loadingMore,
    @Default(false) bool loadMoreFailed,
  }) = _PagedProducts;
}

/// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
/// leaving a screen drops its pages.
@riverpod
class ProductList extends _$ProductList {
  DocumentSnapshot<Map<String, dynamic>>? _cursor;

  @override
  Future<PagedProducts> build(ProductQuery query) async {
    _cursor = null;
    final page = await _fetchNonEmpty();
    return PagedProducts(items: page.items, hasMore: page.hasMore);
  }

  Future<ProductPage> _fetch() {
    final repo = ref.read(productRepositoryProvider);
    return switch (query) {
      RecentQuery() => repo.recentlyUpdated(after: _cursor),
      SearchQuery(:final text) => repo.search(text, after: _cursor),
      CategoryQuery(:final categoryId) => repo.byCategory(
        categoryId,
        after: _cursor,
      ),
    };
  }

  /// Client-side word filtering can leave a page empty even though more
  /// results exist, which would stop the scroll from ever asking for more.
  Future<ProductPage> _fetchNonEmpty() async {
    final items = <Product>[];
    for (var tries = 0; ; tries++) {
      final page = await _fetch();
      _cursor = page.cursor ?? _cursor;
      items.addAll(page.items);
      if (items.isNotEmpty || !page.hasMore || tries >= 3) {
        return ProductPage(items, _cursor, page.hasMore);
      }
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(
      current.copyWith(loadingMore: true, loadMoreFailed: false),
    );
    try {
      final page = await _fetchNonEmpty();
      state = AsyncData(
        PagedProducts(
          items: [...current.items, ...page.items],
          hasMore: page.hasMore,
        ),
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(loadingMore: false, loadMoreFailed: true),
      );
    }
  }

  /// Pull-to-refresh.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

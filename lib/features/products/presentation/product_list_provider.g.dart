// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
/// leaving a screen drops its pages.

@ProviderFor(ProductList)
final productListProvider = ProductListFamily._();

/// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
/// leaving a screen drops its pages.
final class ProductListProvider
    extends $AsyncNotifierProvider<ProductList, PagedProducts> {
  /// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
  /// leaving a screen drops its pages.
  ProductListProvider._({
    required ProductListFamily super.from,
    required ProductQuery super.argument,
  }) : super(
         retry: null,
         name: r'productListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productListHash();

  @override
  String toString() {
    return r'productListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductList create() => ProductList();

  @override
  bool operator ==(Object other) {
    return other is ProductListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productListHash() => r'8269063f2610eb50ec253506393a38117aca3c38';

/// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
/// leaving a screen drops its pages.

final class ProductListFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductList,
          AsyncValue<PagedProducts>,
          PagedProducts,
          FutureOr<PagedProducts>,
          ProductQuery
        > {
  ProductListFamily._()
    : super(
        retry: null,
        name: r'productListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
  /// leaving a screen drops its pages.

  ProductListProvider call(ProductQuery query) =>
      ProductListProvider._(argument: query, from: this);

  @override
  String toString() => r'productListProvider';
}

/// Infinite list (20 per page) for any [ProductQuery]. Auto-disposed, so
/// leaving a screen drops its pages.

abstract class _$ProductList extends $AsyncNotifier<PagedProducts> {
  late final _$args = ref.$arg as ProductQuery;
  ProductQuery get query => _$args;

  FutureOr<PagedProducts> build(ProductQuery query);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedProducts>, PagedProducts>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedProducts>, PagedProducts>,
              AsyncValue<PagedProducts>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

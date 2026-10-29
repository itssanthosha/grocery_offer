import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/widgets/error_view.dart';
import '../product_list_provider.dart';
import 'product_tile.dart';

/// Paginated, pull-to-refresh product list with skeletons and an empty state.
/// [header] scrolls with the list (the home screen puts its search bar there).
class ProductListView extends ConsumerStatefulWidget {
  const ProductListView({
    super.key,
    required this.query,
    required this.empty,
    this.header = const [],
    this.addPrice = false,
  });

  final ProductQuery query;
  final Widget empty;
  final List<Widget> header;

  /// Picking a product to add a price for: tapping goes to the Add price flow.
  final bool addPrice;

  @override
  ConsumerState<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends ConsumerState<ProductListView> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.extentAfter < 400) {
        ref.read(productListProvider(widget.query).notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final provider = productListProvider(widget.query);
    final state = ref.watch(provider);
    final header = widget.header;
    final addPrice = widget.addPrice;

    final Widget body = switch (state) {
      AsyncData(:final value) when value.items.isEmpty => widget.empty,
      AsyncData(:final value) => Column(
        children: [
          for (final p in value.items)
            ProductTile(
              product: p,
              onTap: addPrice
                  ? () => context.push('/add-price?productId=${p.id}')
                  : null,
            ),
          if (value.loadingMore) const ProductTileSkeleton(),
          if (value.loadMoreFailed)
            TextButton(
              onPressed: ref.read(provider.notifier).loadMore,
              child: Text(l.retry),
            ),
        ],
      ),
      AsyncError(:final error) when !state.hasValue => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(provider),
      ),
      _ => Column(
        children: [for (var i = 0; i < 6; i++) const ProductTileSkeleton()],
      ),
    };

    return RefreshIndicator(
      onRefresh: () => ref.read(provider.notifier).refresh(),
      child: ListView(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [...header, body],
      ),
    );
  }
}

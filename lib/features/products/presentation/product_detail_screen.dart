import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/location/user_location.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/skeleton.dart';
import '../../auth/presentation/require_sign_in.dart';
import '../../gamification/domain/points.dart';
import '../../prices/data/price_repository.dart';
import '../../prices/presentation/widgets/price_history_card.dart';
import '../../stores/domain/chain.dart';
import '../data/product_repository.dart';
import '../domain/product.dart';
import '../domain/unit_price.dart';
import 'widgets/product_tile.dart';

part 'product_detail_screen.g.dart';

@riverpod
Stream<Product?> productById(Ref ref, String id) =>
    ref.watch(productRepositoryProvider).watch(id);

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final state = ref.watch(productByIdProvider(productId));

    return Scaffold(
      appBar: AppBar(),
      body: switch (state) {
        AsyncData(value: final product?) => _Body(product: product),
        AsyncData() => EmptyState(
          icon: Icons.search_off,
          message: l.productNotFound,
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(productByIdProvider(productId)),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SkeletonBox(width: 96, height: 96, radius: 12),
              SizedBox(height: 16),
              SkeletonBox(height: 72),
              SizedBox(height: 8),
              SkeletonBox(height: 72),
            ],
          ),
        ),
      },
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final location = ref.watch(userLocationProvider).value;
    final prices = product.visiblePrices();
    final subtitle = [product.brand, product.size].whereType<String>().join(' · ');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            ProductImage(url: product.imageUrl, size: 96),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.displayName(lang), style: theme.textTheme.titleLarge),
                  if (subtitle.isNotEmpty) Text(subtitle),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          key: const ValueKey('add-price'),
          onPressed: () {
            if (requireSignIn(context, ref)) {
              context.push('/add-price?productId=${product.id}');
            }
          },
          icon: const Icon(Icons.add),
          label: Text(l.addPrice),
        ),
        const SizedBox(height: 24),
        Text(l.pricesTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (prices.isEmpty)
          EmptyState(icon: Icons.add_shopping_cart, message: l.noPricesYet)
        else
          for (final (i, price) in prices.indexed)
            _PriceCard(
              productId: product.id,
              price: price,
              size: product.size,
              isCheapest: i == 0,
              distanceKm: location == null
                  ? null
                  : Geolocator.distanceBetween(
                          location.lat,
                          location.lng,
                          price.lat,
                          price.lng,
                        ) /
                        1000,
            ),
        const SizedBox(height: 16),
        PriceHistoryCard(product: product),
      ],
    );
  }
}

class _PriceCard extends ConsumerWidget {
  const _PriceCard({
    required this.productId,
    required this.price,
    required this.size,
    required this.isCheapest,
    required this.distanceKm,
  });

  final String productId;
  final LatestPrice price;
  final String? size;
  final bool isCheapest;
  final double? distanceKm;

  void _toast(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    if (!requireSignIn(context, ref)) return;
    final uid = realUser(ref)!.uid;
    if (price.reportedBy == uid) return _toast(context, l.cantConfirmOwnPrice);
    try {
      await ref
          .read(priceRepositoryProvider)
          .confirm(productId: productId, entry: price, uid: uid);
      if (context.mounted) _toast(context, l.thanksConfirmed(Points.confirmPrice));
    } on PriceException catch (e) {
      if (context.mounted) _toast(context, e.failure.message(l));
    }
  }

  Future<void> _report(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    if (!requireSignIn(context, ref)) return;
    final uid = realUser(ref)!.uid;
    if (price.reportedBy == uid) return _toast(context, l.cantReportOwnPrice);

    final labels = {
      'wrong price': l.reasonWrongPrice,
      'wrong product': l.reasonWrongProduct,
      'spam': l.reasonSpam,
      'offer ended': l.reasonOfferEnded,
    };
    final reason = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l.reportWrongPrice, style: Theme.of(ctx).textTheme.titleMedium),
            ),
            for (final e in labels.entries)
              ListTile(
                minTileHeight: 56,
                title: Text(e.value),
                onTap: () => Navigator.pop(ctx, e.key),
              ),
          ],
        ),
      ),
    );
    if (reason == null || !context.mounted) return;
    try {
      await ref
          .read(priceRepositoryProvider)
          .flag(productId: productId, entry: price, uid: uid, reason: reason);
      if (context.mounted) _toast(context, l.thanksReported);
    } on PriceException catch (e) {
      if (context.mounted) _toast(context, e.failure.message(l));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final freshness = price.freshness();
    final unit = unitPrice(price.priceBaisa, size);
    final chain = chainById(price.chainId)?.localizedName(lang) ?? price.chainId;
    final priceColor = isCheapest ? AppColors.green : null;

    final details = <String>[
      if (distanceKm != null) l.distanceKm(distanceKm!.toStringAsFixed(1)),
      l.updatedAgo(freshness.ageDays),
      l.confirmationsCount(price.confirmations),
    ];

    return Opacity(
      opacity: freshness.isGreyedOut ? 0.5 : 1,
      child: Card(
        color: isCheapest ? Colors.green.withValues(alpha: 0.12) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isCheapest
              ? const BorderSide(color: AppColors.green, width: 2)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chain, style: theme.textTheme.titleMedium),
                        Text(price.branchName),
                        const SizedBox(height: 4),
                        Text(details.join(' · '), style: theme.textTheme.bodySmall),
                        Wrap(
                          spacing: 8,
                          children: [
                            if (price.verified)
                              Chip(
                                avatar: const Icon(Icons.verified, size: 16),
                                label: Text(l.verified),
                                visualDensity: VisualDensity.compact,
                              ),
                            if (price.isOffer)
                              Chip(
                                backgroundColor: AppColors.offerOrange,
                                label: Text(
                                  price.offerEndDate == null
                                      ? l.offer
                                      : l.offerUntil(price.offerEndDate!),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isCheapest)
                        Text(
                          l.cheapest,
                          style: theme.textTheme.labelMedium?.copyWith(color: priceColor),
                        ),
                      Text(
                        formatOmr(price.priceBaisa, languageCode: lang),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: priceColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (unit != null)
                        Text(
                          '${formatOmr(unit.baisa, languageCode: lang)} / ${switch (unit.kind) {
                            UnitKind.kg => l.unitKg,
                            UnitKind.litre => l.unitLitre,
                            UnitKind.piece => l.unitPiece,
                          }}',
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(minimumSize: const Size(0, 48)),
                      onPressed: () => _confirm(context, ref),
                      icon: const Icon(Icons.thumb_up_outlined, size: 18),
                      label: Text(l.confirmPriceCorrect, textAlign: TextAlign.center),
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(minimumSize: const Size(0, 48)),
                    onPressed: () => _report(context, ref),
                    icon: const Icon(Icons.flag_outlined, size: 18),
                    label: Text(l.report),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

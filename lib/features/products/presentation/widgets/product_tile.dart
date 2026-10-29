import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../domain/product.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.url, this.size = 64});
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: size,
      height: size,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(Icons.shopping_basket_outlined, size: size / 2),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: url == null
          ? placeholder
          : CachedNetworkImage(
              imageUrl: url!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholder: (_, _) => placeholder,
              errorWidget: (_, _, _) => placeholder,
            ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, this.onTap});
  final Product product;

  /// Defaults to opening the product page.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final cheapest = product.visiblePrices().firstOrNull;
    final subtitle = [product.brand, product.size].whereType<String>().join(' · ');

    return ListTile(
      minTileHeight: 80,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: ProductImage(url: product.imageUrl),
      title: Text(product.displayName(lang), maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      trailing: cheapest == null
          ? Text(l.noPricesShort, style: Theme.of(context).textTheme.bodySmall)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(l.fromPrice, style: Theme.of(context).textTheme.labelSmall),
                Text(
                  formatOmr(cheapest.priceBaisa, languageCode: lang),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
      onTap: onTap ?? () => context.push('/product/${product.id}'),
    );
  }
}

class ProductTileSkeleton extends StatelessWidget {
  const ProductTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        SkeletonBox(width: 64, height: 64, radius: 12),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(height: 16),
              SizedBox(height: 8),
              SkeletonBox(width: 120, height: 12),
            ],
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/empty_state.dart';
import '../../products/domain/product_category.dart';
import '../../products/presentation/product_list_provider.dart';
import '../../products/presentation/widgets/product_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.appName),
        actions: [
          IconButton(
            tooltip: l.settingsTitle,
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/search?addPrice=1'),
        icon: const Icon(Icons.add),
        label: Text(l.addPrice),
      ),
      body: ProductListView(
        query: const ProductQuery.recent(),
        empty: EmptyState(
          icon: Icons.add_shopping_cart,
          message: l.noPricesYet,
        ),
        header: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: SearchBar(
              hintText: l.searchHint,
              leading: const Icon(Icons.search),
              constraints: const BoxConstraints(minHeight: 56),
              readOnly: true,
              onTap: () => context.push('/search'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(72)),
              onPressed: () => context.push('/scan'),
              icon: const Icon(Icons.qr_code_scanner, size: 32),
              label: Text(l.scanBarcode, style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              )),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final c in ProductCategory.values)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: ActionChip(
                      avatar: Icon(c.icon, size: 18),
                      label: Text(c.label(l)),
                      onPressed: () => context.push('/category/${c.name}'),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(l.recentlyUpdated, style: theme.textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}

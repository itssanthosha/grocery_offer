import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/empty_state.dart';
import '../domain/product_category.dart';
import 'product_list_provider.dart';
import 'widgets/product_list_view.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.categoryId});
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final category = ProductCategory.fromName(categoryId);

    return Scaffold(
      appBar: AppBar(title: Text(category?.label(l) ?? l.appName)),
      body: ProductListView(
        query: ProductQuery.category(categoryId),
        empty: EmptyState(icon: Icons.inventory_2_outlined, message: l.noProductsInCategory),
      ),
    );
  }
}

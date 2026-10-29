import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/empty_state.dart';
import 'product_list_provider.dart';
import 'widgets/product_list_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.addPrice = false});

  /// Choosing a product to add a price for (instead of just browsing).
  final bool addPrice;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _text = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() => _text = value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration.collapsed(hintText: l.searchHint),
          onChanged: _onChanged,
        ),
        actions: [
          if (widget.addPrice)
            IconButton(
              tooltip: l.scanBarcode,
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () => context.push('/scan?addPrice=1'),
            ),
        ],
      ),
      body: _text.length < 2
          ? EmptyState(icon: Icons.search, message: l.searchPrompt)
          : ProductListView(
              // Keyed so a new search starts from a fresh scroll position.
              key: ValueKey(_text),
              query: ProductQuery.search(_text),
              addPrice: widget.addPrice,
              empty: EmptyState(
                icon: Icons.search_off,
                message: l.noSearchResults(_text),
                action: Column(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => context.push(
                        widget.addPrice ? '/scan?addPrice=1' : '/scan',
                      ),
                      icon: const Icon(Icons.qr_code_scanner),
                      label: Text(l.scanBarcode),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.push('/product/new'),
                      child: Text(l.addNewProduct),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

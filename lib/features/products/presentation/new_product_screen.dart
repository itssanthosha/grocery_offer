import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../auth/presentation/sign_in_gate.dart';
import '../data/open_food_facts_client.dart';
import '../data/product_repository.dart';
import '../domain/product_category.dart';
import '../domain/unit_price.dart';
import 'widgets/product_tile.dart';

/// Create a product, pre-filled from Open Food Facts when a barcode is known.
class NewProductScreen extends ConsumerStatefulWidget {
  const NewProductScreen({super.key, this.barcode});
  final String? barcode;

  @override
  ConsumerState<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _nameAr = TextEditingController();
  final _brand = TextEditingController();
  final _size = TextEditingController();
  ProductCategory? _category;
  String? _imageUrl;
  bool _lookingUp = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final code = widget.barcode;
    if (code != null) _prefill(code);
  }

  @override
  void dispose() {
    for (final c in [_name, _nameAr, _brand, _size]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _prefill(String code) async {
    setState(() => _lookingUp = true);
    final off = await ref.read(openFoodFactsClientProvider).lookup(code);
    if (!mounted) return;
    setState(() {
      _lookingUp = false;
      if (off == null) return;
      // Never overwrite what the user already typed while we were looking up.
      if (_name.text.isEmpty) _name.text = off.name ?? '';
      if (_nameAr.text.isEmpty) _nameAr.text = off.nameAr ?? '';
      if (_brand.text.isEmpty) _brand.text = off.brand ?? '';
      if (_size.text.isEmpty) _size.text = off.size ?? '';
      _imageUrl = off.imageUrl;
    });
  }

  String? _opt(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save(String uid) async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final size = _opt(_size);
      final id = await ref
          .read(productRepositoryProvider)
          .create(
            createdBy: uid,
            name: _name.text.trim(),
            nameAr: _opt(_nameAr),
            brand: _opt(_brand),
            size: size,
            unit: parseSize(size)?.kind.code,
            categoryId: _category!.name,
            barcode: widget.barcode,
            imageUrl: _imageUrl,
          );
      HapticFeedback.mediumImpact();
      // New products have no prices yet: go straight to adding the first one.
      if (mounted) context.pushReplacement('/add-price?productId=$id');
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).errorGeneric)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return SignInGate(
      title: l.newProductTitle,
      message: l.signInToAddProduct,
      builder: (context, uid) => _buildForm(context, l, uid),
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations l, String uid) {
    String? required(String? v) =>
        v == null || v.trim().isEmpty ? l.errorFieldRequired : null;

    return Scaffold(
      appBar: AppBar(title: Text(l.newProductTitle)),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_lookingUp) const LinearProgressIndicator(),
              if (widget.barcode != null) ...[
                Text('${l.barcode}: ${widget.barcode}'),
                const SizedBox(height: 12),
              ],
              if (_imageUrl != null)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ProductImage(url: _imageUrl, size: 96),
                ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: l.productName),
                textCapitalization: TextCapitalization.words,
                validator: required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameAr,
                decoration: InputDecoration(labelText: l.productNameAr),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _brand,
                decoration: InputDecoration(labelText: l.brand),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _size,
                decoration: InputDecoration(
                  labelText: l.size,
                  hintText: l.sizeHint,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ProductCategory>(
                initialValue: _category,
                decoration: InputDecoration(labelText: l.category),
                items: [
                  for (final c in ProductCategory.values)
                    DropdownMenuItem(value: c, child: Text(c.label(l))),
                ],
                onChanged: (c) => _category = c,
                validator: (c) => c == null ? l.errorFieldRequired : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : () => _save(uid),
                child: _saving
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l.saveProduct),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

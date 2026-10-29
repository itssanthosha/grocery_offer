import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../auth/presentation/sign_in_gate.dart';
import '../../gamification/domain/points.dart';
import '../../products/domain/product.dart';
import '../../products/presentation/product_detail_screen.dart';
import '../../products/presentation/widgets/product_tile.dart';
import '../../stores/data/store_repository.dart';
import '../../stores/domain/chain.dart';
import '../../stores/domain/store.dart';
import '../data/photo_uploader.dart';
import '../data/price_repository.dart';
import '../domain/price_rules.dart';
import 'widgets/celebration_dialog.dart';
import 'widgets/price_keypad.dart';

/// The most important flow: product -> store (auto) -> price -> submit.
class AddPriceScreen extends ConsumerStatefulWidget {
  const AddPriceScreen({super.key, required this.productId});
  final String productId;

  @override
  ConsumerState<AddPriceScreen> createState() => _AddPriceScreenState();
}

class _AddPriceScreenState extends ConsumerState<AddPriceScreen> {
  Store? _pickedStore;
  int _baisa = 0;
  bool _isOffer = false;
  DateTime? _offerEnd;
  XFile? _photo;
  bool _busy = false;

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickStore() async {
    final store = await context.push<Store>('/stores/pick');
    if (store != null) setState(() => _pickedStore = store);
  }

  Future<void> _takePhoto() async {
    try {
      final photo = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 2048,
      );
      if (photo != null) setState(() => _photo = photo);
    } catch (_) {
      if (mounted) _toast(AppLocalizations.of(context).cameraUnavailable);
    }
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _offerEnd ?? now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date != null) {
      // Offers run through the end of the chosen day.
      setState(() => _offerEnd = DateTime(date.year, date.month, date.day, 23, 59));
    }
  }

  Future<bool> _confirmDeviation(int? average) async {
    final l = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.areYouSure),
            content: Text(
              l.priceDeviationWarning(
                formatOmr(_baisa, languageCode: lang),
                formatOmr(average!, languageCode: lang),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.changePrice),
              ),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(120, 48)),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l.yesSubmit),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _submit(Product product, Store store, String uid) async {
    final l = AppLocalizations.of(context);
    final average = averageBaisa(product.visiblePrices().map((p) => p.priceBaisa));
    var needsReview = false;
    if (deviatesTooMuch(_baisa, average)) {
      if (!await _confirmDeviation(average)) return;
      needsReview = true;
    }

    setState(() => _busy = true);
    try {
      String? photoUrl;
      if (_photo != null) {
        photoUrl = await ref.read(photoUploaderProvider).uploadPriceTag(_photo!.path, uid);
        if (photoUrl == null) _toast(l.photoUploadFailed);
      }
      final result = await ref
          .read(priceRepositoryProvider)
          .submit(
            product: product,
            store: store,
            uid: uid,
            priceBaisa: _baisa,
            isOffer: _isOffer,
            offerEndDate: _offerEnd,
            photoUrl: photoUrl,
            needsReview: needsReview,
          );
      HapticFeedback.heavyImpact();
      if (!mounted) return;
      await showCelebration(
        context,
        points: Points.newPrice + (photoUrl != null ? Points.photoBonus : 0),
        queuedOffline: result == SubmitResult.queuedOffline,
      );
      if (!mounted) return;
      // Home underneath so Back from the product page makes sense.
      context.go('/home');
      context.push('/product/${product.id}');
    } on PriceException catch (e) {
      _toast(e.failure.message(l));
    } catch (_) {
      _toast(l.errorGeneric);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    return SignInGate(
      title: l.addPriceTitle,
      message: l.signInToAddPrice,
      builder: (context, uid) {
        final productAsync = ref.watch(productByIdProvider(widget.productId));
        final candidates = ref.watch(candidateStoresProvider).value;
        final product = productAsync.value;
        final nearest = candidates?.firstOrNull;
        final store = _pickedStore ?? nearest?.$1;
        final km = _pickedStore == null ? nearest?.$2 : null;
        final canSubmit = !_busy && product != null && store != null && isValidPrice(_baisa);

        return Scaffold(
          appBar: AppBar(title: Text(l.addPriceTitle)),
          body: SafeArea(
            child: product == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            Row(
                              children: [
                                ProductImage(url: product.imageUrl, size: 56),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    [product.displayName(lang), product.size]
                                        .whereType<String>()
                                        .join(' · '),
                                    style: theme.textTheme.titleMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Card(
                              child: ListTile(
                                minTileHeight: 64,
                                leading: const Icon(Icons.store),
                                title: Text(
                                  store == null
                                      ? l.chooseStore
                                      : chainById(store.chainId)?.localizedName(lang) ??
                                            store.chainId,
                                ),
                                subtitle: store == null
                                    ? null
                                    : Text(
                                        [
                                          store.branchName,
                                          if (km != null) l.distanceKm(km.toStringAsFixed(1)),
                                        ].join(' · '),
                                      ),
                                trailing: TextButton(
                                  onPressed: _pickStore,
                                  child: Text(l.change),
                                ),
                                onTap: _pickStore,
                              ),
                            ),
                            SwitchListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              title: Text(l.thisIsAnOffer),
                              secondary: const Icon(
                                Icons.local_offer,
                                color: AppColors.offerOrange,
                              ),
                              value: _isOffer,
                              onChanged: (v) => setState(() => _isOffer = v),
                            ),
                            if (_isOffer)
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
                                  onPressed: _pickEndDate,
                                  icon: const Icon(Icons.event),
                                  label: Text(
                                    _offerEnd == null
                                        ? l.offerEndDateOptional
                                        : l.offerUntil(_offerEnd!),
                                  ),
                                ),
                              ),
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              leading: _photo == null
                                  ? const Icon(Icons.photo_camera_outlined)
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(_photo!.path),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              title: Text(l.photoOfPriceTag),
                              subtitle: Text(l.photoBonusHint(Points.photoBonus)),
                              trailing: _photo == null
                                  ? null
                                  : IconButton(
                                      tooltip: l.remove,
                                      icon: const Icon(Icons.close),
                                      onPressed: () => setState(() => _photo = null),
                                    ),
                              onTap: _takePhoto,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          formatOmr(_baisa, languageCode: lang),
                          key: const ValueKey('price-display'),
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _baisa == 0 ? theme.disabledColor : AppColors.green,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: PriceKeypad(
                          onDigit: (d) => setState(() => _baisa = appendDigit(_baisa, d)),
                          onDelete: () => setState(() => _baisa = deleteDigit(_baisa)),
                          onClear: () => setState(() => _baisa = 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: FilledButton(
                          key: const ValueKey('submit-price'),
                          onPressed: canSubmit ? () => _submit(product, store, uid) : null,
                          child: _busy
                              ? const SizedBox.square(
                                  dimension: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(l.submitPrice),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/oman_city.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/location/user_location.dart';
import '../../../core/settings/app_settings.dart';
import '../../auth/presentation/sign_in_gate.dart';
import '../data/store_repository.dart';
import '../domain/chain.dart';

/// Adds a missing branch at the user's current location. Pops with the new
/// [Store].
class AddBranchScreen extends ConsumerStatefulWidget {
  const AddBranchScreen({super.key});

  @override
  ConsumerState<AddBranchScreen> createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends ConsumerState<AddBranchScreen> {
  final _form = GlobalKey<FormState>();
  final _branch = TextEditingController();
  final _area = TextEditingController();
  Chain? _chain;
  late OmanCity? _city = OmanCity.fromName(
    ref.read(settingsControllerProvider).cityId,
  );
  bool _saving = false;

  @override
  void dispose() {
    _branch.dispose();
    _area.dispose();
    super.dispose();
  }

  Future<void> _save(String uid) async {
    if (!_form.currentState!.validate()) return;
    final l = AppLocalizations.of(context);
    setState(() => _saving = true);
    try {
      final location = await ref.read(userLocationProvider.future);
      if (location == null) {
        _toast(l.locationNeededForBranch);
        return;
      }
      final store = await ref
          .read(storeRepositoryProvider)
          .create(
            uid: uid,
            chainId: _chain!.id,
            branchName: _branch.text.trim(),
            city: _city!.name,
            area: _area.text.trim().isEmpty ? null : _area.text.trim(),
            lat: location.lat,
            lng: location.lng,
          );
      if (mounted) context.pop(store);
    } catch (_) {
      _toast(l.errorGeneric);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    String? required(Object? v) =>
        v == null || (v is String && v.trim().isEmpty) ? l.errorFieldRequired : null;

    return SignInGate(
      title: l.addBranch,
      message: l.signInToAddBranch,
      builder: (context, uid) => Scaffold(
        appBar: AppBar(title: Text(l.addBranch)),
        body: SafeArea(
          child: Form(
            key: _form,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(l.addBranchHint),
                const SizedBox(height: 16),
                DropdownButtonFormField<Chain>(
                  initialValue: _chain,
                  decoration: InputDecoration(labelText: l.chain),
                  items: [
                    for (final c in chains)
                      DropdownMenuItem(value: c, child: Text(c.localizedName(lang))),
                  ],
                  onChanged: (c) => setState(() {
                    _chain = c;
                    if (_branch.text.isEmpty && c != null) {
                      _branch.text = c.localizedName(lang);
                    }
                  }),
                  validator: required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _branch,
                  decoration: InputDecoration(labelText: l.branchName),
                  validator: required,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<OmanCity>(
                  initialValue: _city,
                  decoration: InputDecoration(labelText: l.city),
                  items: [
                    for (final c in OmanCity.values)
                      DropdownMenuItem(value: c, child: Text(c.label(l))),
                  ],
                  onChanged: (c) => _city = c,
                  validator: required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _area,
                  decoration: InputDecoration(labelText: l.areaOptional),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _saving ? null : () => _save(uid),
                  child: _saving
                      ? const SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l.addBranch),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

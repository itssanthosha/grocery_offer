import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_view.dart';
import '../data/store_repository.dart';
import '../domain/chain.dart';
import '../domain/store.dart';

/// Pops with the chosen [Store].
class StorePickerScreen extends ConsumerWidget {
  const StorePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final stores = ref.watch(candidateStoresProvider);

    Future<void> addBranch() async {
      final store = await context.push<Store>('/stores/new');
      if (store != null && context.mounted) context.pop(store);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.chooseStore)),
      body: switch (stores) {
        AsyncData(:final value) when value.isEmpty => EmptyState(
          icon: Icons.store_outlined,
          message: l.noStoresFound,
          action: FilledButton(onPressed: addBranch, child: Text(l.addBranch)),
        ),
        AsyncData(:final value) => ListView(
          children: [
            for (final (store, km) in value)
              ListTile(
                minTileHeight: 64,
                leading: const Icon(Icons.store),
                title: Text(
                  chainById(store.chainId)?.localizedName(lang) ?? store.chainId,
                ),
                subtitle: Text(store.branchName),
                trailing: km == null
                    ? null
                    : Text(l.distanceKm(km.toStringAsFixed(1))),
                onTap: () => context.pop(store),
              ),
            ListTile(
              minTileHeight: 64,
              leading: const Icon(Icons.add_location_alt_outlined),
              title: Text(l.addBranch),
              onTap: addBranch,
            ),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(candidateStoresProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

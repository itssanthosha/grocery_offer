import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/widgets/preference_pickers.dart';
import '../../auth/data/auth_repository.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final user = ref.watch(authStateProvider).value;
    final isGuest = user == null || user.isAnonymous;

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l.language, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const LanguagePicker(),
          const SizedBox(height: 24),
          const CityPicker(),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.darkMode),
            value: settings.darkMode,
            onChanged: ref.read(settingsControllerProvider.notifier).setDarkMode,
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(isGuest ? Icons.login : Icons.logout),
            title: Text(isGuest ? l.signInPrompt : l.signOut),
            onTap: () async {
              // Sign out also drops guests back to the sign-in screen.
              if (!isGuest) await ref.read(authRepositoryProvider).signOut();
              if (context.mounted) context.go('/sign-in');
            },
          ),
        ],
      ),
    );
  }
}

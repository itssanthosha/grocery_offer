import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/settings/app_settings.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/user_repository.dart';

class PriceMateApp extends ConsumerWidget {
  const PriceMateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);

    // Create users/{uid} once for every real (non-guest) account, whichever
    // sign-in method was used.
    ref.listen(authStateProvider, (_, next) {
      final user = next.value;
      if (user != null && !user.isAnonymous) {
        ref
            .read(userRepositoryProvider)
            .ensureProfile(
              user,
              city: settings.cityId,
              language:
                  settings.languageCode ??
                  WidgetsBinding.instance.platformDispatcher.locale.languageCode,
            );
      }
    });

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      routerConfig: ref.watch(appRouterProvider),
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      locale: settings.locale, // null = follow the device
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/l10n/app_localizations.dart';
import 'core/settings/app_settings.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final settingsBox = await Hive.openBox<dynamic>(settingsBoxName);

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    // Fresh checkout without `flutterfire configure`: say so instead of crashing.
    debugPrint('Firebase init failed: $e');
    runApp(const _FirebaseSetupApp());
    return;
  }

  // Offline persistence so the app works in stores with poor signal.
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    !kDebugMode,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    ProviderScope(
      overrides: [settingsBoxProvider.overrideWithValue(settingsBox)],
      child: const PriceMateApp(),
    ),
  );
}

class _FirebaseSetupApp extends StatelessWidget {
  const _FirebaseSetupApp();

  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(
      builder: (context) {
        final l = AppLocalizations.of(context);
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l.firebaseSetupTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(l.firebaseSetupBody, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

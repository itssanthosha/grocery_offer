import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pricemate/core/settings/app_settings.dart';

void main() {
  test('settings persist and default to follow-device language', () async {
    final dir = Directory.systemTemp.createTempSync('pricemate_hive');
    Hive.init(dir.path);
    final box = await Hive.openBox<dynamic>('t');
    final container = ProviderContainer(
      overrides: [settingsBoxProvider.overrideWithValue(box)],
    );
    addTearDown(() async {
      container.dispose();
      await Hive.close();
      dir.deleteSync(recursive: true);
    });

    final s = container.read(settingsControllerProvider);
    expect(s.locale, isNull);
    expect(s.onboardingDone, isFalse);

    final c = container.read(settingsControllerProvider.notifier);
    await c.setLanguage('ar');
    await c.setCity('sohar');
    await c.completeOnboarding();

    final updated = container.read(settingsControllerProvider);
    expect(updated.locale?.languageCode, 'ar');
    expect(updated.cityId, 'sohar');
    expect(updated.onboardingDone, isTrue);

    await c.setLanguage(null);
    expect(container.read(settingsControllerProvider).locale, isNull);
  });
}

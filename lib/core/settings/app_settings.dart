import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings.g.dart';

const settingsBoxName = 'settings';

/// Opened in `main()` (and in tests) and injected via override.
@Riverpod(keepAlive: true)
Box<dynamic> settingsBox(Ref ref) => throw UnimplementedError();

@immutable
class AppSettings {
  const AppSettings({
    this.languageCode,
    this.cityId,
    this.onboardingDone = false,
    this.darkMode = false,
  });

  /// `null` = follow the device language.
  final String? languageCode;
  final String? cityId;
  final bool onboardingDone;
  final bool darkMode;

  Locale? get locale => languageCode == null ? null : Locale(languageCode!);
}

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  Box<dynamic> get _box => ref.read(settingsBoxProvider);

  @override
  AppSettings build() {
    final box = ref.watch(settingsBoxProvider);
    return AppSettings(
      languageCode: box.get('languageCode') as String?,
      cityId: box.get('cityId') as String?,
      onboardingDone: box.get('onboardingDone', defaultValue: false) as bool,
      darkMode: box.get('darkMode', defaultValue: false) as bool,
    );
  }

  Future<void> setLanguage(String? code) async {
    await (code == null
        ? _box.delete('languageCode')
        : _box.put('languageCode', code));
    ref.invalidateSelf();
  }

  Future<void> setCity(String? id) async {
    await (id == null ? _box.delete('cityId') : _box.put('cityId', id));
    ref.invalidateSelf();
  }

  Future<void> setDarkMode(bool value) async {
    await _box.put('darkMode', value);
    ref.invalidateSelf();
  }

  Future<void> completeOnboarding() async {
    await _box.put('onboardingDone', true);
    ref.invalidateSelf();
  }
}

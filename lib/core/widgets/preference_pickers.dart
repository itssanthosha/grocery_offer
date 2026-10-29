import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/oman_city.dart';
import '../l10n/app_localizations.dart';
import '../settings/app_settings.dart';

/// Device / English / Arabic. Applies immediately (and flips to RTL).
class LanguagePicker extends ConsumerWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final code = ref.watch(settingsControllerProvider).languageCode;
    return SegmentedButton<String?>(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(value: null, label: Text(l.languageSystem)),
        ButtonSegment(value: 'en', label: Text(l.languageEnglish)),
        ButtonSegment(value: 'ar', label: Text(l.languageArabic)),
      ],
      selected: {code},
      onSelectionChanged: (s) =>
          ref.read(settingsControllerProvider.notifier).setLanguage(s.first),
    );
  }
}

class CityPicker extends ConsumerWidget {
  const CityPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final city = OmanCity.fromName(ref.watch(settingsControllerProvider).cityId);
    return DropdownMenu<OmanCity>(
      expandedInsets: EdgeInsets.zero,
      label: Text(l.city),
      initialSelection: city,
      requestFocusOnTap: false,
      dropdownMenuEntries: [
        for (final c in OmanCity.values)
          DropdownMenuEntry(value: c, label: c.label(l)),
      ],
      onSelected: (c) =>
          ref.read(settingsControllerProvider.notifier).setCity(c?.name),
    );
  }
}

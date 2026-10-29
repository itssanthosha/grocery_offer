import '../l10n/app_localizations.dart';

/// Cities offered during onboarding / in settings. The enum `name` is what we
/// persist (Hive + `users/{uid}.city`).
enum OmanCity {
  muscat,
  seeb,
  bawshar,
  muttrah,
  barka,
  sohar,
  salalah,
  nizwa,
  sur,
  ibri,
  rustaq,
  buraimi,
  khasab;

  String label(AppLocalizations l) => switch (this) {
    muscat => l.cityMuscat,
    seeb => l.citySeeb,
    bawshar => l.cityBawshar,
    muttrah => l.cityMuttrah,
    barka => l.cityBarka,
    sohar => l.citySohar,
    salalah => l.citySalalah,
    nizwa => l.cityNizwa,
    sur => l.citySur,
    ibri => l.cityIbri,
    rustaq => l.cityRustaq,
    buraimi => l.cityBuraimi,
    khasab => l.cityKhasab,
  };

  static OmanCity? fromName(String? name) =>
      values.where((c) => c.name == name).firstOrNull;
}

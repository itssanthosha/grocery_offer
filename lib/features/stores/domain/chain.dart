/// Seed store chains. Bundled in the app (so they render instantly/offline);
/// `tool/seed/seed.mjs` writes the same ids to Firestore `chains/`.
class Chain {
  const Chain(this.id, this.name, this.nameAr);
  final String id;
  final String name;
  final String nameAr;

  String localizedName(String languageCode) =>
      languageCode == 'ar' ? nameAr : name;
}

const chains = <Chain>[
  Chain('lulu', 'Lulu Hypermarket', 'لولو هايبرماركت'),
  Chain('carrefour', 'Carrefour', 'كارفور'),
  Chain('nesto', 'Nesto', 'نستو'),
  Chain('alfair', 'Al Fair', 'الفير'),
  Chain('almeera', 'Al Meera', 'الميرة'),
  Chain('safeer', 'Safeer', 'السفير'),
  Chain('sultancenter', 'Sultan Center', 'مركز السلطان'),
  Chain('spar', 'Spar', 'سبار'),
  Chain('ramez', 'Ramez', 'رامز'),
  Chain('kmtrading', 'KM Trading', 'كي إم للتجارة'),
  Chain('mars', 'Mars Hypermarket', 'مارس هايبرماركت'),
];

Chain? chainById(String id) => chains.where((c) => c.id == id).firstOrNull;

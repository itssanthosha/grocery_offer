import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';

/// Fixed seed categories; `Product.categoryId` stores the enum `name`.
enum ProductCategory {
  fruitsVegetables(Icons.eco_outlined),
  dairyEggs(Icons.egg_alt_outlined),
  meatFish(Icons.set_meal_outlined),
  bakery(Icons.bakery_dining_outlined),
  riceGrains(Icons.grain),
  oilGhee(Icons.opacity),
  beverages(Icons.local_drink_outlined),
  snacks(Icons.cookie_outlined),
  babyCare(Icons.child_friendly_outlined),
  cleaning(Icons.cleaning_services_outlined),
  personalCare(Icons.spa_outlined),
  frozen(Icons.ac_unit);

  const ProductCategory(this.icon);
  final IconData icon;

  String label(AppLocalizations l) => switch (this) {
    fruitsVegetables => l.catFruitsVegetables,
    dairyEggs => l.catDairyEggs,
    meatFish => l.catMeatFish,
    bakery => l.catBakery,
    riceGrains => l.catRiceGrains,
    oilGhee => l.catOilGhee,
    beverages => l.catBeverages,
    snacks => l.catSnacks,
    babyCare => l.catBabyCare,
    cleaning => l.catCleaning,
    personalCare => l.catPersonalCare,
    frozen => l.catFrozen,
  };

  static ProductCategory? fromName(String? name) =>
      values.where((c) => c.name == name).firstOrNull;
}

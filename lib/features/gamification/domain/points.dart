/// Points awarded for each action. The server (Cloud Functions, Phase 6) is
/// the only thing that actually credits them; the app uses these numbers for
/// the "you earned" celebration.
abstract final class Points {
  static const newPrice = 10;
  static const photoBonus = 5;
  static const confirmPrice = 3;
  static const newProduct = 20;
  static const dailyStreak = 2;
}

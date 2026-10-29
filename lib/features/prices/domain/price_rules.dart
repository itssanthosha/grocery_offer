/// Price limits in baisa (1 OMR = 1000 baisa). Mirrored in firestore.rules.
const minPriceBaisa = 1;
const maxPriceBaisa = 1000000;

const flagsToHide = 3;
const maxDailySubmissions = 50;
const duplicateWindow = Duration(hours: 6);

/// "Verified": 3 confirmations from different users, or a photo plus 1
/// confirmation. Rules recompute this, so the client can't just claim it.
bool isVerified({required int confirmations, required bool hasPhoto}) =>
    confirmations >= 3 || (hasPhoto && confirmations >= 1);

bool isHiddenByFlags(int flags) => flags >= flagsToHide;

/// A new price more than 50% away from the recent average needs an
/// "Are you sure?" and is marked for review. `null` average = nothing to
/// compare with.
bool deviatesTooMuch(int newBaisa, int? averageBaisa) {
  if (averageBaisa == null || averageBaisa <= 0) return false;
  return (newBaisa - averageBaisa).abs() / averageBaisa > 0.5;
}

/// Mean of [prices], rounded, or null when empty.
int? averageBaisa(Iterable<int> prices) {
  if (prices.isEmpty) return null;
  return (prices.reduce((a, b) => a + b) / prices.length).round();
}

/// Keypad entry: digits shift in from the right, so typing 1,2,5,0 shows
/// 1.250. Ignores digits that would exceed the maximum price.
int appendDigit(int current, int digit) {
  final next = current * 10 + digit;
  return next > maxPriceBaisa ? current : next;
}

int deleteDigit(int current) => current ~/ 10;

bool isValidPrice(int baisa) =>
    baisa >= minPriceBaisa && baisa <= maxPriceBaisa;

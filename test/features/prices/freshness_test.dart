import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/features/prices/domain/freshness.dart';

void main() {
  final now = DateTime(2026, 10, 29, 12);
  Freshness at(Duration ago) => Freshness.of(now.subtract(ago), now: now);

  test('labels', () {
    expect(at(const Duration(hours: 23)).label, FreshnessLabel.today);
    expect(at(const Duration(days: 1)).label, FreshnessLabel.thisWeek);
    expect(at(const Duration(days: 6)).label, FreshnessLabel.thisWeek);
    expect(at(const Duration(days: 7)).label, FreshnessLabel.withinTwoWeeks);
    expect(at(const Duration(days: 14)).label, FreshnessLabel.older);
  });

  test('grey out after 30 days, hide after 60', () {
    expect(at(const Duration(days: 30)).isGreyedOut, isFalse);
    expect(at(const Duration(days: 31)).isGreyedOut, isTrue);
    expect(at(const Duration(days: 60)).isHidden, isFalse);
    expect(at(const Duration(days: 61)).isHidden, isTrue);
  });

  test('a future timestamp (clock skew) counts as today', () {
    expect(Freshness.of(now.add(const Duration(minutes: 5)), now: now).label,
        FreshnessLabel.today);
  });
}

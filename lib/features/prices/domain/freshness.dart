enum FreshnessLabel { today, thisWeek, withinTwoWeeks, older }

/// How trustworthy a price's age makes it. All thresholds in one place.
class Freshness {
  const Freshness._(this.ageDays);

  /// Age by elapsed time, so "reported 23h ago" is still "today".
  factory Freshness.of(DateTime reportedAt, {DateTime? now}) =>
      Freshness._((now ?? DateTime.now()).difference(reportedAt).inDays);

  final int ageDays;

  FreshnessLabel get label => switch (ageDays) {
    < 1 => FreshnessLabel.today,
    < 7 => FreshnessLabel.thisWeek,
    < 14 => FreshnessLabel.withinTwoWeeks,
    _ => FreshnessLabel.older,
  };

  /// Shown greyed out after 30 days.
  bool get isGreyedOut => ageDays > 30;

  /// Not shown at all after 60 days.
  bool get isHidden => ageDays > 60;
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../products/domain/product.dart';
import '../../../stores/domain/chain.dart';
import '../../data/price_repository.dart';

part 'price_history_card.g.dart';

@riverpod
Future<List<PricePoint>> priceHistory(Ref ref, String productId) =>
    ref.watch(priceRepositoryProvider).history(productId);

const _days = 90;
const _palette = [
  Colors.green,
  Colors.orange,
  Colors.blue,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.brown,
  Colors.pink,
];

/// Collapsed by default: the chart costs a query, so it only runs on request.
class PriceHistoryCard extends ConsumerStatefulWidget {
  const PriceHistoryCard({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<PriceHistoryCard> createState() => _PriceHistoryCardState();
}

class _PriceHistoryCardState extends ConsumerState<PriceHistoryCard> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          onPressed: () => setState(() => _open = !_open),
          icon: const Icon(Icons.show_chart),
          label: Text(_open ? l.hidePriceHistory : l.showPriceHistory),
        ),
        if (_open)
          ref
              .watch(priceHistoryProvider(widget.product.id))
              .when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => ErrorView(
                  error: e,
                  onRetry: () => ref.invalidate(priceHistoryProvider(widget.product.id)),
                ),
                data: (points) => points.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(l.noPriceHistory, textAlign: TextAlign.center),
                      )
                    : PriceHistoryChart(points: points, product: widget.product),
              ),
      ],
    );
  }
}

/// One line per store over the last 90 days.
class PriceHistoryChart extends StatelessWidget {
  const PriceHistoryChart({
    super.key,
    required this.points,
    required this.product,
    this.now,
  });

  final List<PricePoint> points;
  final Product product;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final start = (now ?? DateTime.now()).subtract(const Duration(days: _days));

    final byStore = <String, List<PricePoint>>{};
    for (final p in points) {
      byStore.putIfAbsent(p.storeId, () => []).add(p);
    }
    final stores = byStore.keys.toList();

    double x(PricePoint p) =>
        (p.reportedAt.difference(start).inMinutes / (24 * 60)).clamp(0, _days.toDouble());

    final prices = points.map((p) => p.priceBaisa);
    final minP = prices.reduce((a, b) => a < b ? a : b);
    final maxP = prices.reduce((a, b) => a > b ? a : b);
    final pad = ((maxP - minP) * 0.2).clamp(50, double.infinity);

    String label(String storeId) {
      final p = byStore[storeId]!.first;
      final chain = chainById(p.chainId)?.localizedName(lang) ?? p.chainId;
      final branch = product.latestPrices[storeId]?.branchName;
      return branch == null ? chain : '$chain - $branch';
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: Directionality(
            textDirection: TextDirection.ltr, // time runs left to right
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: _days.toDouble(),
                minY: (minP - pad).clamp(0, double.infinity).toDouble(),
                maxY: (maxP + pad).toDouble(),
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 52,
                      getTitlesWidget: (v, meta) => Text(
                        (v / 1000).toStringAsFixed(3),
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 30,
                      reservedSize: 28,
                      getTitlesWidget: (v, meta) => Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          DateFormat.MMMd(lang).format(
                            start.add(Duration(days: v.round())),
                          ),
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => [
                      for (final s in spots)
                        LineTooltipItem(
                          formatOmr(s.y.round(), languageCode: lang),
                          TextStyle(color: s.bar.color, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
                lineBarsData: [
                  for (final (i, id) in stores.indexed)
                    LineChartBarData(
                      color: _palette[i % _palette.length],
                      barWidth: 3,
                      isStepLineChart: true, // a price holds until the next report
                      spots: [
                        for (final p in byStore[id]!)
                          FlSpot(x(p), p.priceBaisa.toDouble()),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 4,
          children: [
            for (final (i, id) in stores.indexed)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 12, color: _palette[i % _palette.length]),
                  const SizedBox(width: 6),
                  Text(label(id), style: theme.textTheme.bodySmall),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

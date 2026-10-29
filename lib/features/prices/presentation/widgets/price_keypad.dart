import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Big-button numeric keypad for one-handed entry. The caller formats the
/// value (digits shift in from the right, see `appendDigit`).
class PriceKeypad extends StatelessWidget {
  const PriceKeypad({
    super.key,
    required this.onDigit,
    required this.onDelete,
    required this.onClear,
  });

  final void Function(int digit) onDigit;
  final VoidCallback onDelete;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    Widget key(Widget child, VoidCallback onTap, {VoidCallback? onLongPress, Key? k}) =>
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              height: 56,
              child: FilledButton.tonal(
                key: k,
                style: FilledButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onTap();
                },
                onLongPress: onLongPress,
                child: child,
              ),
            ),
          ),
        );

    Widget digit(int d) => key(
      Text('$d', style: Theme.of(context).textTheme.headlineSmall),
      () => onDigit(d),
      k: ValueKey('key-$d'),
    );

    return Directionality(
      // Digits keep a calculator layout in Arabic too.
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          for (final row in [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
          ])
            Row(children: [for (final d in row) digit(d)]),
          Row(
            children: [
              key(
                Text('00', style: Theme.of(context).textTheme.headlineSmall),
                () {
                  onDigit(0);
                  onDigit(0);
                },
                k: const ValueKey('key-00'),
              ),
              digit(0),
              key(
                const Icon(Icons.backspace_outlined),
                onDelete,
                onLongPress: onClear,
                k: const ValueKey('key-delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

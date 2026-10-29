import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// "+15 points!" with a small pop-and-count animation. Closes itself.
Future<void> showCelebration(
  BuildContext context, {
  required int points,
  bool queuedOffline = false,
}) => showDialog<void>(
  context: context,
  barrierDismissible: true,
  builder: (_) => _CelebrationDialog(points: points, queuedOffline: queuedOffline),
);

class _CelebrationDialog extends StatefulWidget {
  const _CelebrationDialog({required this.points, required this.queuedOffline});
  final int points;
  final bool queuedOffline;

  @override
  State<_CelebrationDialog> createState() => _CelebrationDialogState();
}

class _CelebrationDialogState extends State<_CelebrationDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              builder: (_, t, child) => Transform.scale(scale: t, child: child),
              child: const Icon(
                Icons.celebration,
                size: 88,
                color: AppColors.offerOrange,
              ),
            ),
            const SizedBox(height: 16),
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: widget.points),
              duration: const Duration(milliseconds: 800),
              builder: (_, v, _) => Text(
                l.pointsEarned(v),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.queuedOffline ? l.savedOffline : l.thanksForSharing,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

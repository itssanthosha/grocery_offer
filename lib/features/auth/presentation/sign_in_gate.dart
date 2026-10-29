import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/empty_state.dart';
import '../data/auth_repository.dart';
import 'require_sign_in.dart';

/// Shows [builder] for real accounts; guests get a "sign in to continue"
/// prompt instead. Rebuilds as soon as the user signs in.
class SignInGate extends ConsumerWidget {
  const SignInGate({
    super.key,
    required this.message,
    required this.builder,
    this.title,
  });

  final String message;
  final String? title;
  final Widget Function(BuildContext context, String uid) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final user = ref.watch(authStateProvider).value;
    if (user != null && !user.isAnonymous) return builder(context, user.uid);

    return Scaffold(
      appBar: AppBar(title: title == null ? null : Text(title!)),
      body: Center(
        child: EmptyState(
          icon: Icons.lock_outline,
          message: message,
          action: FilledButton(
            onPressed: () => requireSignIn(context, ref),
            child: Text(l.signInPrompt),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../data/auth_repository.dart';
import 'auth_ui.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key, this.from});

  /// Where to return after signing in (set when a guest hit a gated action).
  final String? from;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool _busy = false;

  /// Runs [action] with a busy lock; on success non-anonymous users are moved
  /// to /home by the router, guests are moved here.
  Future<void> _run(Future<Object?> Function(AuthRepository) action) async {
    setState(() => _busy = true);
    try {
      await action(ref.read(authRepositoryProvider));
      if (mounted) context.go(widget.from ?? '/home');
    } catch (e) {
      if (mounted) showAuthError(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.shopping_basket_rounded,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l.signInTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l.signInSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: _busy
                        ? null
                        : () => _run((r) => r.signInWithGoogle()),
                    icon: const Icon(Icons.login),
                    label: Text(l.continueWithGoogle),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _busy ? null : () => context.push(Uri(path: '/sign-in/phone', queryParameters: {if (widget.from != null) 'from': widget.from!}).toString()),
                    icon: const Icon(Icons.phone_android),
                    label: Text(l.continueWithPhone),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _busy
                        ? null
                        : () => _run((r) => r.signInAnonymously()),
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: Text(l.continueAsGuest),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l.signInGuestHint,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                  if (_busy) ...[
                    const SizedBox(height: 24),
                    const Center(child: CircularProgressIndicator()),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

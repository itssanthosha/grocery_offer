import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../domain/auth_failure.dart';

/// Shows a localized, user-friendly message for [error] (nothing if the user
/// simply cancelled).
void showAuthError(BuildContext context, Object error) {
  final l = AppLocalizations.of(context);
  final message = error is AuthException
      ? error.failure.message(l)
      : l.errorGeneric;
  if (message == null) return;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

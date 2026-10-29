import '../../../core/l10n/app_localizations.dart';

enum AuthFailure {
  cancelled,
  network,
  invalidPhone,
  invalidCode,
  tooManyRequests,
  accountDisabled,
  unknown;

  /// `null` for cancellations: the user knows they backed out, so no message.
  String? message(AppLocalizations l) => switch (this) {
    cancelled => null,
    network => l.errorNetwork,
    invalidPhone => l.errorInvalidPhone,
    invalidCode => l.errorInvalidCode,
    tooManyRequests => l.errorTooManyRequests,
    accountDisabled => l.errorAccountDisabled,
    unknown => l.errorGeneric,
  };
}

class AuthException implements Exception {
  const AuthException(this.failure, [this.cause]);
  final AuthFailure failure;
  final Object? cause;

  @override
  String toString() => 'AuthException($failure, $cause)';
}

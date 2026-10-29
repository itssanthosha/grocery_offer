// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Guests (anonymous users) may browse everything; they only see /sign-in when
/// they ask for it (e.g. before adding a price). A real account never sees it.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Guests (anonymous users) may browse everything; they only see /sign-in when
/// they ask for it (e.g. before adding a price). A real account never sees it.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Guests (anonymous users) may browse everything; they only see /sign-in when
  /// they ask for it (e.g. before adding a price). A real account never sees it.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'0bc8c007e778f2ff769318340cfc3a6c6697a9cf';

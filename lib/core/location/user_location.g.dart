// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's position, or `null` when location is off/denied/unavailable.
/// Callers show prices without distances in that case. Re-read with
/// `ref.invalidate(userLocationProvider)`.

@ProviderFor(userLocation)
final userLocationProvider = UserLocationProvider._();

/// The user's position, or `null` when location is off/denied/unavailable.
/// Callers show prices without distances in that case. Re-read with
/// `ref.invalidate(userLocationProvider)`.

final class UserLocationProvider
    extends $FunctionalProvider<AsyncValue<LatLng?>, LatLng?, FutureOr<LatLng?>>
    with $FutureModifier<LatLng?>, $FutureProvider<LatLng?> {
  /// The user's position, or `null` when location is off/denied/unavailable.
  /// Callers show prices without distances in that case. Re-read with
  /// `ref.invalidate(userLocationProvider)`.
  UserLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocationHash();

  @$internal
  @override
  $FutureProviderElement<LatLng?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LatLng?> create(Ref ref) {
    return userLocation(ref);
  }
}

String _$userLocationHash() => r'c2c67a34bf1677eb42fec37b9f8edecd9c91cda5';

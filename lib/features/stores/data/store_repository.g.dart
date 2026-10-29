// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storeRepository)
final storeRepositoryProvider = StoreRepositoryProvider._();

final class StoreRepositoryProvider
    extends
        $FunctionalProvider<StoreRepository, StoreRepository, StoreRepository>
    with $Provider<StoreRepository> {
  StoreRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storeRepositoryHash();

  @$internal
  @override
  $ProviderElement<StoreRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StoreRepository create(Ref ref) {
    return storeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StoreRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StoreRepository>(value),
    );
  }
}

String _$storeRepositoryHash() => r'0d92cad044cf666d175202c8353b16000bd65402';

/// Stores to offer in the Add price flow: nearest within 10 km, then 50 km;
/// without location (or nothing nearby) the stores of the user's city.

@ProviderFor(candidateStores)
final candidateStoresProvider = CandidateStoresProvider._();

/// Stores to offer in the Add price flow: nearest within 10 km, then 50 km;
/// without location (or nothing nearby) the stores of the user's city.

final class CandidateStoresProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StoreDistance>>,
          List<StoreDistance>,
          FutureOr<List<StoreDistance>>
        >
    with
        $FutureModifier<List<StoreDistance>>,
        $FutureProvider<List<StoreDistance>> {
  /// Stores to offer in the Add price flow: nearest within 10 km, then 50 km;
  /// without location (or nothing nearby) the stores of the user's city.
  CandidateStoresProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'candidateStoresProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$candidateStoresHash();

  @$internal
  @override
  $FutureProviderElement<List<StoreDistance>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StoreDistance>> create(Ref ref) {
    return candidateStores(ref);
  }
}

String _$candidateStoresHash() => r'18ea5183a920e8f6c99a50994f93ffaa4c31e25f';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(priceRepository)
final priceRepositoryProvider = PriceRepositoryProvider._();

final class PriceRepositoryProvider
    extends
        $FunctionalProvider<PriceRepository, PriceRepository, PriceRepository>
    with $Provider<PriceRepository> {
  PriceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'priceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$priceRepositoryHash();

  @$internal
  @override
  $ProviderElement<PriceRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PriceRepository create(Ref ref) {
    return priceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PriceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PriceRepository>(value),
    );
  }
}

String _$priceRepositoryHash() => r'e19f0d57f767b567b485f35110b2446773f59bc8';

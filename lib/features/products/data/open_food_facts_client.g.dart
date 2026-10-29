// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_food_facts_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(openFoodFactsClient)
final openFoodFactsClientProvider = OpenFoodFactsClientProvider._();

final class OpenFoodFactsClientProvider
    extends
        $FunctionalProvider<
          OpenFoodFactsClient,
          OpenFoodFactsClient,
          OpenFoodFactsClient
        >
    with $Provider<OpenFoodFactsClient> {
  OpenFoodFactsClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openFoodFactsClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openFoodFactsClientHash();

  @$internal
  @override
  $ProviderElement<OpenFoodFactsClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenFoodFactsClient create(Ref ref) {
    return openFoodFactsClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenFoodFactsClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenFoodFactsClient>(value),
    );
  }
}

String _$openFoodFactsClientHash() =>
    r'7c6b211621b89c03fa6d90ad9022a1c4122667a1';

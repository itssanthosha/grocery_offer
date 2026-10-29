// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_history_card.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(priceHistory)
final priceHistoryProvider = PriceHistoryFamily._();

final class PriceHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PricePoint>>,
          List<PricePoint>,
          FutureOr<List<PricePoint>>
        >
    with $FutureModifier<List<PricePoint>>, $FutureProvider<List<PricePoint>> {
  PriceHistoryProvider._({
    required PriceHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'priceHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$priceHistoryHash();

  @override
  String toString() {
    return r'priceHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PricePoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PricePoint>> create(Ref ref) {
    final argument = this.argument as String;
    return priceHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PriceHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$priceHistoryHash() => r'ae8c7c14a0c94b27557d1019fe101fd6088c52f0';

final class PriceHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<PricePoint>>, String> {
  PriceHistoryFamily._()
    : super(
        retry: null,
        name: r'priceHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PriceHistoryProvider call(String productId) =>
      PriceHistoryProvider._(argument: productId, from: this);

  @override
  String toString() => r'priceHistoryProvider';
}

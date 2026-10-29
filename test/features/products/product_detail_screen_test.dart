import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/core/l10n/app_localizations.dart';
import 'package:pricemate/core/location/user_location.dart';
import 'package:pricemate/core/theme/app_theme.dart';
import 'package:pricemate/features/products/domain/product.dart';
import 'package:pricemate/features/products/presentation/product_detail_screen.dart';

LatestPrice _price(String chain, String branch, int baisa, {int confirmations = 0}) =>
    LatestPrice(
      priceId: '$chain$branch',
      storeId: '$chain$branch',
      chainId: chain,
      branchName: branch,
      lat: 23.6,
      lng: 58.4,
      priceBaisa: baisa,
      reportedAt: DateTime.now().subtract(const Duration(days: 2)),
      confirmations: confirmations,
    );

Widget _app(Product? product, Locale locale) => ProviderScope(
  overrides: [
    productByIdProvider('p1').overrideWith((ref) => Stream.value(product)),
    userLocationProvider.overrideWith((ref) async => null),
  ],
  child: MaterialApp(
    theme: AppTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const ProductDetailScreen(productId: 'p1'),
  ),
);

void main() {
  final product = Product(
    id: 'p1',
    name: 'Fresh Milk',
    nameAr: '\u062d\u0644\u064a\u0628 \u0637\u0627\u0632\u062c',
    brand: 'Almarai',
    size: '500 ml',
    categoryId: 'dairyEggs',
    createdBy: 'u',
    latestPrices: {
      'a': _price('lulu', 'Qurum', 450, confirmations: 3),
      'b': _price('nesto', 'Seeb', 300),
    },
  );

  testWidgets('cheapest first, highlighted, with price and unit price', (tester) async {
    await tester.pumpWidget(_app(product, const Locale('en')));
    await tester.pumpAndSettle();

    expect(find.text('Fresh Milk'), findsOneWidget);
    expect(find.text('OMR 0.300'), findsOneWidget);
    expect(find.text('OMR 0.600 / litre'), findsOneWidget); // 300 baisa per 500 ml
    expect(find.text('Cheapest'), findsOneWidget);
    expect(find.textContaining('3 confirmations'), findsOneWidget);
    expect(find.textContaining('Updated 2 days ago'), findsNWidgets(2));

    // Nesto (OMR 0.300) is listed above Lulu (OMR 0.450).
    final nesto = tester.getTopLeft(find.text('Nesto')).dy;
    final lulu = tester.getTopLeft(find.text('Lulu Hypermarket')).dy;
    expect(nesto, lessThan(lulu));
  });

  testWidgets('Arabic: RTL, Arabic name and chain, 3-decimal currency', (tester) async {
    await tester.pumpWidget(_app(product, const Locale('ar')));
    await tester.pumpAndSettle();

    expect(
      Directionality.of(tester.element(find.byType(ProductDetailScreen))),
      TextDirection.rtl,
    );
    expect(find.text('\u062d\u0644\u064a\u0628 \u0637\u0627\u0632\u062c'), findsOneWidget);
    expect(find.text('0.300 \u0631.\u0639.'), findsOneWidget);
  });

  testWidgets('product without prices shows the encouraging empty state', (tester) async {
    await tester.pumpWidget(
      _app(product.copyWith(latestPrices: const {}), const Locale('en')),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('No prices yet \u2014 be the first to add one and earn 10 points!'),
      findsOneWidget,
    );
  });

  testWidgets('missing product', (tester) async {
    await tester.pumpWidget(_app(null, const Locale('en')));
    await tester.pumpAndSettle();
    expect(find.text('This product no longer exists.'), findsOneWidget);
  });
}

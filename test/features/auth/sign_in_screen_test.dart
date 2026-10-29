import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pricemate/core/l10n/app_localizations.dart';
import 'package:pricemate/core/theme/app_theme.dart';
import 'package:pricemate/features/auth/data/auth_repository.dart';
import 'package:pricemate/features/auth/domain/auth_failure.dart';
import 'package:pricemate/features/auth/presentation/sign_in_screen.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

Widget _app(AuthRepository repo, Locale locale) => ProviderScope(
  overrides: [authRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(
    theme: AppTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const SignInScreen(),
  ),
);

void main() {
  testWidgets('Arabic renders RTL and shows localized error', (tester) async {
    final repo = _MockAuthRepository();
    when(
      repo.signInWithGoogle,
    ).thenThrow(const AuthException(AuthFailure.network));

    await tester.pumpWidget(_app(repo, const Locale('ar')));

    expect(find.text('المتابعة عبر جوجل'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(SignInScreen))),
      TextDirection.rtl,
    );

    await tester.tap(find.text('المتابعة عبر جوجل'));
    await tester.pumpAndSettle();

    expect(
      find.text('لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.'),
      findsOneWidget,
    );
  });

  testWidgets('English is LTR', (tester) async {
    await tester.pumpWidget(_app(_MockAuthRepository(), const Locale('en')));
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(SignInScreen))),
      TextDirection.ltr,
    );
  });
}

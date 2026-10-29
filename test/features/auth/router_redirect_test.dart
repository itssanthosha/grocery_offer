import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pricemate/app.dart';
import 'package:pricemate/core/router/app_router.dart';
import 'package:pricemate/core/settings/app_settings.dart';
import 'package:pricemate/features/auth/data/auth_repository.dart';
import 'package:pricemate/features/auth/data/user_repository.dart';
import 'package:pricemate/features/auth/presentation/sign_in_screen.dart';
import 'package:pricemate/features/home/presentation/home_screen.dart';
import 'package:pricemate/features/products/data/product_repository.dart';
import 'package:pricemate/features/onboarding/presentation/onboarding_screen.dart';

class _MockUser extends Mock implements User {}

class _MockUserRepository extends Mock implements UserRepository {}

class _MockProductRepository extends Mock implements ProductRepository {}

void main() {
  setUpAll(() => registerFallbackValue(_MockUser()));

  testWidgets('onboarding -> sign-in -> home (real account)', (tester) async {
    final users = StreamController<User?>();
    final user = _MockUser();
    when(() => user.isAnonymous).thenReturn(false);
    when(() => user.displayName).thenReturn('Aisha');
    final userRepo = _MockUserRepository();
    when(
      () => userRepo.ensureProfile(
        any(),
        city: any(named: 'city'),
        language: any(named: 'language'),
      ),
    ).thenAnswer((_) async {});

    final productRepo = _MockProductRepository();
    when(() => productRepo.recentlyUpdated(after: any(named: 'after'))).thenAnswer(
      (_) async => const ProductPage([], null, false),
    );

    final dir = Directory.systemTemp.createTempSync('pricemate_router');
    late Box<dynamic> box;
    await tester.runAsync(() async {
      Hive.init(dir.path);
      box = await Hive.openBox<dynamic>('t');
    });
    addTearDown(() async {
      await users.close();
      await tester.runAsync(Hive.close);
      dir.deleteSync(recursive: true);
    });

    final container = ProviderContainer(
      overrides: [
        settingsBoxProvider.overrideWithValue(box),
        authStateProvider.overrideWith((ref) => users.stream),
        userRepositoryProvider.overrideWithValue(userRepo),
        productRepositoryProvider.overrideWithValue(productRepo),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PriceMateApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingScreen), findsOneWidget);

    // Finishing onboarding, auth still loading -> splash spinner.
    await tester.runAsync(
      () => container
          .read(settingsControllerProvider.notifier)
          .completeOnboarding(),
    );
    await tester.pump();
    expect(find.byType(OnboardingScreen), findsNothing);

    // No user -> sign-in.
    users.add(null);
    await tester.pumpAndSettle();
    expect(find.byType(SignInScreen), findsOneWidget);

    // Real account appears -> home, profile created.
    users.add(user);
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    verify(
      () => userRepo.ensureProfile(
        user,
        city: any(named: 'city'),
        language: any(named: 'language'),
      ),
    ).called(1);

    // A guest can still open /sign-in; a real account is bounced to /home.
    container.read(appRouterProvider).go('/sign-in');
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}

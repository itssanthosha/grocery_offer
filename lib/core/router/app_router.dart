import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/phone_sign_in_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/prices/presentation/add_price_screen.dart';
import '../../features/products/presentation/category_screen.dart';
import '../../features/products/presentation/new_product_screen.dart';
import '../../features/products/presentation/product_detail_screen.dart';
import '../../features/products/presentation/scan_screen.dart';
import '../../features/products/presentation/search_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/stores/presentation/add_branch_screen.dart';
import '../../features/stores/presentation/store_picker_screen.dart';
import '../settings/app_settings.dart';

part 'app_router.g.dart';

/// Guests (anonymous users) may browse everything; they only see /sign-in when
/// they ask for it (e.g. before adding a price). A real account never sees it.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ValueNotifier(0);
  ref.onDispose(refresh.dispose);
  ref.listen(settingsControllerProvider, (prev, next) {
    if (prev?.onboardingDone != next.onboardingDone) refresh.value++;
  });
  ref.listen(authStateProvider, (_, _) => refresh.value++);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (!ref.read(settingsControllerProvider).onboardingDone) {
        return loc == '/onboarding' ? null : '/onboarding';
      }
      final auth = ref.read(authStateProvider);
      if (auth.isLoading) return loc == '/splash' ? null : '/splash';

      final user = auth.value;
      if (user == null) {
        return loc.startsWith('/sign-in') ? null : '/sign-in';
      }
      final inAuthFlow = loc == '/splash' ||
          loc == '/onboarding' ||
          (loc.startsWith('/sign-in') && !user.isAnonymous);
      if (!inAuthFlow) return null;
      // A real account at /sign-in goes back to where the guest came from.
      return loc.startsWith('/sign-in')
          ? state.uri.queryParameters['from'] ?? '/home'
          : '/home';
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, _) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(
        path: '/sign-in',
        builder: (_, s) => SignInScreen(from: s.uri.queryParameters['from']),
        routes: [
          GoRoute(
            path: 'phone',
            builder: (_, s) =>
                PhoneSignInScreen(from: s.uri.queryParameters['from']),
          ),
        ],
      ),
      GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: '/search',
        builder: (_, s) =>
            SearchScreen(addPrice: s.uri.queryParameters['addPrice'] == '1'),
      ),
      GoRoute(
        path: '/scan',
        builder: (_, s) =>
            ScanScreen(addPrice: s.uri.queryParameters['addPrice'] == '1'),
      ),
      GoRoute(
        path: '/add-price',
        builder: (_, s) =>
            AddPriceScreen(productId: s.uri.queryParameters['productId']!),
      ),
      GoRoute(path: '/stores/pick', builder: (_, _) => const StorePickerScreen()),
      GoRoute(path: '/stores/new', builder: (_, _) => const AddBranchScreen()),
      GoRoute(
        path: '/category/:id',
        builder: (_, s) => CategoryScreen(categoryId: s.pathParameters['id']!),
      ),
      // Declared before /product/:id so 'new' isn't read as an id.
      GoRoute(
        path: '/product/new',
        builder: (_, s) =>
            NewProductScreen(barcode: s.uri.queryParameters['barcode']),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (_, s) => ProductDetailScreen(productId: s.pathParameters['id']!),
      ),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
    ],
  );
}

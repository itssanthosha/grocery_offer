import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/auth_repository.dart';

/// The signed-in, non-guest user, or `null`.
User? realUser(WidgetRef ref) {
  final user = ref.read(authStateProvider).value;
  return user == null || user.isAnonymous ? null : user;
}

/// Guests can browse, but adding/confirming/reporting needs an account.
/// Returns true if the user may proceed; otherwise opens sign-in and returns
/// false. After signing in the user lands back on the current page.
bool requireSignIn(BuildContext context, WidgetRef ref) {
  if (realUser(ref) != null) return true;
  final from = GoRouterState.of(context).uri.toString();
  context.push(Uri(path: '/sign-in', queryParameters: {'from': from}).toString());
  return false;
}

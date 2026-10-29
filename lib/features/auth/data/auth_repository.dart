import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/auth_failure.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(FirebaseAuth.instance, GoogleSignIn.instance);

/// Wraps Firebase Auth. Every method throws [AuthException] only.
///
/// Guests are anonymous Firebase users; signing in with Google/phone while
/// anonymous *links* the credential so the uid (and anything it owns) is kept.
class AuthRepository {
  AuthRepository(this._auth, this._google);

  final FirebaseAuth _auth;
  final GoogleSignIn _google;
  Future<void>? _googleInit;

  /// Also fires when an anonymous user is upgraded (unlike `authStateChanges`).
  Stream<User?> userChanges() => _auth.userChanges();

  Future<User> signInAnonymously() => _guard(() async {
    final cred = await _auth.signInAnonymously();
    return cred.user!;
  });

  Future<User> signInWithGoogle() => _guard(() async {
    await (_googleInit ??= _google.initialize());
    final account = await _google.authenticate();
    final credential = GoogleAuthProvider.credential(
      idToken: account.authentication.idToken,
    );
    return _signInOrLink(credential);
  });

  /// Starts SMS verification. Returns the verification id to pass to
  /// [confirmSmsCode], or `null` if Android auto-verified and signed us in.
  Future<String?> sendSmsCode(String e164Phone) {
    final result = Completer<String?>();
    _auth.verifyPhoneNumber(
      phoneNumber: e164Phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        try {
          await _signInOrLink(credential);
          if (!result.isCompleted) result.complete(null);
        } catch (e, s) {
          if (!result.isCompleted) result.completeError(_map(e), s);
        }
      },
      verificationFailed: (e) {
        if (!result.isCompleted) result.completeError(_map(e));
      },
      codeSent: (id, _) {
        if (!result.isCompleted) result.complete(id);
      },
      codeAutoRetrievalTimeout: (_) {},
    ).catchError((Object e) {
      if (!result.isCompleted) result.completeError(_map(e));
    });
    return result.future;
  }

  Future<User> confirmSmsCode(String verificationId, String smsCode) =>
      _guard(
        () => _signInOrLink(
          PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          ),
        ),
      );

  Future<void> signOut() async {
    await _auth.signOut();
    if (_googleInit != null) await _google.signOut();
  }

  Future<User> _signInOrLink(AuthCredential credential) async {
    final current = _auth.currentUser;
    if (current != null && current.isAnonymous) {
      try {
        return (await current.linkWithCredential(credential)).user!;
      } on FirebaseAuthException catch (e) {
        // Account already exists: sign into it (guest data is just browsing).
        if (e.code != 'credential-already-in-use' &&
            e.code != 'email-already-in-use') {
          rethrow;
        }
      }
    }
    return (await _auth.signInWithCredential(credential)).user!;
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw _map(e);
    }
  }

  AuthException _map(Object e) {
    if (e is AuthException) return e;
    if (e is GoogleSignInException) {
      return AuthException(
        e.code == GoogleSignInExceptionCode.canceled ||
                e.code == GoogleSignInExceptionCode.interrupted
            ? AuthFailure.cancelled
            : AuthFailure.unknown,
        e,
      );
    }
    if (e is FirebaseAuthException) {
      return AuthException(switch (e.code) {
        'network-request-failed' => AuthFailure.network,
        'invalid-phone-number' ||
        'missing-phone-number' => AuthFailure.invalidPhone,
        'invalid-verification-code' ||
        'invalid-verification-id' ||
        'session-expired' ||
        'code-expired' => AuthFailure.invalidCode,
        'too-many-requests' || 'quota-exceeded' => AuthFailure.tooManyRequests,
        'user-disabled' => AuthFailure.accountDisabled,
        _ => AuthFailure.unknown,
      }, e);
    }
    return AuthException(AuthFailure.unknown, e);
  }
}

@Riverpod(keepAlive: true)
Stream<User?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).userChanges();

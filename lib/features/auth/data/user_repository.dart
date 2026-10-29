import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) =>
    UserRepository(FirebaseFirestore.instance);

class UserRepository {
  UserRepository(this._db);
  final FirebaseFirestore _db;

  /// Creates `users/{uid}` on first sign-in. points/trustScore start at their
  /// defaults; after Phase 3 rules, only Cloud Functions may change them.
  /// Never blocks sign-in: a failure here is logged and retried next sign-in.
  Future<void> ensureProfile(
    User user, {
    String? city,
    required String language,
  }) async {
    try {
      final doc = _db.collection('users').doc(user.uid);
      if ((await doc.get()).exists) return;
      await doc.set({
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        'city': city,
        'points': 0,
        'trustScore': 50,
        'reportsCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'isBanned': false,
        'language': language,
      });
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}

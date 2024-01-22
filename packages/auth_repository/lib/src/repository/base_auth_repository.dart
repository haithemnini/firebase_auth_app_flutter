import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  /// The [user] stream is used to get the user.
  Stream<auth.User?> get user;

  /// The [signUp] method is used to sign up.
  Future<auth.User?> signUp({required String email, required String password});

  /// The [signIn] method is used to sign in.
  Future<void> signIn({required String email, required String password});

  /// The [signInWithGoogle] method is used to sign in with google.
  Future<void> signUpWithGoogle();

  /// The [restorePassword] method is used to restore password.
  Future<void> restorePassword({required String email});

  /// The [verifyEmail] method is used to verify email.
  Future<bool> verifyEmail();

  Future<void> signOut();
}

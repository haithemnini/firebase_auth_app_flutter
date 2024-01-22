import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/exception/firebase_exception.dart';
import './base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  AuthRepository([auth.FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn])
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  /// The [firebaseAuth] is used to create an instance of [FirebaseAuth].
  final auth.FirebaseAuth _firebaseAuth;

  /// The [googleSignIn] is used to create an instance of [GoogleSignIn].
  final GoogleSignIn _googleSignIn;

  /// The [user] method is used to get user.
  @override
  Stream<auth.User?> get user => _firebaseAuth.authStateChanges();

  /// The [signUp] method is used to sign up.
  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      throw SignUpFailure.fromCode(e.code);
    } catch (e) {
      debugPrint('FirebaseAuthException: $e');
      throw const SignUpFailure();
    }
  }

  /// The [signUpWithGoogle] method is used to sign up with google.
  /// It returns the user.
  @override
  Future<auth.User?> signUpWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      debugPrint('userCredential: ${userCredential.user}');

      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      throw SignUpOrSignInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      debugPrint('FirebaseAuthException: $e');
      throw const SignUpOrSignInWithGoogleFailure();
    }
  }

  /// The [signIn] method is used to sign in.
  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code);
    } catch (e) {
      throw const SignInFailure();
    }
  }

  /// The [restorePassword] method is used to restore password.
  @override
  Future<void> restorePassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (e) {
      throw ForgotPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const ForgotPasswordFailure();
    }
  }

  /// The [verifyEmail] method is used to verify email.
  @override
  Future<bool> verifyEmail() async {
    try {
      auth.User user = _firebaseAuth.currentUser!;
      await user.reload();
      user = _firebaseAuth.currentUser!;

      if (user.emailVerified) {
        debugPrint('Email verified');
        return true;
      } else {
        debugPrint('Sending email verification');
        await user.sendEmailVerification();
        return false;
      }
    } on auth.FirebaseAuthException catch (e) {
      debugPrint('VerifyEmailFailure: ${e.code}');
      throw VerifyEmailFailure.fromCode(e.code);
    } catch (e) {
      debugPrint('VerifyEmailFailure: $e');
      throw const VerifyEmailFailure();
    }
  }

  /// The [signOut] method is used to sign out.
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

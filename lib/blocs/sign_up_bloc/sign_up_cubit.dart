import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const SignUpState.initial());

  /// The [AuthRepository] class is used to manage the authentication.
  final AuthRepository _authRepository;

  /// The [UserRepository] class is used to manage the user.
  final UserRepository _userRepository;

  /// The [GlobalKey] is used to identify the [Form] and
  final formKey = GlobalKey<FormState>();

  /// The [TextEditingController] is used to control the text being edited.
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// The [init] method is used to initialize.
  void init() {
    emailController.clear();
    fullNameController.clear();
    passwordController.clear();
  }

  /// The [signUp] method is used to sign up.
  void signUp() async {
    if (!formKey.currentState!.validate()) return;

    emit(const SignUpState.loading());

    try {
      final user = await _authRepository.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      /// The [createUser] method is used to create user.
      await createUser(user!);

      emit(const SignUpState.success());
      //
    } on SignUpFailure catch (errorMsg) {
      emit(SignUpState.failure(errorMsg.message));
    } on Exception catch (errorMsg) {
      emit(SignUpState.failure(errorMsg.toString()));
    }
  }

  /// The [signUpWithGoogle] method is used to sign up with google.
  /// It returns the user.
  void signUpWithGoogle() async {
    emit(const SignUpState.loading());
    try {
      final user = await _authRepository.signUpWithGoogle();

      /// The [createUser] method is used to create user.
      await createUser(user!);

      emit(const SignUpState.success());
    } on SignUpOrSignInWithGoogleFailure catch (errorMsg) {
      emit(SignUpState.failure(errorMsg.message));
    } on Exception catch (errorMsg) {
      emit(SignUpState.failure(errorMsg.toString()));
    }
  }

  ///The [verifyEmail] method is used to verify email.
  Future<void> verifyEmail() async {
    try {
      await _authRepository.verifyEmail();
    } on VerifyEmailFailure catch (errorMsg) {
      emit(SignUpState.failure(errorMsg.message));
    } on Exception catch (errorMsg) {
      emit(SignUpState.failure(errorMsg.toString()));
    }
  }

  /// The [dispose] method is used to clean up resources.
  @override
  Future<void> close() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    return super.close();
  }

  /// The [createUser] method is used to create user.
  Future<void> createUser(auth.User user) async {
    debugPrint('Creating user with id: ${user.uid}');
    await _userRepository.createUser(
      User(
        id: user.uid,
        email: user.email ?? emailController.text.trim(),
        fullName: user.displayName ?? fullNameController.text.trim(),
        photoUrl: user.photoURL,
      ),
    );
  }
}

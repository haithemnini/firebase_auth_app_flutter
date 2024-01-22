import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cache_repository/cache_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const SignInState.initial());

  /// The [AuthRepository] class is used to manage the authentication.
  final AuthRepository _authRepository;

  /// The [UserRepository] class is used to manage the user.
  // ignore: unused_field
  final UserRepository _userRepository;

  /// The [CashRepository] class is used to manage the cache.
  final CashRepository _cacheRepository = CashRepository();

  /// The [GlobalKey] is used to identify the [Form] and
  final formKey = GlobalKey<FormState>();

  /// The [isRemember] is used to identify the [Form] and
  bool isRemember = false;

  /// The [TextEditingController] is used to control the text being edited.
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// The [init] method is used to initialize.
  void init() {
    emailController.clear();
    passwordController.clear();
  }

  /// The [signIn] method is used to sign up.
  void signIn() async {
    if (!formKey.currentState!.validate()) return;

    /// The [showLoaderDialog] method is used to show loader dialog.
    emit(const SignInState.loading());
    try {
      await _authRepository.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      /// The [_saveCache] method is used to save cache.
      _saveCache();
      emit(const SignInState.success());
    } on SignInFailure catch (errorMsg) {
      emit(SignInState.failure(errorMsg.message));
    } on Exception catch (errorMsg) {
      emit(SignInState.failure(errorMsg.toString()));
    }
  }

  /// The [signInWithGoogle] method is used to sign in with google.
  /// It returns the user.
  void signInWithGoogle() async {
    emit(const SignInState.loading());
    try {
      await _authRepository.signUpWithGoogle();

      emit(const SignInState.success());
    } on SignUpOrSignInWithGoogleFailure catch (error) {
      debugPrint('error: $error');
      emit(SignInState.failure(error.message));
    } on Exception catch (error) {
      emit(SignInState.failure(error.toString()));
    }
  }

  /// The [signOut] method is used to sign out.
  void signOut() async {
    try {
      await _authRepository.signOut();
      emit(const SignInState.success());
    } on SignOutFailure catch (error) {
      emit(SignInState.failure(error.message));
    } on Exception catch (error) {
      emit(SignInState.failure(error.toString()));
    }
  }

  /// The [close] method is used to close.
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  /// The [fetchCache] method is used to fetch cache.
  void fetchCache() async {
    if (isRemember) {
      _fetchCacheData();
    } else {
      init();
    }
  }

  /// The [onRememberChanged] method is used to onRememberChanged.
  void onRememberChanged(bool value) {
    isRemember = value;
    emit(SignInState.remember(isRemember));
  }

  /// The [saveCache] method is used to save cache.
  void _saveCache() async {
    isRemember ? _saveDataUser() : _cacheRepository.deleteUser();
  }

  /// The [_fetchCacheData] method is used to fetch cache data.
  void _fetchCacheData() async {
    try {
      isRemember = await _cacheRepository.getChekRemember();
      final Map<String, String> user = await _cacheRepository.getUser();
      emailController.text = user['email']!;
      passwordController.text = user['password']!;
      emit(SignInState.remember(isRemember));
    } on Exception catch (e) {
      debugPrint('error: $e');
      emit(const SignInState.failure('An unexpected error occurred.'));
    }
  }

  /// The [saveUser] method is used to save user.
  Future<void> _saveDataUser() async {
    await _cacheRepository.saveUser(
      emailController.text,
      passwordController.text,
      isRemember,
    );
  }
}

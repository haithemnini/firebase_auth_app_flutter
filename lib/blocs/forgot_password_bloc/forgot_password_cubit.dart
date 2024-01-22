import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState.initial());

  /// The [GlobalKey] is used to identify the [Form] and validate the form.
  final formKey = GlobalKey<FormState>();

  /// The [TextEditingController] is used to control the text being edited.
  final emailController = TextEditingController();

  /// The [init] method is used to initialize.
  void init() {
    emailController.clear();
  }

  /// The [restorePassword] method is used to restore password.
  void restorePassword() async {
    if (!formKey.currentState!.validate()) return;

    /// The [showLoaderDialog] method is used to show loader dialog.
    emit(const ForgotPasswordState.loading());
    try {
      await _authRepository.restorePassword(
        email: emailController.text.trim(),
      );
      emit(const ForgotPasswordState.success());
    } on ForgotPasswordFailure catch (errorMsg) {
      emit(ForgotPasswordState.failure(errorMsg.message));
    } on Exception catch (errorMsg) {
      emit(ForgotPasswordState.failure(errorMsg.toString()));
    }
  }

  /// The [dispose] method is used to clean up resources.
  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}

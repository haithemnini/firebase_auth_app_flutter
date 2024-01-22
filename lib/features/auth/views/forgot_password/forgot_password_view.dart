import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/blocs.dart';
import '../../../../core/extensions/extensions.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          state.maybeMap(
            loading: (_) => context.showLoaderDialog(),
            failure: (state) {
              context.showToastMsg(state.errorMessage);
            },
            success: (_) => {
              context.showToastMsg('Password reset link sent to your email'),
              context.hideLoaderDialog(),
              context.pop(),
            },
            orElse: () => {},
          );
        },
        child: _buidBody(context),
      ),
    );
  }

  Widget _buidBody(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        reverse: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _forgotHeader(),
                  SizedBox(height: 50.h),
                  const ForgotPasswordForm(),
                  SizedBox(height: 24.h),
                  _resetPasswordButton(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  CustomElevatedButton _resetPasswordButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'Password Reset',
      onPressed: () => context.read<ForgotPasswordCubit>().restorePassword(),
    );
  }

  CustomHeader _forgotHeader() {
    return const CustomHeader(
      title: 'Forgot Password?',
      subtitle: 'Enter your email address to get the password reset link.',
    );
  }
}

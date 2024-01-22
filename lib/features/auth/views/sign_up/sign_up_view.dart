import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/extensions/extensions.dart';

import '../../../../blocs/blocs.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({
    super.key,
    required this.onSignedUp,
  });

  final VoidCallback onSignedUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) => state.maybeMap(
          loading: (_) => context.showLoaderDialog(),
          failure: (error) {
            context.showToastMsg(error.errorMessage);
            context.hideLoaderDialog();
            return;
          },
          success: (_) => context.hideLoaderDialog(),
          orElse: () => {},
        ),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  _signUpHeader(),
                  SizedBox(height: 50.h),
                  const SignUpForm(),
                  const TermsAndConditionsText(),
                  SizedBox(height: 8.h),
                  SizedBox(height: 8.0.h),
                  _signUpButton(context),
                  SizedBox(height: 24.h),
                  const CustomAuthDivider('or'),
                  _signUpWithGoogleButton(context),
                  SizedBox(height: 12.h),
                  const Spacer(),
                  AlreadyHaveAccountText(onTap: onSignedUp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomHeader _signUpHeader() =>
      const CustomHeader(title: 'Create an account');

  CustomElevatedButton _signUpButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'Sign up',
      onPressed: () => context.read<SignUpCubit>().signUp(),
    );
  }

  CustomElevatedButton _signUpWithGoogleButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'Continue with Google',
      color: context.appColors.mainLightGreyOne,
      icon: SvgPicture.asset('assets/svgs/google.svg'),
      onPressed: () {
        context.read<SignUpCubit>().signUpWithGoogle();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../blocs/sign_in_bloc/sign_in_cubit.dart';
import '../../../../core/extensions/extensions.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class SignInView extends StatelessWidget {
  const SignInView({
    super.key,
    required this.onSignedIn,
  });

  final VoidCallback? onSignedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInCubit, SignInState>(
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
                  _signInHeader(),
                  SizedBox(height: 50.h),
                  const SignInForm(),
                  const CheckRemindMe(),
                  SizedBox(height: 10.h),
                  _signInButton(context),
                  SizedBox(height: 24.h),
                  const CustomAuthDivider('or sign in with'),
                  _signInWithGoogleButton(context),
                  const Spacer(),
                  _createAccountButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomTextButton _createAccountButton() {
    return CustomTextButton(
      text: 'Create an account',
      onPressed: onSignedIn,
    );
  }

  CustomElevatedButton _signInWithGoogleButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'Continue with Google',
      color: context.appColors.mainLightGreyOne,
      icon: SvgPicture.asset('assets/svgs/google.svg'),
      onPressed: () => context.read<SignInCubit>().signInWithGoogle(),
    );
  }

  CustomElevatedButton _signInButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'Login',
      onPressed: () => context.read<SignInCubit>().signIn(),
    );
  }

  CustomHeader _signInHeader() {
    return const CustomHeader(
      title: 'Login',
      subtitle: 'Welcome back to the app',
    );
  }
}

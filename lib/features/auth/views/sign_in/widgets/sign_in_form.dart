import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/helpers/app_regex_helpers.dart';
import '../../../../../core/routing/routing.dart';
import '../../../widgets/widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isVisiblePassword = false;

  @override
  void initState() {
    /// Fetch cache data from [SignInCubit] cubit.
    /// This is used to autofill the form.
    context.read<SignInCubit>().fetchCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
      child: Column(
        children: [
          /// Email
          const CustomHeaderTextField(title: 'Email Address'),
          CustomTextFormField(
            hintText: 'hello@example.com',
            controller: context.read<SignInCubit>().emailController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty || !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
          ),
          SizedBox(height: 24.h),

          /// Password
          CustomHeaderTextField(
            title: 'Password',
            subtitle: GestureDetector(
              child: Text(
                'Forgot Password?',
                style: context.font14BlueMedium.copyWith(
                  fontSize: 12.sp,
                ),
              ),
              onTap: () => context.pushNamed(Routes.forgotPassword),
            ),
          ),
          CustomTextFormField(
            hintText: '',
            controller: context.read<SignInCubit>().passwordController,
            textInputType: TextInputType.visiblePassword,
            suffixIcon: buildIconPassword(),
            obscureText: !_isVisiblePassword,
            validator: (value) {
              if (value.isEmpty || !AppRegex.isPasswordValid(value)) {
                return 'Please enter a valid password';
              }
            },
          ),
          // SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget buildIconPassword() {
    return IconButton(
      onPressed: () => _togglePasswordVisibility(_isVisiblePassword),
      icon: Icon(
        _isVisiblePassword
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
      ),
    );
  }

  void _togglePasswordVisibility(isVisiblePassword) {
    setState(() => _isVisiblePassword = !_isVisiblePassword);
  }
}

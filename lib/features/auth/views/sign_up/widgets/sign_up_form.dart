import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../core/helpers/app_regex_helpers.dart';
import '../../../widgets/widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isVisiblePassword = false;

  @override
  void initState() {
    context.read<SignUpCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        children: [
          const CustomHeaderTextField(title: 'Name'),
          CustomTextFormField(
            hintText: 'John Doe',
            controller: context.read<SignUpCubit>().fullNameController,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmpty) return 'Please enter your name';
            },
          ),
          SizedBox(height: 24.h),
          const CustomHeaderTextField(title: 'Email Address'),
          CustomTextFormField(
            hintText: 'hello@example.com',
            controller: context.read<SignUpCubit>().emailController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty || !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
          ),
          SizedBox(height: 24.h),
          const CustomHeaderTextField(title: 'Password'),
          CustomTextFormField(
            hintText: '',
            textInputType: TextInputType.visiblePassword,
            controller: context.read<SignUpCubit>().passwordController,
            validator: (value) {
              if (value.isEmpty || !AppRegex.isPasswordValid(value)) {
                return 'Please enter a valid password';
              }
            },
            suffixIcon: buildIconPassword(),
            obscureText: !_isVisiblePassword,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget buildIconPassword() => IconButton(
        onPressed: () => _togglePasswordVisibility(_isVisiblePassword),
        icon: Icon(
          _isVisiblePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      );

  void _togglePasswordVisibility(isVisiblePassword) =>
      setState(() => _isVisiblePassword = !_isVisiblePassword);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../core/helpers/app_regex_helpers.dart';
import '../../../widgets/widgets.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  @override
  void initState() {
    context.read<ForgotPasswordCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ForgotPasswordCubit>().formKey,
      child: Column(
        children: [
          const CustomHeaderTextField(title: 'Email Address'),
          CustomTextFormField(
            hintText: 'hello@example.com',
            controller: context.read<ForgotPasswordCubit>().emailController,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty || !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buidBody(context),
    );
  }

  Widget _buidBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/verify_email.svg',
            height: 200.h,
          ),
          SizedBox(height: 48.h),
          const Text(
            'We\'ve sent you a verification email, please check your inbox and follow the instructions to verify your account\n\nThank you for signing up with us!',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          CustomTextButton(
            text: 'Sgin Out',
            onPressed: () {
              context.read<SignInCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}

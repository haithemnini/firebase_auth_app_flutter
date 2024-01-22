import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 48.h,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            context.appColors.mainBlue,
          ),
          overlayColor: MaterialStateProperty.all(
            context.appColors.mainBlue.withOpacity(0.1),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 30.w),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: context.font14BlueMedium,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.color,
    this.onPressed,
    required this.text,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 48.h,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            context.appColors.mainWhite,
          ),
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all(
            color ?? context.appColors.mainBlue,
          ),
          overlayColor: MaterialStateProperty.all(
            color == null
                ? context.appColors.mainWhite.withOpacity(0.1)
                : context.appColors.mainDarkGrey.withOpacity(0.1),
          ),
        ),
        onPressed: onPressed,
        icon: icon ?? const SizedBox(),
        label: Text(
          text,
          style: color == null
              ? context.font14WhiteMedium
              : context.font14DarkRegular,
        ),
      ),
    );
  }
}

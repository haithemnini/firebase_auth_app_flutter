import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class CustomHeaderTextField extends StatelessWidget {
  const CustomHeaderTextField({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: context.font12BlackMedium),
          subtitle ?? Container(),
        ],
      ),
    );
  }
}

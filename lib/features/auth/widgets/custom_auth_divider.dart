import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class CustomAuthDivider extends StatelessWidget {
  const CustomAuthDivider(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: context.appColors.mainDarkGrey.withOpacity(0.25),
            ),
          ),
          SizedBox(width: 16.w),
          Text(title, style: context.font13GreyRegular),
          SizedBox(width: 16.w),
          Expanded(
            child: Divider(
              color: context.appColors.mainDarkGrey.withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}

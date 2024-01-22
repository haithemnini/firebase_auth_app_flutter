import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.font28BlackBold),
          SizedBox(height: 8.h),
          Text(subtitle ?? '', style: context.font16GreyRegular),
        ],
      ),
    );
  }
}

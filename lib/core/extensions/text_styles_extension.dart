// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/themes_manager.dart';

extension TextStylesContextExtension on BuildContext {
  static const String _fontFamily = 'Inter';

  // Returns the [AppColors] of the current [BuildContext]'s theme.
  AppTheme get appColors => ThemesManager.applyTheme(this);

  static const FontWeight _bold = FontWeight.w700;
  static const FontWeight _light = FontWeight.w300;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _regular = FontWeight.w400;
  static const FontWeight _semiBold = FontWeight.w600;
  static const FontWeight _extraBold = FontWeight.w800;
  static const FontWeight _extraLight = FontWeight.w200;

  TextStyle get font28BlackBold => TextStyle(
        fontSize: 28.sp,
        fontWeight: _bold,
        color: appColors.mainBlack,
        fontFamily: _fontFamily,
      );

  TextStyle get font14WhiteMedium => TextStyle(
        fontSize: 14.sp,
        fontWeight: _medium,
        color: appColors.mainWhite,
        fontFamily: _fontFamily,
      );

  TextStyle get font14DarkRegular => TextStyle(
      fontSize: 14.sp,
      fontWeight: _regular,
      color: appColors.mainDarkGrey,
      fontFamily: _fontFamily);

  TextStyle get font14BlueMedium => TextStyle(
      fontSize: 14.sp,
      fontWeight: _medium,
      color: appColors.mainBlue,
      fontFamily: _fontFamily);

  TextStyle get font12BlackMedium => TextStyle(
      fontSize: 12.sp,
      fontWeight: _medium,
      color: appColors.mainBlack,
      fontFamily: _fontFamily);

  TextStyle get font16GreyRegular => TextStyle(
      fontSize: 16.sp,
      fontWeight: _regular,
      color: appColors.mainDarkGrey,
      fontFamily: _fontFamily);

  TextStyle get font14LightGreyThreeRegular => TextStyle(
      fontSize: 14.sp,
      fontWeight: _regular,
      color: appColors.mainLightGreyThree,
      fontFamily: _fontFamily);

  TextStyle get font13Blacklight => TextStyle(
      fontSize: 13.sp,
      fontWeight: _light,
      color: appColors.mainBlack,
      fontFamily: _fontFamily);

  TextStyle get font13BlueRegular => TextStyle(
      fontSize: 13.sp,
      fontWeight: _regular,
      color: appColors.mainBlue,
      fontFamily: _fontFamily);

  TextStyle get font13BlueSemiBold => TextStyle(
      fontSize: 13.sp,
      fontWeight: _semiBold,
      color: appColors.mainBlue,
      fontFamily: _fontFamily);

  TextStyle get font13GreyRegular => TextStyle(
        fontSize: 13.sp,
        fontWeight: _regular,
        color: appColors.mainGrey,
        fontFamily: _fontFamily,
      );
}

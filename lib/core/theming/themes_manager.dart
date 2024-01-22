import 'package:flutter/material.dart';

@immutable
class ThemesManager {
  const ThemesManager._();

  static AppTheme applyTheme(BuildContext context) => _getTheme(
        Theme.of(context).brightness == Brightness.light
            ? ThemeMode.light
            : ThemeMode.dark,
      );

  static AppTheme _getTheme(ThemeMode themeMode) {
    return AppTheme.fromTheme(themeMode);
  }
}

@immutable
class AppTheme {
  final Color mainBlue;
  final Color mainBlack;
  final Color mainWhite;
  final Color mainGrey;
  final Color mainDarkGrey;
  final Color mainLightGrey;
  final Color mainLightGreyOne;
  final Color mainLightGreyTwo;
  final Color mainLightGreyThree;
  final Color mainRed;

  const AppTheme({
    required this.mainBlue,
    required this.mainBlack,
    required this.mainWhite,
    required this.mainGrey,
    required this.mainDarkGrey,
    required this.mainLightGrey,
    required this.mainLightGreyOne,
    required this.mainLightGreyTwo,
    required this.mainLightGreyThree,
    required this.mainRed,
  });

  factory AppTheme.fromTheme(ThemeMode themeMode) {
    return themeMode == ThemeMode.light
        ? ThemeColors.lightColorTheme
        : ThemeColors.darkColorTheme;
  }
}

@immutable
class ThemeColors {
  const ThemeColors._();

  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color scaffoldBackgroundColorDark = Color(0xFF191D23);

  static const AppTheme lightColorTheme = AppTheme(
    mainBlue: Color(0xFF2F4EFF),
    mainBlack: Color(0xFF191D23),
    mainWhite: Color(0xFFFFFFFF),
    mainGrey: Color(0xFF999DA3),
    mainDarkGrey: Color(0xFF4B5768),
    mainLightGrey: Color(0xFFD0D5DD),
    mainLightGreyOne: Color(0xFFE4E7EB),
    mainLightGreyTwo: Color(0xFFEBEEF2),
    mainLightGreyThree: Color(0xFF928FA6),
    mainRed: Color(0xFFEB5757),
  );

  static const AppTheme darkColorTheme = AppTheme(
    mainBlue: Color(0xFF2F4EFF),
    mainBlack: Color(0xFFFFFFFF),
    mainWhite: Color(0xFFFFFFFF),
    mainGrey: Color(0xFF999DA3),
    mainDarkGrey: Color(0xFFFFFFFF),
    mainLightGrey: Color(0xFFD0D5DD),
    mainLightGreyOne: Color(0xFF4B5768),
    mainLightGreyTwo: Color(0xFFEBEEF2),
    mainLightGreyThree: Color(0xFF928FA6),
    mainRed: Color(0xFFEB5757),
  );
}

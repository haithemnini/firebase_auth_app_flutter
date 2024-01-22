import 'package:flutter/material.dart';

import 'themes_manager.dart';

class AppTheming {
  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,
    brightness: Brightness.light,
    fontFamily: 'Inter',
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColorDark,
    brightness: Brightness.dark,
    fontFamily: 'Inter',
  );
}

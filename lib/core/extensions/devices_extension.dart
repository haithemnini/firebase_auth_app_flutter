// Extension on [BuildContext] build context to provide easy access Context Extension.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../helpers/overlay_system_ui_helpers.dart';
import './extensions.dart';

extension DevicesContextExtension on BuildContext {
  // Returns the current [ThemeData] of the [BuildContext].
  ThemeData get _theme => Theme.of(this);

  // Sets the system UI overlay based on the current [BuildContext].
  void overlaySystemUiConfig() => OverlaySystemUiConfig.overlaySystemUi(this);

  // Calculates the screen height based on the current [BuildContext] and a given value.
  double screenHeight(double value) => ScreenUtil().screenHeight * value;

  // Calculates the screen width based on the current [BuildContext] and a given value.
  double screenWidth(double value) => ScreenUtil().screenWidth * value;

  // Returns the [TextTheme] of the current [BuildContext]'s theme.
  TextTheme get textTheme => _theme.textTheme;

  // Returns the [ColorScheme] of the current [BuildContext]'s theme.
  ColorScheme get colorScheme => _theme.colorScheme;

  // Returns the size of the current [BuildContext]'s device.
  Size get deviceSize => MediaQuery.sizeOf(this);

  // Returns the width of the current [BuildContext]'s device.
  double get deviceWidth => deviceSize.width;

  // Returns the height of the current [BuildContext]'s device.
  bool isDarkTheme() => _theme.brightness == Brightness.dark;

  //hide loader dialog
  void hideLoaderDialog() => Navigator.of(this).pop();

  Future<void> showLoaderDialog() => showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: Align(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150, maxHeight: 120),
              child: AlertDialog(
                elevation: 0,
                contentPadding: EdgeInsets.zero,
                content: Center(
                  child: CircularProgressIndicator(
                    color: appColors.mainBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // Shows a toast with the given message and optional color.
  void showToastMsg(String message) => showToast(
        message,
        context: this,
        animation: StyledToastAnimation.fade,
        position: const StyledToastPosition(
          align: Alignment.bottomCenter,
          offset: 80.0,
        ),
        reverseAnimation: StyledToastAnimation.fade,
        borderRadius: BorderRadius.all(Radius.circular(32.0.w)),
        textStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
      );
}

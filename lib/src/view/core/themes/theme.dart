import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor1,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark(
      secondary: AppColors.secondaryColor,
    ),
    fontFamily: 'Poppins',
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionHandleColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(.2),
    ),
  );
}

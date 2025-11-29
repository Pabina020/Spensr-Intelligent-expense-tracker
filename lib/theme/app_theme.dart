import 'package:flutter/material.dart';
import 'package:spensr/theme/app_colors.dart';

class AppTheme {
  /// DARK THEME
  static ThemeData dark(AppColors colors) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Poppins",

      scaffoldBackgroundColor: colors.backgroundColor,
      primaryColor: colors.primary,

      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        surface: colors.containerBG,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.containerBG,
        hintStyle: TextStyle(color: colors.secondaryGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.containerBG2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }

  /// LIGHT THEME (optional)
  static ThemeData light(AppColors colors) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Poppins",
      scaffoldBackgroundColor: Colors.white,
      primaryColor: colors.primary,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        surface: Colors.white,
      ),
    );
  }
}

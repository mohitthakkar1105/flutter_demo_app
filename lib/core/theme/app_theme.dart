import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surfaceLight,
        onPrimary: AppColors.white,
        onSurface: AppColors.textPrimaryLight,
        error: AppColors.error,
      ),
      textTheme: _textTheme(AppColors.textPrimaryLight, AppColors.textSecondaryLight),
      dividerColor: AppColors.borderLight,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surfaceDark,
        onPrimary: AppColors.white,
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
      ),
      textTheme: _textTheme(AppColors.textPrimaryDark, AppColors.textSecondaryDark),
      dividerColor: AppColors.borderDark,
    );
  }

  static TextTheme _textTheme(Color primaryText, Color secondaryText) {
    return TextTheme(
      bodyLarge: TextStyle(color: primaryText),
      bodyMedium: TextStyle(color: primaryText),
      bodySmall: TextStyle(color: secondaryText),
      titleLarge: TextStyle(color: primaryText, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: primaryText, fontWeight: FontWeight.w600),
    );
  }
}
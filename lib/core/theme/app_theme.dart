import 'package:flutter/material.dart';
import 'package:sia/core/constants/app_colors.dart';
import 'package:sia/core/theme/app_text_style.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: AppTextStyles.fontFamily,
      cardColor: AppColors.cardLight,
      dividerColor: AppColors.borderLight,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        background: AppColors.backgroundLight,
        surface: AppColors.cardLight,
        onPrimary: Colors.white,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.largeTitle(
          color: AppColors.textPrimaryLight,
        ) as TextStyle?,
        titleLarge: AppTextStyles.sectionTitle(
          color: AppColors.textPrimaryLight,
        ) as TextStyle?,
        titleMedium: AppTextStyles.cardTitle(color: AppColors.textPrimaryLight) as TextStyle?,
        bodyLarge: AppTextStyles.bodyText(color: AppColors.textSecondaryLight) as TextStyle?,
        labelSmall: AppTextStyles.caption(color: AppColors.textSecondaryLight) as TextStyle?,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
        titleTextStyle:
            AppTextStyles.sectionTitle(color: AppColors.textPrimaryLight)
                as TextStyle?,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      fontFamily: AppTextStyles.fontFamily,
      cardColor: AppColors.cardDark,
      dividerColor: AppColors.borderDark,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        background: AppColors.backgroundDark,
        surface: AppColors.cardDark,
        onPrimary: Colors.white,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.largeTitle(
          color: AppColors.textPrimaryDark,
        ) as TextStyle?,
        titleLarge: AppTextStyles.sectionTitle(
          color: AppColors.textPrimaryDark,
        ) as TextStyle?,
        titleMedium: AppTextStyles.cardTitle(color: AppColors.textPrimaryDark) as TextStyle?,
        bodyLarge: AppTextStyles.bodyText(color: AppColors.textSecondaryDark) as TextStyle?,
        labelSmall: AppTextStyles.caption(color: AppColors.textSecondaryDark) as TextStyle?,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
        titleTextStyle:
            AppTextStyles.sectionTitle(color: AppColors.textPrimaryDark)
                as TextStyle?,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
      ),
    );
  }
}

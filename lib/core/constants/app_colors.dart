import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF26A69A);
  static const Color primaryLight = Color(0xFFE0F2F1);
  static const Color primaryDark = Color(0xFF00695C);

  static const Color background = Color(0xFFF7F7FB);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1E1E2D);
  static const Color textSecondary = Color(0xFF8E8EA9);
  static const Color textHint = Color(0xFFB4B4C6);

  static const Color studyColor = Color(0xFF7C6FF0);
  static const Color studyBg = Color(0xFFEDEBFC);

  static const Color timeColor = Color(0xFF3B82F6);
  static const Color timeBg = Color(0xFFE3EEFF);

  static const Color coursesColor = Color(0xFF22C55E);
  static const Color coursesBg = Color(0xFFE3F9EC);

  static const Color workColor = Color(0xFFF97316);
  static const Color workBg = Color(0xFFFFEEE0);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF97316);
  static const Color info = Color(0xFF3B82F6);
  static const Color danger = Color(0xFFEF4444);

  static const Color border = Color(0xFFEDEDF3);
  static const Color divider = Color(0xFFF0F0F5);

  static const Color chartTeal = Color(0xFF00897B);
  static const Color chartGreen = Color(0xFF22C55E);
  static const Color chartOrange = Color(0xFFF97316);
  static const Color chartBlue = Color(0xFF3B82F6);
}

class AppColorsDark {
  static const Color primary = Color(0xFF26A69A);
  static const Color primaryLight = Color(0xFF1E3A38);
  static const Color primaryDark = Color(0xFF004D40);

  static const Color background = Color(0xFF121218);
  static const Color surface = Color(0xFF1C1C24);

  static const Color textPrimary = Color(0xFFF2F2F7);
  static const Color textSecondary = Color(0xFFA0A0B2);
  static const Color textHint = Color(0xFF6C6C7D);

  static const Color studyColor = Color(0xFF9C90FF);
  static const Color studyBg = Color(0xFF2B2745);

  static const Color timeColor = Color(0xFF60A5FA);
  static const Color timeBg = Color(0xFF1E2A3F);

  static const Color coursesColor = Color(0xFF4ADE80);
  static const Color coursesBg = Color(0xFF1B3327);

  static const Color workColor = Color(0xFFFB923C);
  static const Color workBg = Color(0xFF3A2A18);

  static const Color success = Color(0xFF4ADE80);
  static const Color warning = Color(0xFFFB923C);
  static const Color info = Color(0xFF60A5FA);
  static const Color danger = Color(0xFFF87171);

  static const Color border = Color(0xFF2A2A34);
  static const Color divider = Color(0xFF26262F);
}

class CategoryStyle {
  final Color color;
  final Color background;

  const CategoryStyle({required this.color, required this.background});

  static const CategoryStyle study = CategoryStyle(
    color: AppColors.studyColor,
    background: AppColors.studyBg,
  );

  static const CategoryStyle time = CategoryStyle(
    color: AppColors.timeColor,
    background: AppColors.timeBg,
  );

  static const CategoryStyle courses = CategoryStyle(
    color: AppColors.coursesColor,
    background: AppColors.coursesBg,
  );

  static const CategoryStyle work = CategoryStyle(
    color: AppColors.workColor,
    background: AppColors.workBg,
  );

  static const CategoryStyle studyDark = CategoryStyle(
    color: AppColorsDark.studyColor,
    background: AppColorsDark.studyBg,
  );

  static const CategoryStyle timeDark = CategoryStyle(
    color: AppColorsDark.timeColor,
    background: AppColorsDark.timeBg,
  );

  static const CategoryStyle coursesDark = CategoryStyle(
    color: AppColorsDark.coursesColor,
    background: AppColorsDark.coursesBg,
  );

  static const CategoryStyle workDark = CategoryStyle(
    color: AppColorsDark.workColor,
    background: AppColorsDark.workBg,
  );

  static CategoryStyle of(BuildContext context, CategoryStyle light, CategoryStyle dark) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? dark : light;
  }

  static CategoryStyle forCategory(BuildContext context, String category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (category) {
      case 'دراسي':
        return isDark ? studyDark : study;
      case 'كورسات':
        return isDark ? coursesDark : courses;
      case 'عمل':
        return isDark ? workDark : work;
      case 'تنظيم وقت':
      default:
        return isDark ? timeDark : time;
    }
  }

  static IconData iconForCategory(String category) {
    switch (category) {
      case 'دراسي':
        return Icons.menu_book_outlined;
      case 'كورسات':
        return Icons.ondemand_video_outlined;
      case 'عمل':
        return Icons.work_outline;
      case 'تنظيم وقت':
      default:
        return Icons.schedule_outlined;
    }
  }
}
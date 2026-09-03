import 'package:flutter/material.dart';

class AppColors {
  static const cream = Color(0xFFFFF8EC);
  static const sun = Color(0xFFFFC93C);
  static const sky = Color(0xFF3FC1C9);
  static const coral = Color(0xFFFF6F59);
  static const grape = Color(0xFF6C5CE7);
  static const leaf = Color(0xFF4CAF7D);
  static const ink = Color(0xFF33302A);
  static const card = Colors.white;
}

ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.cream,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.grape,
      background: AppColors.cream,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
      titleLarge: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
      bodyMedium: TextStyle(color: AppColors.ink),
    ),
    useMaterial3: true,
  );
}

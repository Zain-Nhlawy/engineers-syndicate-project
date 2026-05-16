import 'package:flutter/material.dart';
import 'color_theme.dart'; 

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'ITFQomraArabic', 
      
      colorScheme: const ColorScheme.light(
        primary: ColorTheme.primary,
        primaryContainer: ColorTheme.primaryContainer,
        secondary: ColorTheme.accent,
        surface: ColorTheme.surface,
        error: ColorTheme.onError,
        onPrimary: ColorTheme.textLight,
        onSurface: ColorTheme.textPrimary, 
      ),

      scaffoldBackgroundColor: ColorTheme.background, 

      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontWeight: FontWeight.w400, color: ColorTheme.textPrimary),
        bodyLarge: TextStyle(fontWeight: FontWeight.w400, color: ColorTheme.textPrimary),
        titleMedium: TextStyle(fontWeight: FontWeight.w700, color: ColorTheme.textPrimary),
        titleLarge: TextStyle(fontWeight: FontWeight.w700, color: ColorTheme.textPrimary),
      ),
    );
  }
}
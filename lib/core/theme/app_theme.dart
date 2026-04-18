import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF0A0A0F);
  static const Color lightBg = Color(0xFFF5F5F7);

  static ThemeData getDarkTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        background: darkBg,
      ),
      textTheme: TextTheme(
        displayLarge: AppFonts.display(
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: -2,
        ),
        bodyLarge: AppFonts.mono(
          fontSize: 16,
          color: Colors.white.withOpacity(0.7),
        ),
        bodySmall: AppFonts.mono(
          fontSize: 12,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  static ThemeData getLightTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        background: lightBg,
      ),
      textTheme: TextTheme(
        displayLarge: AppFonts.display(
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: -2,
        ),
        bodyLarge: AppFonts.mono(
          fontSize: 16,
          color: Colors.black.withOpacity(0.7),
        ),
        bodySmall: AppFonts.mono(
          fontSize: 12,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}

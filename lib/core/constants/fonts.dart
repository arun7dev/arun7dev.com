import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Primary Display Font (Headers, Big Names)
  static TextStyle display({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Monospace Font (Body, Technical details, Code-like text)
  static TextStyle mono({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Accent / Dot Matrix Font (Numbers, Eyebrows)
  static TextStyle dots({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return GoogleFonts.ralewayDots(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Text Themes for Global usage
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: display(fontWeight: FontWeight.w900, letterSpacing: -2),
      bodyLarge: mono(fontSize: 16),
      bodyMedium: mono(fontSize: 14),
    );
  }
}

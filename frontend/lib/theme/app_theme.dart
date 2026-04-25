import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4648D4);
  static const Color primaryContainer = Color(0xFF6063EE);
  static const Color onPrimaryContainer = Colors.white;
  static const Color backgroundColor = Color(0xFFF8F9FF);
  static const Color surfaceColor = Color(0xFFF8F9FF);
  static const Color onSurface = Color(0xFF0B1C30);
  static const Color onSurfaceVariant = Color(0xFF464554);
  static const Color outline = Color(0xFF767586);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        surface: surfaceColor,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        background: backgroundColor,
      ),
      textTheme: GoogleFonts.interTextTheme(),
    );
  }

  static BoxDecoration get glassDecoration => BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.15),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      );

  static BoxDecoration get inputGlassDecoration => BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      );

  static LinearGradient get etherealGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE1E0FF),
          Color(0xFFF8F9FF),
          Color(0xFFDDE1FF),
        ],
        stops: [0.0, 0.5, 1.0],
      );
}

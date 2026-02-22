import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// MoniKid App Theme - Updated to exactly match HTML reference
class AppTheme {
  AppTheme._();

  // ==========================================================================
  // COLOR PALETTE FROM HTML REFERENCE
  // ==========================================================================

  // Primary colors
  static const Color primary = Color(0xFF2F7F33);
  static const Color primaryDark = Color(0xFF1B4D1F);
  static const Color primaryLight = Color(0xFFE8F5E9);

  // Background and Surface (Dark Mode)
  static const Color backgroundDark = Color(0xFF141E15);
  static const Color surfaceDark = Color(0xFF1C2B1E);

  // Background and Surface (Light Mode)
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color surfaceLight = Colors.white;

  // Semantic & Text colors
  static const Color textWhite = Colors.white;
  static const Color textBlack = Color(0xFF111811);
  static const Color textGrey = Color(0xFF64748B); // neutral-gray
  static const Color redAlert = Color(0xFFFF5252);
  static const Color orangeWarning = Color(0xFFFFAB40);

  // Aliases for legacy compatibility
  static const Color background = backgroundDark;
  static const Color surface = surfaceDark;
  static const Color inputBackground = surfaceDark;
  static const Color primaryGreen = primary;

  // ==========================================================================
  // DARK THEME
  // ==========================================================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primary,

      // Cấu hình màu sắc cốt lõi
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: primaryLight,
        surface: surfaceDark,
        error: redAlert,
        onPrimary: Colors.white,
        onSurface: textWhite,
      ),

      // Font chữ mặc định
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: textWhite, displayColor: textWhite),

      // Style cho AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textWhite),
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Style cho các ô nhập liệu (Input)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        hintStyle: const TextStyle(color: textGrey, fontSize: 14),
        prefixIconColor: textGrey,
        suffixIconColor: textGrey,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // rounded-xl (12px)
          borderSide: const BorderSide(color: Color(0xFF334155)), // slate-700
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary),
        ),
      ),

      // Style cho nút bấm chính (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // rounded-xl (12px)
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ==========================================================================
  // LIGHT THEME
  // ==========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: primary,

      // Cấu hình màu sắc cốt lõi
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: primaryDark,
        surface: surfaceLight,
        error: redAlert,
        onPrimary: Colors.white,
        onSurface: textBlack,
      ),

      // Font chữ
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).apply(bodyColor: textBlack, displayColor: textBlack),

      // AppBar Light Mode
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textBlack),
        titleTextStyle: TextStyle(
          color: textBlack,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Input Light Mode
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        hintStyle: TextStyle(color: textGrey.withOpacity(0.8), fontSize: 14),
        prefixIconColor: textGrey,
        suffixIconColor: textGrey,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // rounded-xl (12px)
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)), // slate-200
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary),
        ),
      ),

      // Button Light Mode
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primary.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // rounded-xl (12px)
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

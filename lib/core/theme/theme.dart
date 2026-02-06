import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF0F172A); // Dark Slate Blue
  static const Color primary = Color(0xFF2563EB); // Bright Blue
  static const Color inputFill = Color(0xFF1E293B); // Lighter Dark Blue
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF94A3B8);
  // Dark Slate Blue
  static const Color cardFill = Color(0xFF1E293B); // Lighter Dark Blue

  static const Color success = Color(0xFF10B981); // Green

  // Accent Colors for Grid Items
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentOrange = Color(0xFFF97316);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentTeal = Color(0xFF14B8A6);

  static const Color backgroundLight = Color(0xFFF6F6F8);
  static const Color cardLight = Colors.white;
  static const Color textMainLight = Color(0xFF111827); // Gray 900
  static const Color textSubLight = Color(0xFF6B7280); // Gray 500

  static const Color backgroundDark = Color(0xFF101622);
  static const Color cardDark = Color(0xFF1C2433);
  static const Color textMainDark = Colors.white;
  static const Color textSubDark = Color(0xFF9CA3AF); // Gray 400

  // Icon Background Colors
  static const Color blueLight = Color(0xFFDBEAFE); // blue-100
  static const Color blueDark = Color.fromRGBO(30, 58, 138, 0.3); // blue-900/30
  static const Color blueText = Color(0xFF2563EB); // blue-600

  static const Color indigoLight = Color(0xFFE0E7FF);
  static const Color indigoDark = Color.fromRGBO(49, 46, 129, 0.3);
  static const Color indigoText = Color(0xFF4F46E5);

  static const Color tealLight = Color(0xFFCCFBF1);
  static const Color tealDark = Color.fromRGBO(19, 78, 74, 0.3);
  static const Color tealText = Color(0xFF0D9488);

  static const Color amberLight = Color(0xFFFEF3C7);
  static const Color amberDark = Color.fromRGBO(120, 53, 15, 0.3);
  static const Color amberText = Color(0xFFD97706);

  static const Color grayLight = Color(0xFFF3F4F6);
  static const Color grayDark = Color(0xFF374151);
  static const Color grayText = Color(0xFF4B5563);

  // UI Elements
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color inputBgLight = Color(0xFFE2E8F0); // Slate 200 with opacity
  static const Color iconLight = Color(0xFFCBD5E1); // Sla
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      brightness: Brightness.light,
      primaryColor: primary,
      fontFamily: GoogleFonts.inter().fontFamily,
      cardColor: cardLight,
      dividerColor: Colors.grey.shade100,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.inter(color: textMainLight),
        bodyMedium: GoogleFonts.inter(color: textSubLight),
        titleMedium: GoogleFonts.inter(
          color: textMainLight,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xCCF6F6F8), // with opacity
        foregroundColor: textMainLight,
        elevation: 0,
      ),
    );
  }

  // Dark Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundDark,
      brightness: Brightness.dark,
      primaryColor: primary,
      fontFamily: GoogleFonts.inter().fontFamily,
      cardColor: cardDark,
      dividerColor: Colors.grey.shade900,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.inter(color: textMainDark),
        bodyMedium: GoogleFonts.inter(color: textSubDark),
        titleMedium: GoogleFonts.inter(
          color: textMainDark,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xCC101622),
        foregroundColor: textMainDark,
        elevation: 0,
      ),
    );
  }
}

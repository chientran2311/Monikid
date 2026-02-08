import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/// MoniKid App Theme - Warm, Kid-Friendly, Modern Fintech Design
/// 
/// Design Philosophy:
/// - Purple/Violet for trust and modernity (Fintech)
/// - Coral/Orange for warmth and playfulness (Kid-friendly)
/// - Soft mint/teal for success and money (Finance)
/// - Clean, rounded shapes for friendly feel
/// 
/// References: Modern kids banking apps like Greenlight, GoHenry, Famzo
class AppTheme {
  AppTheme._();

  // ==========================================================================
  // REFINED COLOR PALETTE FOR MONIKID
  // Based on: Fintech + Kids + Family + Warmth
  // ==========================================================================
  static const Color background = Color(0xFF0E1F18); // Màu nền tối
  static const Color primaryGreen = Color(0xFF00E676); // Màu nút xanh
  static const Color inputBackground = Color(0xFF1C2E26); // Màu nền ô nhập
  static const Color textWhite = Colors.white;
  static const Color textGrey = Colors.grey;
 
  static const Color surface = Color(0xFF1C2E26);
  
  static const Color redAlert = Color(0xFFFF5252);
  static const Color _darkBackground = Color(0xFF0E1F18);
  static const Color _darkSurface = Color(0xFF1C2E26);
  
  // Light Mode Colors (Mới bổ sung)
  static const Color _lightBackground = Color(0xFFF4F6F5); // Màu trắng ám xanh cực nhẹ
  static const Color _lightSurface = Colors.white;
  
  // Brand Colors (Dùng chung)

  static const Color primaryDark = Color(0xFF00B359); // Green đậm hơn (cho text trên nền sáng)
  
  static const Color orangeWarning = Color(0xFFFFAB40);
  
  // Text Colors
  static const Color _textWhite = Colors.white;
  static const Color _textBlack = Color(0xFF0E1F18); // Đen xanh (cho Light mode)
  static const Color _textGrey = Colors.grey;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkBackground,
      primaryColor: primaryGreen,
      
      // Cấu hình màu sắc cốt lõi
      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        secondary: primaryGreen,
        surface: _darkSurface,
        background: _darkBackground,
        error: redAlert,
        onPrimary: _darkBackground, // Chữ trên nền nút xanh -> Màu tối
        onSurface: _textWhite,
      ),

      // Font chữ mặc định (Dùng Google Fonts hoặc font hệ thống)
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: _textWhite,
        displayColor: _textWhite,
      ),

      // Style cho AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: _textWhite),
        titleTextStyle: TextStyle(
          color: _textWhite, 
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
      ),

      // Style cho các ô nhập liệu (Input)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        hintStyle: const TextStyle(color: _textGrey, fontSize: 14),
        prefixIconColor: _textGrey,
        suffixIconColor: _textGrey,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryGreen),
        ),
      ),

      // Style cho nút bấm chính (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: _darkBackground, // Màu chữ trên nút
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ==========================================================================
  // 3. LIGHT THEME (Giao diện sáng - Bổ sung mới)
  // ==========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightBackground,
      primaryColor: primaryGreen,

      // Cấu hình màu sắc cốt lõi
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: primaryDark,
        surface: _lightSurface,
        background: _lightBackground,
        error: redAlert,
        onPrimary: _darkBackground, // Chữ trên nền nút xanh vẫn là màu tối
        onSurface: _textBlack,
      ),

      // Font chữ
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: _textBlack,
        displayColor: _textBlack,
      ),

      // AppBar Light Mode
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: _textBlack),
        titleTextStyle: TextStyle(
          color: _textBlack, 
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
      ),

      // Input Light Mode
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: _textGrey.withOpacity(0.8), fontSize: 14),
        prefixIconColor: _textGrey,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryGreen),
        ),
      ),

      // Button Light Mode (Giữ nguyên style nút xanh để nhận diện thương hiệu)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: _darkBackground,
          elevation: 2, // Thêm chút bóng đổ cho nổi trên nền sáng
          shadowColor: primaryGreen.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

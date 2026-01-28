import 'package:flutter/material.dart';

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

  // Primary Colors - Soft Purple (Trust, Modern, Premium)
  static const Color primaryColor = Color(0xFF7C5CFC);     // Vibrant purple
  static const Color primaryLight = Color(0xFFA78BFA);     // Light purple
  static const Color primaryDark = Color(0xFF5B3FD9);      // Deep purple
  static const Color primarySurface = Color(0xFFF3F0FF);   // Purple tint bg

  // Secondary Colors - Warm Coral (Energy, Fun, Kid-friendly)
  static const Color secondaryColor = Color(0xFFFF6B6B);   // Coral
  static const Color secondaryLight = Color(0xFFFFADAD);   // Light coral
  static const Color secondaryDark = Color(0xFFEE5253);    // Deep coral

  // Accent Colors - Functional
  static const Color accentGreen = Color(0xFF00C48C);      // Success, Money In
  static const Color accentGreenLight = Color(0xFFE8FAF4); // Green surface
  static const Color accentRed = Color(0xFFFF5252);        // Error, Money Out
  static const Color accentRedLight = Color(0xFFFFF0F0);   // Red surface
  static const Color accentOrange = Color(0xFFFFAA5B);     // Warning, Pending
  static const Color accentOrangeLight = Color(0xFFFFF8F0);
  static const Color accentBlue = Color(0xFF5B8DEF);       // Info
  static const Color accentBlueLight = Color(0xFFF0F5FF);
  static const Color accentTeal = Color(0xFF00BFA6);       // Special (Wallet)

  // Neutral Colors - Warm Grays
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FC);  // Soft off-white
  static const Color backgroundDark = Color(0xFF1A1B2E);   // Deep night
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF252640);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2E4A);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1A1B2E);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3AF);

  // Role-specific Colors
  static const Color parentColor = Color(0xFF7C5CFC);      // Purple for parent
  static const Color childColor = Color(0xFFFF6B6B);       // Coral for child
  static const Color moneyInColor = Color(0xFF00C48C);     // Green
  static const Color moneyOutColor = Color(0xFFFF5252);    // Red

  // ==========================================================================
  // GRADIENTS
  // ==========================================================================

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C5CFC), Color(0xFFA78BFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient parentGradient = LinearGradient(
    colors: [Color(0xFF7C5CFC), Color(0xFF9B8DFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient childGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFFADAD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF00BFA6), Color(0xFF00D9C0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient moneyInGradient = LinearGradient(
    colors: [Color(0xFF00C48C), Color(0xFF55EFC4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient moneyOutGradient = LinearGradient(
    colors: [Color(0xFFFF5252), Color(0xFFFF7B7B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFFAA5B), Color(0xFFFF6B6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF7C5CFC), Color(0xFFFF6B6B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==========================================================================
  // TYPOGRAPHY - Kid-Friendly but Professional
  // Using system fonts for now, can add Baloo 2 / Nunito later
  // ==========================================================================

  static const String fontFamily = 'Roboto';
  static const String fontFamilyHeading = 'Roboto';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
    height: 1.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.45,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // Money/Currency Typography
  static const TextStyle moneyLarge = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
    height: 1.1,
  );

  static const TextStyle moneyMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle moneySmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ==========================================================================
  // SPACING SYSTEM
  // ==========================================================================

  static const double spacingXXS = 2.0;
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacing3XL = 64.0;

  // ==========================================================================
  // BORDER RADIUS - Rounded for friendly feel
  // ==========================================================================

  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusFull = 100.0;

  static BorderRadius borderRadiusSM = BorderRadius.circular(radiusSM);
  static BorderRadius borderRadiusMD = BorderRadius.circular(radiusMD);
  static BorderRadius borderRadiusLG = BorderRadius.circular(radiusLG);
  static BorderRadius borderRadiusXL = BorderRadius.circular(radiusXL);
  static BorderRadius borderRadiusFull = BorderRadius.circular(radiusFull);

  // ==========================================================================
  // SHADOWS - Soft, elevated look
  // ==========================================================================

  static List<BoxShadow> shadowXS = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> shadowSM = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowMD = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowLG = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> shadowXL = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];

  // Colored shadows for cards
  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.3),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> shadowSuccess = [
    BoxShadow(
      color: accentGreen.withValues(alpha: 0.3),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  // ==========================================================================
  // ANIMATION DURATIONS
  // ==========================================================================

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 350);
  static const Duration durationPage = Duration(milliseconds: 300);

  // ==========================================================================
  // THEME DATA - LIGHT
  // ==========================================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primarySurface,
        onPrimaryContainer: primaryDark,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        secondaryContainer: secondaryLight.withValues(alpha: 0.3),
        onSecondaryContainer: secondaryDark,
        tertiary: accentTeal,
        onTertiary: Colors.white,
        tertiaryContainer: accentGreenLight,
        onTertiaryContainer: accentGreen,
        surface: surfaceLight,
        onSurface: textPrimaryLight,
        surfaceContainerHighest: gray100,
        onSurfaceVariant: textSecondaryLight,
        outline: gray300,
        outlineVariant: gray200,
        error: accentRed,
        onError: Colors.white,
        errorContainer: accentRedLight,
        onErrorContainer: accentRed,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceLight,
        foregroundColor: textPrimaryLight,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 56,
        titleTextStyle: titleLarge.copyWith(
          color: textPrimaryLight,
          fontFamily: fontFamily,
        ),
        iconTheme: const IconThemeData(color: textPrimaryLight, size: 24),
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusLG,
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: gray300,
          disabledForegroundColor: gray600,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLG,
            vertical: spacingMD,
          ),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMD,
          ),
          elevation: 0,
          textStyle: titleMedium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLG,
            vertical: spacingMD,
          ),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMD,
          ),
          side: const BorderSide(color: primaryColor, width: 1.5),
          textStyle: titleMedium,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingMD,
            vertical: spacingSM,
          ),
          textStyle: titleMedium,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLG,
            vertical: spacingMD,
          ),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMD,
          ),
          textStyle: titleMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray100,
        border: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: BorderSide(color: gray200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: const BorderSide(color: accentRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: const BorderSide(color: accentRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingMD,
        ),
        hintStyle: bodyMedium.copyWith(color: textTertiaryLight),
        labelStyle: labelLarge.copyWith(color: textSecondaryLight),
        errorStyle: bodySmall.copyWith(color: accentRed),
        prefixIconColor: textSecondaryLight,
        suffixIconColor: textSecondaryLight,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceLight,
        indicatorColor: primarySurface,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor, size: 24);
          }
          return IconThemeData(color: textSecondaryLight, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return labelMedium.copyWith(color: primaryColor);
          }
          return labelMedium.copyWith(color: textSecondaryLight);
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXL)),
        ),
        dragHandleColor: gray300,
        dragHandleSize: const Size(40, 4),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceLight,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusXL),
        titleTextStyle: headlineMedium.copyWith(color: textPrimaryLight),
        contentTextStyle: bodyMedium.copyWith(color: textSecondaryLight),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: gray900,
        contentTextStyle: bodyMedium.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusMD),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: gray100,
        selectedColor: primarySurface,
        labelStyle: labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: spacingSM, vertical: spacingXS),
        shape: RoundedRectangleBorder(borderRadius: borderRadiusFull),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusLG),
      ),
      dividerTheme: DividerThemeData(
        color: gray200,
        thickness: 1,
        space: spacingMD,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingSM,
        ),
        titleTextStyle: titleMedium.copyWith(color: textPrimaryLight),
        subtitleTextStyle: bodySmall.copyWith(color: textSecondaryLight),
        iconColor: textSecondaryLight,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusMD),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: gray200,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryColor;
          return gray400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primaryLight;
          return gray200;
        }),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: primaryColor,
        unselectedLabelColor: textSecondaryLight,
        labelStyle: labelLarge,
        unselectedLabelStyle: labelLarge,
        indicatorColor: primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  // ==========================================================================
  // THEME DATA - DARK
  // ==========================================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.dark(
        primary: primaryLight,
        onPrimary: textPrimaryLight,
        primaryContainer: primaryDark,
        onPrimaryContainer: primaryLight,
        secondary: secondaryLight,
        onSecondary: textPrimaryLight,
        secondaryContainer: secondaryDark,
        onSecondaryContainer: secondaryLight,
        tertiary: accentTeal,
        onTertiary: textPrimaryLight,
        tertiaryContainer: accentGreen.withValues(alpha: 0.2),
        onTertiaryContainer: accentGreen,
        surface: surfaceDark,
        onSurface: textPrimaryDark,
        surfaceContainerHighest: cardDark,
        onSurfaceVariant: textSecondaryDark,
        outline: gray700,
        outlineVariant: gray800,
        error: secondaryColor,
        onError: Colors.white,
        errorContainer: secondaryDark.withValues(alpha: 0.2),
        onErrorContainer: secondaryLight,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceDark,
        foregroundColor: textPrimaryDark,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 56,
        titleTextStyle: titleLarge.copyWith(
          color: textPrimaryDark,
          fontFamily: fontFamily,
        ),
        iconTheme: const IconThemeData(color: textPrimaryDark, size: 24),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusLG,
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: textPrimaryLight,
          disabledBackgroundColor: gray700,
          disabledForegroundColor: gray500,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLG,
            vertical: spacingMD,
          ),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMD,
          ),
          elevation: 0,
          textStyle: titleMedium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLight,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLG,
            vertical: spacingMD,
          ),
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMD,
          ),
          side: const BorderSide(color: primaryLight, width: 1.5),
          textStyle: titleMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardDark,
        border: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: BorderSide(color: gray700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadiusMD,
          borderSide: const BorderSide(color: primaryLight, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingMD,
        ),
        hintStyle: bodyMedium.copyWith(color: textTertiaryDark),
        labelStyle: labelLarge.copyWith(color: textSecondaryDark),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceDark,
        indicatorColor: primaryDark.withValues(alpha: 0.3),
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryLight, size: 24);
          }
          return IconThemeData(color: textSecondaryDark, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return labelMedium.copyWith(color: primaryLight);
          }
          return labelMedium.copyWith(color: textSecondaryDark);
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXL)),
        ),
        dragHandleColor: gray600,
        dragHandleSize: const Size(40, 4),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusXL),
        titleTextStyle: headlineMedium.copyWith(color: textPrimaryDark),
        contentTextStyle: bodyMedium.copyWith(color: textSecondaryDark),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: gray800,
        contentTextStyle: bodyMedium.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusMD),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        foregroundColor: textPrimaryLight,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: borderRadiusLG),
      ),
      dividerTheme: DividerThemeData(
        color: gray700,
        thickness: 1,
        space: spacingMD,
      ),
    );
  }
}

// ==========================================================================
// SPACING EXTENSION
// ==========================================================================

extension SpacingExtension on num {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
}

// ==========================================================================
// PADDING EXTENSIONS
// ==========================================================================

extension PaddingExtension on Widget {
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}

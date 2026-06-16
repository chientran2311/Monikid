import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';

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
  static const Color primaryBright = Color(0xFF4EA653); // splash accent-bright blob
  static const Color accentVibrant = Color(0xFF34C759);  // iOS green — dark-mode glass accent
  static const Color primaryPale = Color(0xFFB2D8B4);   // splash ambient blob

  // Splash
  static const Color splashBackground = Color(0xFFF0F4F0); // mesh background light

  // Background and Surface (Dark Mode)
  static const Color backgroundDark = Color(0xFF141E15);
  static const Color surfaceDark = Color(0xFF1C2B1E);
  static const Color surfaceVeryDark = Color(0xFF0F172A); // slate-900

  // Background and Surface (Light Mode)
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceVeryLight = Color(0xFFF8FAFC); // slate-50
  static const Color surfaceLightGrey = Color(0xFFF1F5F9); // slate-100

  // Semantic & Text colors
  static const Color textWhite = Colors.white;
  static const Color textBlack = Color(0xFF111811);
  static const Color textGrey = Color(0xFF64748B); // neutral-gray / slate-500
  static const Color textMuted = Color(0xFF94A3B8); // slate-400
  static const Color textDark = Color(0xFF475569); // slate-600
  static const Color redAlert = Color(0xFFFF5252);
  static const Color orangeWarning = Color(0xFFFFAB40);

  // Aliases for legacy compatibility
  static const Color background = backgroundDark;
  static const Color surface = surfaceDark;
  static const Color inputBackground = surfaceDark;
  static const Color primaryGreen = primary;

  // Avatar colors for family member display
  static const Color avatarParent = Color(0xFF5C6BC0); // indigo-400: non-host parent avatar

  // Additional colors used in UI
  static const Color iconLight = Color(0xFFCBD5E1); // slate-300 for icons
  static const Color surfaceVariant = Color(0xFF22302A); // Dark surface variant (green-tinted)
  static const Color borderDark = Color(0xFF33453A); // Dark border (green-tinted)
  static const Color borderLight = Color(0xFFE2E8F0); // Light border
  static const Color amberSurface = Color(0xFFFFFBEB);
  static const Color amberBorder = Color(0xFFFDE68A);
  static const Color amberFill = Color(0xFFFEF3C7);
  static const Color amberText = Color(0xFFD97706);
  static const Color chartOrange = Color(0xFFF59E0B);
  static const Color chartBlue = Color(0xFF3B82F6);
  static const Color chartPurple = Color(0xFF8B5CF6);
  static const Color chartGreen = Color(0xFF22C55E);
  static const Color successSurface = Color(0xFFECFDF3);
  static const Color successBorder = Color(0xFF86EFAC);
  static const Color warningSurface = Color(0xFFFFFBEB); // Amber surface for warning state
  static const Color warningText = Color(0xFFD97706); // Amber text for warning state
  static const Color dangerSurface = Color(0xFFFEF2F2);
  static const Color dangerBorder = Color(0xFFFECACA);
  static const Color infoSurface = Color(0xFFEFF6FF);
  static const Color infoBorder = Color(0xFFBFDBFE);

  // ==========================================================================
  // EXTENDED COLOR PALETTE (Added for hardcoded color replacement)
  // ==========================================================================

  // Parent home screen background (exact values from HTML --bg1/--bg2/--fg)
  static const Color homeParBg1 = Color(0xFFF2FBF2); // --bg1 gradient start (light mint)
  static const Color homeParBg2 = Color(0xFFEEF6EF); // --bg2 gradient end
  static const Color homeParFg = Color(0xFF153416);  // --fg dark green for AppBar title

  // Light green variants (custom surfaces)
  static const Color surfaceLightGreen = Color(0xFFEAF2EB); // custom light green surface

  // Grey variants (for additional UI states)
  static const Color surfaceGrey = Color(0xFFF3F4F6); // grey-100: alternate light surface
  static const Color backgroundVeryDark = Color(0xFF111827); // grey-900: very dark bg
  static const Color textGreyDark = Color(0xFF9CA3AF); // grey-400: darker muted text
  static const Color textGreyMedium = Color(0xFF4B5563); // grey-600: medium grey text
  static const Color textGreyDarker = Color(0xFF374151); // grey-700: darker grey text
  static const Color borderGrey = Color(0xFFD1D5DB); // grey-300: light border
  static const Color controlTrack = Color(0xFFEBECEB); // segmented control track background

  // Red variants (errors, alerts, danger states)
  static const Color redDark = Color(0xFFDC2626); // red-600: dark red for strong errors
  static const Color redMedium = Color(0xFFEF4444); // red-500: medium red (can also use redAlert)
  static const Color redLight = Color(0xFFFCA5A5); // red-300: light red for backgrounds
  static const Color dangerSurfaceStrong = Color(0xFFFEE2E2); // red-100: unlink pill background
  static const Color redVeryLight = Color(0xFFF87171); // red-400: very light red

  // Green variants (success, positive states)
  static const Color greenBright = Color(0xFF10B981); // emerald-500: bright green
  static const Color greenDark = Color(0xFF166534); // green-800: dark green
  static const Color greenDarker = Color(0xFF1E5222); // green-900: very dark green

  // Blue variants (info, links, primary actions)
  static const Color blueDark = Color(0xFF2563EB); // blue-600: dark blue
  static const Color blueLight = Color(0xFF93C5FD); // blue-300: light blue

  // iOS system colors (for native-looking UI)
  static const Color iosSystemGrey = Color(0xFFE5E5EA); // iOS system grey
  static const Color iosSystemGreyDark = Color(0xFFC5C5CA); // iOS system grey variant

  // ==========================================================================
  // TRANSACTION CATEGORY ICON COLORS (from monikid-home-upgrade-Child.html)
  // ==========================================================================
  static const Color txCategoryBookBg = Color(0xFFF3FBF3);
  static const Color txCategoryBookBorder = Color(0xFFDCEEDC);
  static const Color txCategoryFoodBg = Color(0xFFFFF6EC);
  static const Color txCategoryFoodBorder = Color(0xFFF1DEC1);
  static const Color txCategoryFoodIcon = Color(0xFFC97E23);
  static const Color txCategorySchoolBg = Color(0xFFF1F7FF);
  static const Color txCategorySchoolBorder = Color(0xFFD8E4F7);
  static const Color txCategorySchoolIcon = Color(0xFF3F7EC7);
  static const Color txCategoryTopupBg = Color(0xFFEEF9F0);
  static const Color txCategoryTopupBorder = Color(0xFFD7EED8);
  static const Color txCategoryOtherBg = Color(0xFFF8F5FF);
  static const Color txCategoryOtherBorder = Color(0xFFE3DDF8);
  static const Color txCategoryOtherIcon = Color(0xFF7A57C4);
  static const Color txStatusWarnIcon = Color(0xFFD18A2E);
  static const Color txStatusWarnBg = Color(0xFFFFF6EC);

  // ==========================================================================
  // ONBOARDING BUTTON GRADIENT
  // Extracted from HTML: linear-gradient(180deg,
  //   color-mix(in oklab, #2F7F33 98%, white),
  //   color-mix(in oklab, #2F7F33 82%, black))
  // ==========================================================================
  static const Color primaryButtonGradientTop = Color(0xFF338437);
  static const Color primaryButtonGradientBottom = Color(0xFF1E5421);
  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryButtonGradientTop, primaryButtonGradientBottom],
  );

  // ==========================================================================
  // NOTIFICATION SCREEN (Light theme — used regardless of system dark mode)
  // ==========================================================================

  // Card surface & unread tint
  static const Color notifCardSurface = Colors.white;
  static const Color notifUnreadTint = Color(0xFFF0FDF4); // green-50: unread card bg

  // Icon container backgrounds (40×40, borderRadius 12)
  static const Color notifIconBlueBg = Color(0xFFEFF6FF);   // blue-50: weeklyOverspend
  static const Color notifIconAmberBg = Color(0xFFFEF3C7);  // amber-100: overspend80
  static const Color notifIconRedBg = Color(0xFFFEF2F2);    // red-50: overspend100

  // Icon foreground colors
  static const Color notifIconBlue = Color(0xFF3B82F6);   // blue-500
  static const Color notifIconAmber = Color(0xFFFFAB40);  // amber: 80% warning
  static const Color notifIconRed = Color(0xFFFF5252);    // red: 100% exceeded

  // Badge on notification icon (home AppBar)
  static const Color notifBadgeBg = Color(0xFFFF5252);    // red alert
  static const Color notifBadgeFg = Colors.white;

  // Card shadow color (iOS-style soft shadow)
  static const Color notifCardShadow = Color(0x0D000000); // rgba(0,0,0,0.05)

  // ==========================================================================
  // DARK PALETTE (green-tinted, iOS 26) — cohesive dark counterparts.
  // Page bg = backgroundDark #141E15, card = surfaceDark #1C2B1E (kept).
  // ==========================================================================
  static const Color darkSurfaceElevated = Color(0xFF26352A); // dialogs/sheets (lighter than card)
  static const Color darkSurfaceVariant = Color(0xFF22302A); // alt surface
  static const Color darkPrimaryContainer = Color(0xFF1C3322); // primary tint surface
  static const Color darkPrimaryAccent = Color(0xFF5CC061); // primary-colored TEXT/ICON on dark (AA)
  static const Color darkTextPrimary = Color(0xFFE8EFE9); // off-white, replaces pure white
  static const Color darkTextSecondary = Color(0xFFA6B5AA);
  static const Color darkTextTertiary = Color(0xFF7E8E83); // hints
  static const Color darkIcon = Color(0xFFC2CFC6);
  static const Color darkBorder = Color(0xFF33453A); // ≈ white@0.10 over base
  static const Color darkBorderStrong = Color(0xFF415447);
  static const Color darkErrorAlert = Color(0xFFFF6B6B);

  // Light-mode near-black text — split out from the overloaded surfaceVeryDark.
  static const Color textNearBlack = Color(0xFF0F172A); // slate-900, light-mode text

  // Semantic dark surfaces (the light ones are near-white, unusable on dark)
  static const Color darkSuccessSurface = Color(0xFF15281C);
  static const Color darkSuccessBorder = Color(0xFF1F4A2E);
  static const Color darkSuccessText = Color(0xFF5FD08A);
  static const Color darkWarningSurface = Color(0xFF2A2310);
  static const Color darkWarningBorder = Color(0xFF4A3C17);
  static const Color darkWarningText = Color(0xFFF0B45A);
  static const Color darkDangerSurface = Color(0xFF2C1719);
  static const Color darkDangerBorder = Color(0xFF4A2629);
  static const Color darkDangerText = Color(0xFFFF7A7A);
  static const Color darkInfoSurface = Color(0xFF142436);
  static const Color darkInfoBorder = Color(0xFF244A6E);
  static const Color darkInfoText = Color(0xFF6FA8FF);

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
        secondary: darkPrimaryContainer,
        surface: surfaceDark,
        error: darkErrorAlert,
        onPrimary: Colors.white,
        onSurface: darkTextPrimary,
      ),

      // Font chữ mặc định
      textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Inter',
          bodyColor: darkTextPrimary,
          displayColor: darkTextPrimary),

      // Style cho AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: AppTextStyleFactory.style(
          size: AppFontSizes.titleMedium,
          weight: FontWeight.w700,
          color: darkTextPrimary,
          scaled: false,
        ),
      ),

      // Style cho các ô nhập liệu (Input)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        hintStyle: AppTextStyleFactory.style(
          size: AppFontSizes.bodyMedium,
          weight: FontWeight.w400,
          color: darkTextTertiary,
          scaled: false,
        ),
        prefixIconColor: darkTextTertiary,
        suffixIconColor: darkTextTertiary,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // rounded-xl (12px)
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
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
          textStyle: AppTextStyleFactory.style(
            size: AppFontSizes.buttonSmall,
            weight: FontWeight.w700,
            color: Colors.white,
            scaled: false,
          ),
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
      textTheme: ThemeData.light().textTheme
          .apply(fontFamily: 'Inter', bodyColor: textBlack, displayColor: textBlack),

      // AppBar Light Mode
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: textBlack),
        titleTextStyle: AppTextStyleFactory.style(
          size: AppFontSizes.titleMedium,
          weight: FontWeight.w700,
          color: textBlack,
          scaled: false,
        ),
      ),

      // Input Light Mode
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        hintStyle: AppTextStyleFactory.style(
          size: AppFontSizes.bodyMedium,
          weight: FontWeight.w400,
          color: textGrey.withValues(alpha: 0.8),
          scaled: false,
        ),
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
          shadowColor: primary.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // rounded-xl (12px)
          ),
          textStyle: AppTextStyleFactory.style(
            size: AppFontSizes.buttonSmall,
            weight: FontWeight.w700,
            color: Colors.white,
            scaled: false,
          ),
        ),
      ),
    );
  }
}

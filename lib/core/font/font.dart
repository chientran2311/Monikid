import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class AppFontFamily {
  AppFontFamily._();

  static const String inter = 'Inter';
}

// ---------------------------------------------------------------------------
// Font size tokens  (raw design values — always scaled via .r at build time)
// ---------------------------------------------------------------------------
class AppFontSizes {
  AppFontSizes._();

  static const double displaySmall = 28;
  static const double displayMedium = 32;
  static const double displayBig = 36;

  static const double headlineSmall = 22;
  static const double headlineMedium = 26;
  static const double headlineBig = 32;

  static const double titleSmall = 18;
  static const double titleMedium = 20;
  static const double titleBig = 24;

  static const double subtitleSmall = 16;
  static const double subtitleMedium = 18;
  static const double subtitleBig = 20;

  static const double bodySmall = 13;
  static const double bodyMedium = 14;
  static const double bodyBig = 16;

  static const double labelSmall = 11;
  static const double labelMedium = 12;
  static const double labelBig = 14;

  static const double captionSmall = 10;
  static const double captionMedium = 11;
  static const double captionBig = 12;

  static const double buttonSmall = 14;
  static const double buttonMedium = 16;
  static const double buttonBig = 18;
}

// ---------------------------------------------------------------------------
// Internal factory — applies .r scaling
// ---------------------------------------------------------------------------
class AppTextStyleFactory {
  AppTextStyleFactory._();

  static TextStyle style({
    required double size,
    required FontWeight weight,
    Color? color,
    double? height,
    double? letterSpacing,
    bool scaled = true,
  }) {
    return TextStyle(
      fontFamily: AppFontFamily.inter,
      fontSize: scaled ? size.r : size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

// ---------------------------------------------------------------------------
// Typography group — small / medium / big
// (.large kept as alias so existing code keeps compiling)
// ---------------------------------------------------------------------------
class AppTypographyGroup {
  const AppTypographyGroup({
    required this.color,
    required this.smallSize,
    required this.mediumSize,
    required this.bigSize,
    required this.weight,
  });

  final Color color;
  final double smallSize;
  final double mediumSize;
  final double bigSize;
  final FontWeight weight;

  TextStyle get small => _build(smallSize);
  TextStyle get medium => _build(mediumSize);
  TextStyle get big => _build(bigSize);

  /// Deprecated — use [big].
  @Deprecated('Use big instead')
  TextStyle get large => big;

  TextStyle _build(double size) =>
      AppTextStyleFactory.style(size: size, weight: weight, color: color);
}

// ---------------------------------------------------------------------------
// Main typography object — constructed once, shared via AppTypographyScope
// ---------------------------------------------------------------------------
class AppTypography {
  const AppTypography({required this.defaultColor});

  final Color defaultColor;

  // ── New groups ──────────────────────────────────────────────────────────
  AppTypographyGroup get display => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.displaySmall,
        mediumSize: AppFontSizes.displayMedium,
        bigSize: AppFontSizes.displayBig,
        weight: FontWeight.w800,
      );

  AppTypographyGroup get headline => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.headlineSmall,
        mediumSize: AppFontSizes.headlineMedium,
        bigSize: AppFontSizes.headlineBig,
        weight: FontWeight.w700,
      );

  AppTypographyGroup get title => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.titleSmall,
        mediumSize: AppFontSizes.titleMedium,
        bigSize: AppFontSizes.titleBig,
        weight: FontWeight.w700,
      );

  AppTypographyGroup get subtitle => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.subtitleSmall,
        mediumSize: AppFontSizes.subtitleMedium,
        bigSize: AppFontSizes.subtitleBig,
        weight: FontWeight.w600,
      );

  AppTypographyGroup get body => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.bodySmall,
        mediumSize: AppFontSizes.bodyMedium,
        bigSize: AppFontSizes.bodyBig,
        weight: FontWeight.w400,
      );

  AppTypographyGroup get label => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.labelSmall,
        mediumSize: AppFontSizes.labelMedium,
        bigSize: AppFontSizes.labelBig,
        weight: FontWeight.w500,
      );

  AppTypographyGroup get caption => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.captionSmall,
        mediumSize: AppFontSizes.captionMedium,
        bigSize: AppFontSizes.captionBig,
        weight: FontWeight.w500,
      );

  AppTypographyGroup get button => AppTypographyGroup(
        color: defaultColor,
        smallSize: AppFontSizes.buttonSmall,
        mediumSize: AppFontSizes.buttonMedium,
        bigSize: AppFontSizes.buttonBig,
        weight: FontWeight.w700,
      );

  // ── Deprecated aliases — kept so existing call sites still compile ───────

  /// Deprecated — use [display].
  @Deprecated('Use display instead')
  AppTypographyGroup get bigTitle => display;

  /// Deprecated — use [body].
  @Deprecated('Use body instead')
  AppTypographyGroup get text => body;

  /// Deprecated — use [display].
  @Deprecated('Use display instead')
  AppTypographyGroup get amount => display;
}

// ---------------------------------------------------------------------------
// InheritedWidget — wraps the app once, provides typo to every descendant
// ---------------------------------------------------------------------------
class AppTypographyScope extends InheritedWidget {
  const AppTypographyScope({
    super.key,
    required this.typography,
    required super.child,
  });

  final AppTypography typography;

  static AppTypography of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppTypographyScope>();
    assert(scope != null, 'AppTypographyScope not found in widget tree. '
        'Wrap your app with AppTypographyScope in app.dart.');
    return scope!.typography;
  }

  @override
  bool updateShouldNotify(AppTypographyScope oldWidget) =>
      typography.defaultColor != oldWidget.typography.defaultColor;
}

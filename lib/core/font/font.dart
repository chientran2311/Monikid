import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class AppFontFamily {
  AppFontFamily._();

  static final String inter = GoogleFonts.inter().fontFamily ?? 'Inter';
}

class AppFontSizes {
  AppFontSizes._();

  static const double bigTitleSmall = 28;
  static const double bigTitleMedium = 32;
  static const double bigTitleLarge = 36;

  static const double titleSmall = 18;
  static const double titleMedium = 20;
  static const double titleLarge = 24;

  static const double subtitleSmall = 16;
  static const double subtitleMedium = 18;
  static const double subtitleLarge = 20;

  static const double textSmall = 13;
  static const double textMedium = 14;
  static const double textLarge = 16;

  static const double labelSmall = 11;
  static const double labelMedium = 12;
  static const double labelLarge = 14;

  static const double captionSmall = 10;
  static const double captionMedium = 11;
  static const double captionLarge = 12;

  static const double buttonSmall = 14;
  static const double buttonMedium = 16;
  static const double buttonLarge = 18;

  static const double amountSmall = 24;
  static const double amountMedium = 32;
  static const double amountLarge = 48;
}

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
    return GoogleFonts.inter(
      fontSize: scaled ? size.sp : size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

class AppTypography {
  AppTypography(this._context);

  final BuildContext _context;

  Color get _defaultColor =>
      Theme.of(_context).textTheme.bodyMedium?.color ??
      Theme.of(_context).colorScheme.onSurface;

  AppTypographyGroup get bigTitle => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.bigTitleSmall,
        mediumSize: AppFontSizes.bigTitleMedium,
        largeSize: AppFontSizes.bigTitleLarge,
        weight: FontWeight.w800,
      );

  AppTypographyGroup get title => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.titleSmall,
        mediumSize: AppFontSizes.titleMedium,
        largeSize: AppFontSizes.titleLarge,
        weight: FontWeight.w700,
      );

  AppTypographyGroup get subtitle => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.subtitleSmall,
        mediumSize: AppFontSizes.subtitleMedium,
        largeSize: AppFontSizes.subtitleLarge,
        weight: FontWeight.w600,
      );

  AppTypographyGroup get text => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.textSmall,
        mediumSize: AppFontSizes.textMedium,
        largeSize: AppFontSizes.textLarge,
        weight: FontWeight.w400,
      );

  AppTypographyGroup get label => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.labelSmall,
        mediumSize: AppFontSizes.labelMedium,
        largeSize: AppFontSizes.labelLarge,
        weight: FontWeight.w500,
      );

  AppTypographyGroup get caption => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.captionSmall,
        mediumSize: AppFontSizes.captionMedium,
        largeSize: AppFontSizes.captionLarge,
        weight: FontWeight.w500,
      );

  AppTypographyGroup get button => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.buttonSmall,
        mediumSize: AppFontSizes.buttonMedium,
        largeSize: AppFontSizes.buttonLarge,
        weight: FontWeight.w700,
      );

  AppTypographyGroup get amount => AppTypographyGroup(
        color: _defaultColor,
        smallSize: AppFontSizes.amountSmall,
        mediumSize: AppFontSizes.amountMedium,
        largeSize: AppFontSizes.amountLarge,
        weight: FontWeight.w800,
      );
}

class AppTypographyGroup {
  const AppTypographyGroup({
    required this.color,
    required this.smallSize,
    required this.mediumSize,
    required this.largeSize,
    required this.weight,
  });

  final Color color;
  final double smallSize;
  final double mediumSize;
  final double largeSize;
  final FontWeight weight;

  TextStyle get small => _build(smallSize);

  TextStyle get medium => _build(mediumSize);

  TextStyle get large => _build(largeSize);

  TextStyle _build(double size) {
    return AppTextStyleFactory.style(
      size: size,
      weight: weight,
      color: color,
    );
  }
}

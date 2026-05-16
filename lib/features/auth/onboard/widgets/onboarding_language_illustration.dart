import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class OnboardingLanguageIllustration extends StatelessWidget {
  const OnboardingLanguageIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return SizedBox(
      width: 240.w,
      height: 240.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 166.w,
            height: 166.w,
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.textBlack.withValues(alpha: 0.08),
                  blurRadius: 28.r,
                  offset: Offset(0, 16.h),
                ),
              ],
            ),
            child: Icon(
              Icons.translate_rounded,
              size: 92.r,
              color: AppTheme.primary,
            ),
          ),
          Positioned(
            top: 28.h,
            right: 8.w,
            child: _FlagBubble(
              flag: '🇻🇳',
              cardColor: cardColor,
              borderColor: borderColor,
            ),
          ),
          Positioned(
            left: 8.w,
            bottom: 28.h,
            child: _FlagBubble(
              flag: '🇺🇸',
              cardColor: cardColor,
              borderColor: borderColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlagBubble extends StatelessWidget {
  const _FlagBubble({
    required this.flag,
    required this.cardColor,
    required this.borderColor,
  });

  final String flag;
  final Color cardColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.textBlack.withValues(alpha: 0.08),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Text(
        flag,
        style: AppTextStyleFactory.style(
          size: AppFontSizes.titleLarge,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}

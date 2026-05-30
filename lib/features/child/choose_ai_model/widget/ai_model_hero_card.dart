import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class AiModelHeroCard extends StatelessWidget {
  const AiModelHeroCard({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: Offset(0, 12.h),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EyebrowChip(isDark: isDark, label: s.aiModelHeroEyebrow),
          SizedBox(height: 14.h),
          Text(
            s.aiModelHeroTitle,
            style: context.typo.headline.medium.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.08,
              color: textColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            s.aiModelHeroSubtitle,
            style: context.typo.body.medium.copyWith(
              color: mutedColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _EyebrowChip extends StatelessWidget {
  const _EyebrowChip({required this.isDark, required this.label});

  final bool isDark;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(999.r),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.r,
            height: 8.r,
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: context.typo.body.small.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.primary,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

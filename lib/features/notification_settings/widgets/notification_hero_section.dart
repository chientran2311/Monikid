import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class NotificationHeroSection extends StatelessWidget {
  const NotificationHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(isDark: isDark, label: s.notificationSettingsEyebrow),
          SizedBox(height: 14.h),
          Text(
            s.notificationSettingsHeroTitle,
            style: context.typo.display.medium.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: -1.2,
              height: 1.12,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            s.notificationSettingsHeroSubtitle,
            style: context.typo.body.medium.copyWith(
              color: mutedColor,
              height: 1.52,
            ),
          ),
        ],
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.isDark, required this.label});

  final bool isDark;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 28.h,
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.primaryDark.withValues(alpha: 0.3)
            : AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primary,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.35),
                  blurRadius: 0,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: context.typo.label.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: isDark ? AppTheme.primary : AppTheme.primaryDark,
              letterSpacing: 0.04,
            ),
          ),
        ],
      ),
    );
  }
}

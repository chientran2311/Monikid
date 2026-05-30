import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/notification_settings/widgets/notification_glass_card.dart';

class NotificationScheduleCard extends StatelessWidget {
  const NotificationScheduleCard({
    super.key,
    required this.timeText,
    required this.onTimeTap,
    required this.isDark,
  });

  final String timeText;
  final VoidCallback onTimeTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return NotificationGlassCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.notificationSettingsScheduleSection,
                style: context.typo.label.big.copyWith(
                  fontWeight: FontWeight.w800,
                  color: mutedColor,
                  letterSpacing: 0.05,
                ),
              ),
              Text(
                s.notificationSettingsScheduleNote,
                style: context.typo.label.medium.copyWith(color: mutedColor),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Time row
          GestureDetector(
            onTap: onTimeTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.notificationSettingsTimeLabel,
                        style: context.typo.body.big.copyWith(
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          letterSpacing: -0.01,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        s.notificationSettingsTimeHint,
                        style: context.typo.body.small.copyWith(
                          color: mutedColor,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Row(
                  children: [
                    _TimePill(timeText: timeText, isDark: isDark),
                    SizedBox(width: 4.w),
                    Icon(Icons.chevron_right_rounded, size: 16.r, color: mutedColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimePill extends StatelessWidget {
  const _TimePill({required this.timeText, required this.isDark});

  final String timeText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 78.w),
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.7),
            offset: const Offset(0, 1),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          timeText,
          style: context.typo.subtitle.small.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppTheme.textBlack,
            letterSpacing: -0.01,
          ),
        ),
      ),
    );
  }
}

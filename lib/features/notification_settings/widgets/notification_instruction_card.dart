import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/notification_settings/widgets/notification_tip_item.dart';

class NotificationInstructionCard extends StatelessWidget {
  const NotificationInstructionCard({super.key, required this.isChild});

  final bool isChild;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    final instructionTitle = isChild
        ? s.notificationSettingsInstructionTitleChild
        : s.notificationSettingsInstructionTitle;
    final instructionDesc = isChild
        ? s.notificationSettingsInstructionDescChild
        : s.notificationSettingsInstructionDesc;
    final tip1 = isChild ? s.notificationSettingsTip1Child : s.notificationSettingsTip1;
    final tip2 = isChild ? s.notificationSettingsTip2Child : s.notificationSettingsTip2;
    final tip3 = isChild ? s.notificationSettingsTip3Child : s.notificationSettingsTip3;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF499666).withValues(alpha: 0.10),
            blurRadius: 34,
            offset: Offset(0, 16.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [AppTheme.surfaceDark.withValues(alpha: 0.95), AppTheme.surfaceDark.withValues(alpha: 0.95)]
                    : [const Color(0xFFEFFFF5).withValues(alpha: 0.95), Colors.white.withValues(alpha: 0.95)],
              ),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: isDark ? AppTheme.borderDark : AppTheme.primary.withValues(alpha: 0.18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Badge(),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            instructionTitle,
                            style: context.typo.title.small.copyWith(
                              fontWeight: FontWeight.w700,
                              color: textColor,
                              letterSpacing: -0.02,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            instructionDesc,
                            style: context.typo.body.medium.copyWith(color: mutedColor, height: 1.56),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                NotificationTipItem(number: '1', text: tip1, textColor: textColor, isDark: isDark),
                SizedBox(height: 10.h),
                NotificationTipItem(number: '2', text: tip2, textColor: textColor, isDark: isDark),
                SizedBox(height: 10.h),
                NotificationTipItem(number: '3', text: tip3, textColor: textColor, isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF48AE70).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Icon(Icons.upload_rounded, color: Colors.white, size: 20.r),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/notification_settings/widgets/notification_glass_card.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';

class NotificationToggleCard extends StatelessWidget {
  const NotificationToggleCard({
    super.key,
    required this.enabled,
    required this.onChanged,
    required this.isDark,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return NotificationGlassCard(
      isDark: isDark,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _IconBox(),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.notificationSettingsEnableLabel,
                  style: context.typo.body.big.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: -0.01,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  s.notificationSettingsEnableHint,
                  style: context.typo.body.small.copyWith(
                    color: mutedColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          AppIosSwitch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.r,
      height: 48.r,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.primaryLight, Color(0xFFC8E6C9)],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(Icons.notifications_outlined, color: AppTheme.primaryDark, size: 24.r),
    );
  }
}

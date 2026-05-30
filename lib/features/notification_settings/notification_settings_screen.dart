import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/notification_settings/notification_settings_provider.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(notificationSettingsNotifierProvider);
    final notifier = ref.read(notificationSettingsNotifierProvider.notifier);

    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final cardColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final dividerColor = isDark
        ? AppTheme.borderDark.withValues(alpha: 0.5)
        : AppTheme.borderLight;

    ref.listen(notificationSettingsNotifierProvider, (_, next) {
      if (next.hasError && next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: textColor, size: 20.r),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          s.notificationSettingsTitle,
          style: context.typo.subtitle.medium.copyWith(color: textColor),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          _SectionLabel(label: s.notificationSettingsDailySection, color: mutedColor),
          SizedBox(height: 8.h),
          _Card(
            cardColor: cardColor,
            borderColor: borderColor,
            isDark: isDark,
            children: [
              _ToggleRow(
                icon: Icons.notifications_outlined,
                label: s.notificationSettingsEnableLabel,
                textColor: textColor,
                value: state.enabled,
                onChanged: (v) => notifier.toggleEnabled(v),
              ),
              Divider(height: 1, thickness: 1, color: dividerColor),
              _TimeRow(
                icon: Icons.access_time_rounded,
                label: s.notificationSettingsTimeLabel,
                textColor: textColor,
                timeText: state.formattedTime,
                onTap: () => _pickTime(context, ref, state.hour, state.minute),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _SectionLabel(label: s.notificationSettingsAboutSection, color: mutedColor),
          SizedBox(height: 8.h),
          _Card(
            cardColor: cardColor,
            borderColor: borderColor,
            isDark: isDark,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Text(
                  s.notificationSettingsDescription,
                  style: context.typo.body.medium.copyWith(color: mutedColor, height: 1.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(
      BuildContext context, WidgetRef ref, int hour, int minute) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );
    if (picked == null) return;
    await ref
        .read(notificationSettingsNotifierProvider.notifier)
        .updateTime(picked.hour, picked.minute);
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 0),
      child: Text(
        label,
        style: context.typo.label.medium.copyWith(fontWeight: FontWeight.w600, color: color, letterSpacing: 0.6),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.cardColor,
    required this.borderColor,
    required this.isDark,
    required this.children,
  });

  final Color cardColor;
  final Color borderColor;
  final bool isDark;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25.r),
        border: isDark ? Border.all(color: borderColor, width: 0.5) : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.textColor,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final Color textColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 22.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ),
          AppIosSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.icon,
    required this.label,
    required this.textColor,
    required this.timeText,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color textColor;
  final String timeText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 22.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.w500, color: textColor),
              ),
            ),
            Text(
              timeText,
              style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primary),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right_rounded,
                size: 18.r, color: AppTheme.textMuted),
          ],
        ),
      ),
    );
  }
}

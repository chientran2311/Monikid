import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'widgets/setting_group.dart';
import 'widgets/setting_item.dart';
import 'widgets/switch_item.dart';

class SettingTabParent extends HookConsumerWidget {
  const SettingTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pushNotification = useState(true);

    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : const Color(0xFFF4F4F5),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 24.h),
              child: Text(
                s.settingParTitle,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
            SettingGroup(
              title: s.settingParFamilyTitle,
              titleColor: mutedColor,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              isDark: isDark,
              children: [
                SettingItem(
                  icon: Icons.group_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.settingParManageFamilyLabel,
                  textColor: textColor,
                  borderColor: borderColor,
                  showBorder: false,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SettingGroup(
              title: s.settingParNotificationsTitle,
              titleColor: mutedColor,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              isDark: isDark,
              children: [
                SwitchItem(
                  icon: Icons.notifications_active_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.settingParPushLabel,
                  value: pushNotification.value,
                  onChanged: (v) => pushNotification.value = v,
                  textColor: textColor,
                  borderColor: borderColor,
                  activeColor: AppTheme.primary,
                  showBorder: false,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _SignOutButton(
              label: s.settingParLogoutLabel,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    required this.label,
    required this.surfaceColor,
    required this.borderColor,
  });

  final String label;
  final Color surfaceColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor, width: 0.5),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.redAlert,
            ),
          ),
        ),
      ),
    );
  }
}

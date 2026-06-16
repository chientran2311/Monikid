import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/change_theme/change_theme_provider.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/logout_dialog.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/theme_toggle_switch.dart';
import 'widgets/setting_group.dart';
import 'widgets/setting_item.dart';

class SettingTabParent extends ConsumerWidget {
  const SettingTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Future<void> handleSignOut() async {
      final confirmed = await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.4),
        builder: (_) => LogoutDialog(
          title: s.settingParLogoutLabel,
          message: s.settingSignOutConfirm,
          confirmLabel: s.settingParLogoutLabel,
          cancelLabel: s.actionCancel,
        ),
      );
      if (confirmed != true || !context.mounted) return;
      try {
        await ref.read(authSessionProvider.notifier).signOut();
      } catch (_) {
        if (context.mounted) {
          context.showErrorSnackBar(s.settingSignOutFailed);
        }
      }
    }

    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      body: AppBackground(
        child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 24.h),
              child: Text(
                s.settingParTitle,
                style: context.typo.display.small.copyWith(
                color: textColor,
              ),
              ),
            ),
            SettingGroup(
              title: s.settingParAccountTitle,
              titleColor: mutedColor,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              isDark: isDark,
              children: [
                SettingItem(
                  icon: Icons.person_outline_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.settingParEditProfile,
                  textColor: textColor,
                  borderColor: borderColor,
                  showBorder: false,
                  onTap: () => context.push(AppRoutes.profileEdit),
                ),
              ],
            ),
            SizedBox(height: 24.h),
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
                  onTap: () => context.push(AppRoutes.manageFamily),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SettingGroup(
              title: s.settingNotificationsLabel,
              titleColor: mutedColor,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              isDark: isDark,
              children: [
                SettingItem(
                  icon: Icons.notifications_outlined,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.notificationSettingsTitle,
                  textColor: textColor,
                  borderColor: borderColor,
                  showBorder: false,
                  onTap: () => context.push(AppRoutes.scheduleNotification),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SettingGroup(
              title: s.settingParAppearanceTitle,
              titleColor: mutedColor,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              isDark: isDark,
              children: [
                _ThemeSettingItem(
                  textColor: textColor,
                  borderColor: borderColor,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(height: 10.h),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: PrimaryButton.danger(
                  title: s.settingParLogoutLabel,
                  icon: const Icon(Icons.logout_rounded),
                  onTap: handleSignOut,
                  borderRadius: 999.r,
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      ),
    );
  }
}

class _ThemeSettingItem extends ConsumerWidget {
  const _ThemeSettingItem({
    required this.textColor,
    required this.borderColor,
  });

  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = ref.watch(changeThemeProvider).isDark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.dark_mode_outlined,
              color: AppTheme.primary,
              size: 18.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              s.settingThemeDarkLabel,
              style: context.typo.subtitle.small.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          ThemeToggleSwitch(
            value: isDark,
            onChanged: (value) =>
                ref.read(changeThemeProvider.notifier).setDark(value),
          ),
        ],
      ),
    );
  }
}

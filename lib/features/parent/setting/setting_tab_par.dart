import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';
import 'package:monikid/shared/widgets/app_theme_switch.dart';
import 'widgets/setting_group.dart';
import 'widgets/setting_item.dart';

class SettingTabParent extends ConsumerWidget {
  const SettingTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Future<void> handleSignOut() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => ConfirmDialog(
          title: s.settingParLogoutLabel,
          message: s.settingSignOutConfirm,
          confirmLabel: s.settingParLogoutLabel,
          cancelLabel: s.actionCancel,
          confirmColor: AppTheme.redAlert,
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
              title: s.settingParAppearanceTitle,
              titleColor: mutedColor,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              isDark: isDark,
              children: [
                _ThemeSettingItem(
                  isDark: isDark,
                  textColor: textColor,
                  borderColor: borderColor,
                  onChanged: (value) {
                    // TODO: Implement theme switching logic with provider
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Theme switching coming soon!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _SignOutButton(
              label: s.settingParLogoutLabel,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              onTap: handleSignOut,
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
    required this.onTap,
  });

  final String label;
  final Color surfaceColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
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

class _ThemeSettingItem extends StatelessWidget {
  const _ThemeSettingItem({
    required this.isDark,
    required this.textColor,
    required this.borderColor,
    required this.onChanged,
  });

  final bool isDark;
  final Color textColor;
  final Color borderColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    
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
              Icons.palette_outlined,
              color: AppTheme.primary,
              size: 18.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              s.settingParThemeLabel,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          AppThemeSwitch(
            isDark: isDark,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/change_language/change_language_dialog.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/child/setting/widgets/setting_group.dart';
import 'package:monikid/features/child/setting/widgets/setting_item.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';

class SettingTabStudent extends ConsumerWidget {
  const SettingTabStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor =
        isDark ? AppTheme.textMuted : AppTheme.textGrey;

    final langCode =
        ref.watch(changeLanguageProvider).localeCode;

    Future<void> handleSignOut() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => ConfirmDialog(
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
                s.settingStuTitle,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),

            _SectionLabel(
                title: s.settingStuSectionGeneral, color: mutedColor),
            SizedBox(height: 8.h),
            SettingGroup(
              children: [
                SettingItem(
                  icon: Icons.language_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.language,
                  showBorder: true,
                  trailing: Text(
                    langCode == 'vi' ? s.vietnamese : s.english,
                    style: TextStyle(fontSize: 14.sp, color: mutedColor),
                  ),
                  showChevron: true,
                  onTap: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ChangeLanguageDialog(),
                  ),
                ),
                SettingItem(
                  icon: Icons.smart_toy_outlined,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.chooseAiModelTitle,
                  showBorder: false,
                  onTap: () => context.push(AppRoutes.chooseAiModel),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            _SectionLabel(
                title: s.settingStuSectionAccount, color: mutedColor),
            SizedBox(height: 8.h),
            SettingGroup(
              children: [
                SettingItem(
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.settingStuBudgetLabel,
                  showBorder: true,
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.family_restroom_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.settingStuFamilyCodeLabel,
                  showBorder: true,
                  trailing: Icon(
                    Icons.qr_code_2_rounded,
                    size: 18.r,
                    color: mutedColor,
                  ),
                  onTap: () => context.push(AppRoutes.joinFamily),
                ),
                SettingItem(
                  icon: Icons.lock_reset_rounded,
                  iconColor: AppTheme.primary,
                  iconBgColor: AppTheme.primaryLight,
                  title: s.settingParChangePasswordLabel,
                  showBorder: false,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 24.h),

            _SignOutCard(
              isDark: isDark,
              label: s.settingParLogoutLabel,
              onTap: handleSignOut,
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: color,
        ),
      ),
    );
  }
}

class _SignOutCard extends StatelessWidget {
  const _SignOutCard({
    required this.isDark,
    required this.label,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final errorColor =
        isDark ? const Color(0xFFF87171) : const Color(0xFFDC2626);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 0.5),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: errorColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

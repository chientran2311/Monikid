import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/change_language/change_language_dialog.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/change_theme/change_theme_provider.dart';
import 'package:monikid/features/child/setting/widgets/setting_group.dart';
import 'package:monikid/features/child/setting/widgets/setting_item.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/logout_dialog.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/theme_toggle_switch.dart';

class SettingTabStudent extends ConsumerWidget {
  const SettingTabStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final langCode = ref.watch(changeLanguageProvider).localeCode;

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

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
      body: AppBackground(
        whiteBackground: true,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              SizedBox(height: 24.h),
              _SettingHeader(
                eyebrowLabel: s.settingStuEyebrow,
                title: s.settingStuTitle,
                subtitle: s.settingStuSubtitle,
                isDark: isDark,
              ),
              SizedBox(height: 24.h),
              _SettingsList(langCode: langCode, isDark: isDark),
              SizedBox(height: 20.h),
              SizedBox(height: 10.h),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: PrimaryButton.danger(
                    title: s.settingParLogoutLabel,
                    onTap: handleSignOut,
                    borderRadius: 999.r,
                  ),
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingHeader extends StatelessWidget {
  const _SettingHeader({
    required this.eyebrowLabel,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  final String eyebrowLabel;
  final String title;
  final String subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7.r,
                height: 7.r,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                eyebrowLabel,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                  letterSpacing: 0.02,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          title,
          style: context.typo.display.small.copyWith(
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.03,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          subtitle,
          style: context.typo.body.medium.copyWith(
            color: mutedColor,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList({required this.langCode, required this.isDark});

  final String langCode;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return SettingGroup(
      children: [
        SettingItem(
          icon: Icons.language_rounded,
          iconColor: AppTheme.primary,
          iconBgColor: AppTheme.primaryLight,
          title: s.language,
          subtitle: langCode == 'vi' ? s.vietnamese : s.english,
          showBorder: true,
          onTap: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const ChangeLanguageDialog(),
          ),
        ),
        SettingItem(
          icon: Icons.notifications_outlined,
          iconColor: AppTheme.primary,
          iconBgColor: AppTheme.primaryLight,
          title: s.settingNotificationsLabel,
          subtitle: s.settingStuNotificationsSubtitle,
          showBorder: true,
          onTap: () => context.push(AppRoutes.scheduleNotification),
        ),
        SettingItem(
          icon: Icons.smart_toy_outlined,
          iconColor: AppTheme.primary,
          iconBgColor: AppTheme.primaryLight,
          title: s.chooseAiModelTitle,
          subtitle: s.settingStuAiModelSubtitle,
          showBorder: true,
          onTap: () => context.push(AppRoutes.chooseAiModel),
        ),
        SettingItem(
          icon: Icons.person_outline_rounded,
          iconColor: AppTheme.primary,
          iconBgColor: AppTheme.primaryLight,
          title: s.settingStuProfileEditLabel,
          subtitle: s.settingStuProfileEditSubtitle,
          showBorder: true,
          onTap: () => context.push(AppRoutes.profileEdit),
        ),
        SettingItem(
          icon: Icons.family_restroom_rounded,
          iconColor: AppTheme.primary,
          iconBgColor: AppTheme.primaryLight,
          title: s.settingStuFamilyCodeLabel,
          subtitle: s.settingStuFamilyCodeSubtitle,
          showBorder: true,
          trailing: Icon(Icons.qr_code_2_rounded, size: 18.r, color: mutedColor),
          onTap: () => context.push(AppRoutes.joinFamily),
        ),
        SettingItem(
          icon: Icons.help_outline_rounded,
          iconColor: AppTheme.primary,
          iconBgColor: AppTheme.primaryLight,
          title: s.settingFAQ,
          subtitle: s.settingStuFaqSubtitle,
          showBorder: true,
          onTap: () => context.push(AppRoutes.faq),
        ),
        Consumer(
          builder: (context, ref, _) {
            final isDark = ref.watch(changeThemeProvider).isDark;
            return SettingItem(
              icon: Icons.dark_mode_outlined,
              iconColor: AppTheme.primary,
              iconBgColor: AppTheme.primaryLight,
              title: s.settingThemeDarkLabel,
              subtitle: s.settingThemeDarkSubtitle,
              showChevron: false,
              showBorder: kDebugMode,
              trailing: ThemeToggleSwitch(
                value: isDark,
                onChanged: (value) =>
                    ref.read(changeThemeProvider.notifier).setDark(value),
              ),
              onTap: () =>
                  ref.read(changeThemeProvider.notifier).setDark(!isDark),
            );
          },
        ),
        if (kDebugMode)
          SettingItem(
            icon: Icons.developer_mode_rounded,
            iconColor: AppTheme.primary,
            iconBgColor: AppTheme.primaryLight,
            title: 'Dev Tools',
            subtitle: 'Mock data & testing utilities',
            showBorder: false,
            onTap: () => context.push(AppRoutes.devTools),
          ),
      ],
    );
  }
}

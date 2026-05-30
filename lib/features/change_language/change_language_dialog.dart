import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';

class ChangeLanguageDialog extends ConsumerWidget {
  const ChangeLanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;

    final languages = [
      {'code': 'vi', 'label': s.vietnamese, 'subtitle': s.languageVietnameseSubtitle},
      {'code': 'en', 'label': s.english, 'subtitle': s.languageEnglishSubtitle},
    ];
    final currentLocaleCode = ref.watch(changeLanguageProvider).localeCode;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DialogHeader(isDark: isDark, onDone: () => context.pop()),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
                child: Column(
                  children: languages.map((lang) {
                    final isSelected = currentLocaleCode == lang['code'];
                    return _LanguageOption(
                      label: lang['label']!,
                      subtitle: lang['subtitle']!,
                      isSelected: isSelected,
                      isDark: isDark,
                      onTap: () async {
                        await ref
                            .read(changeLanguageProvider.notifier)
                            .setLanguage(lang['code']!);
                        if (context.mounted) context.pop(lang['code']);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.isDark, required this.onDone});

  final bool isDark;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(22.w, 22.h, 22.w, 16.h),
          child: Row(
            children: [
              const Spacer(),
              Text(
                s.language,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppTheme.textWhite : AppTheme.primaryDark,
                  letterSpacing: -0.4,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _DoneChip(isDark: isDark, onTap: onDone),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: isDark
              ? AppTheme.borderDark
              : AppTheme.primary.withValues(alpha: 0.10),
        ),
      ],
    );
  }
}

class _DoneChip extends StatelessWidget {
  const _DoneChip({required this.isDark, required this.onTap});

  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.primary.withValues(alpha: 0.15)
              : AppTheme.primaryLight,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppTheme.primary.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Text(
          s.actionDone,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? AppTheme.primary.withValues(alpha: 0.12)
                  : AppTheme.primaryLight.withValues(alpha: 0.9))
              : (isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLight),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary.withValues(alpha: 0.35)
                : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? (isDark ? AppTheme.textWhite : AppTheme.primaryDark)
                          : (isDark
                              ? AppTheme.textWhite
                              : AppTheme.surfaceVeryDark),
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _CheckCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: 28.r,
      height: 28.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryButtonGradientTop,
                  AppTheme.primaryButtonGradientBottom,
                ],
              )
            : null,
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : AppTheme.primary.withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isSelected ? 1.0 : 0.0,
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 16.r,
        ),
      ),
    );
  }
}

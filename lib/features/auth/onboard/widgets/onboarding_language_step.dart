import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/onboard/widgets/language_option_tile.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_language_illustration.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_step_scaffold.dart';

class OnboardingLanguageStep extends StatelessWidget {
  const OnboardingLanguageStep({
    super.key,
    required this.selectedLocaleCode,
    required this.isFinishing,
    required this.onSkip,
    required this.onContinue,
    required this.onSelectLanguage,
  });

  final String selectedLocaleCode;
  final bool isFinishing;
  final VoidCallback onSkip;
  final VoidCallback onContinue;
  final ValueChanged<String> onSelectLanguage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OnboardingStepScaffold(
      isFinishing: isFinishing,
      onSkip: onSkip,
      onContinue: onContinue,
      continueLabel: l10n.onboardingContinueAction,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: ScreenUtils.screenHeight - 188.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OnboardingLanguageIllustration(),
              SizedBox(height: 32.h),
              const _LanguageHeading(),
              SizedBox(height: 36.h),
              LanguageOptionTile(
                flag: '🇻🇳',
                label: l10n.vietnamese,
                isSelected: selectedLocaleCode == 'vi',
                onPressed: () => onSelectLanguage('vi'),
              ),
              SizedBox(height: 12.h),
              LanguageOptionTile(
                flag: '🇺🇸',
                label: l10n.english,
                isSelected: selectedLocaleCode == 'en',
                onPressed: () => onSelectLanguage('en'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageHeading extends StatelessWidget {
  const _LanguageHeading();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyleFactory.style(
              size: AppFontSizes.bigTitleSmall,
              weight: FontWeight.w800,
              color: textColor,
              height: 1.15,
            ),
            children: [
              TextSpan(text: '${l10n.onboardingLanguageTitleLeading} '),
              TextSpan(
                text: l10n.onboardingLanguageTitleHighlight,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.bigTitleSmall,
                  weight: FontWeight.w800,
                  color: AppTheme.primary,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            l10n.onboardingLanguageDescription,
            textAlign: TextAlign.center,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.textMedium,
              weight: FontWeight.w500,
              color: AppTheme.textGrey,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

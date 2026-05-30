import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/onboard/widgets/language_option_tile.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_brand_header.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_hero_card.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

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

    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingBrandHeader(),
          SizedBox(height: 16.h),
          OnboardingHeroCard(
            title: '${l10n.onboardingLanguageTitleLeading} '
                '${l10n.onboardingLanguageTitleHighlight}',
            subtitle: l10n.onboardingLanguageSubtitle,
          ),
          const Spacer(),
          _LanguageSelectionCard(
            selectedLocaleCode: selectedLocaleCode,
            isFinishing: isFinishing,
            onSelectLanguage: onSelectLanguage,
            onContinue: onContinue,
            onSkip: onSkip,
          ),
        ],
      ),
    );
  }
}

class _LanguageSelectionCard extends StatelessWidget {
  const _LanguageSelectionCard({
    required this.selectedLocaleCode,
    required this.isFinishing,
    required this.onSelectLanguage,
    required this.onContinue,
    required this.onSkip,
  });

  final String selectedLocaleCode;
  final bool isFinishing;
  final ValueChanged<String> onSelectLanguage;
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final borderColor = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;
    final badgeBg = Color.lerp(AppTheme.primary, Colors.white, 0.84)!;
    final badgeBorder = Color.lerp(AppTheme.primary, Colors.white, 0.78)!;
    final hintBg = Color.lerp(AppTheme.primary, Colors.white, 0.90)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(26.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceLight.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(26.r),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 22.h),
                blurRadius: 60.r,
                color: AppTheme.primary.withValues(alpha: 0.12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.onboardingLanguageCardTitle,
                          style: AppTextStyleFactory.style(
                            size: AppFontSizes.titleSmall,
                            weight: FontWeight.w700,
                            color: AppTheme.textBlack,
                            letterSpacing: -0.02,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          l10n.onboardingLanguageCardDesc,
                          style: AppTextStyleFactory.style(
                            size: AppFontSizes.captionBig,
                            weight: FontWeight.w400,
                            color: AppTheme.textGrey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: badgeBorder),
                    ),
                    child: Center(
                      child: Text(
                        '文',
                        style: AppTextStyleFactory.style(
                          size: AppFontSizes.titleSmall,
                          weight: FontWeight.w900,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              // Language options
              LanguageOptionTile(
                flag: '🇻🇳',
                label: l10n.vietnamese,
                description: l10n.onboardingLanguageViDesc,
                isSelected: selectedLocaleCode == 'vi',
                onPressed: () => onSelectLanguage('vi'),
              ),
              SizedBox(height: 10.h),
              LanguageOptionTile(
                flag: '🇬🇧',
                label: l10n.english,
                description: l10n.onboardingLanguageEnDesc,
                isSelected: selectedLocaleCode == 'en',
                onPressed: () => onSelectLanguage('en'),
              ),
              SizedBox(height: 12.h),
              // Hint box
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: hintBg,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Color.lerp(AppTheme.primary, Colors.white, 0.78)!,
                  ),
                ),
                child: Text(
                  l10n.onboardingLanguageHint,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.captionBig,
                    weight: FontWeight.w400,
                    color: AppTheme.textGrey,
                    height: 1.45,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              PrimaryButton(
                title: l10n.onboardingContinueAction,
                onTap: isFinishing ? null : onContinue,
                isLoading: isFinishing,
                height: 65.h,
              ),
              SizedBox(height: 10.h),
              PrimaryButton.secondary(
                title: l10n.onboardingSkipLater,
                onTap: isFinishing ? null : onSkip,
                height: 65.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/onboard/widgets/currency_option_tile.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_currency_illustration.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_step_scaffold.dart';

class OnboardingCurrencyStep extends StatelessWidget {
  const OnboardingCurrencyStep({
    super.key,
    required this.selectedCurrencyCode,
    required this.isFinishing,
    required this.onSkip,
    required this.onContinue,
    required this.onSelectCurrency,
    required this.continueLabel,
  });

  final String selectedCurrencyCode;
  final bool isFinishing;
  final VoidCallback onSkip;
  final VoidCallback onContinue;
  final ValueChanged<String> onSelectCurrency;
  final String continueLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OnboardingStepScaffold(
      isFinishing: isFinishing,
      onSkip: onSkip,
      onContinue: onContinue,
      continueLabel: continueLabel,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: ScreenUtils.screenHeight - 188.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OnboardingCurrencyIllustration(),
              SizedBox(height: 32.h),
              _CurrencyHeading(
                title: l10n.onboardingCurrencyTitle,
                description: l10n.onboardingCurrencyDescription,
              ),
              SizedBox(height: 32.h),
              CurrencyOptionTile(
                symbol: '₫',
                label: l10n.onboardingCurrencyVnd,
                isSelected: selectedCurrencyCode == 'vnd',
                onPressed: () => onSelectCurrency('vnd'),
              ),
              SizedBox(height: 12.h),
              CurrencyOptionTile(
                symbol: r'$',
                label: l10n.onboardingCurrencyUsd,
                isSelected: selectedCurrencyCode == 'usd',
                onPressed: () => onSelectCurrency('usd'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyHeading extends StatelessWidget {
  const _CurrencyHeading({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyleFactory.style(
            size: AppFontSizes.bigTitleMedium,
            weight: FontWeight.w800,
            color: textColor,
            height: 1.16,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyleFactory.style(
            size: AppFontSizes.subtitleSmall,
            weight: FontWeight.w500,
            color: AppTheme.textGrey,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

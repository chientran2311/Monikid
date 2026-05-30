import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_bell_art_card.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_benefit_item.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_brand_header.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_hero_card.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class OnboardingNotificationStep extends StatelessWidget {
  const OnboardingNotificationStep({
    super.key,
    required this.isFinishing,
    required this.onAllow,
    required this.onDeny,
  });

  final bool isFinishing;
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final borderColor = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;

    return Stack(
      children: [
        // Scrollable main content
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 160.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingBrandHeader(),
              SizedBox(height: 16.h),
              OnboardingHeroCard(
                title: l10n.onboardingNotificationTitle,
                subtitle: l10n.onboardingNotificationSubtitle,
              ),
              SizedBox(height: 16.h),
              const OnboardingBellArtCard(),
              SizedBox(height: 16.h),
              _BenefitsCard(borderColor: borderColor),
            ],
          ),
        ),
        // Fixed bottom CTA buttons — Allow triggers OS dialog, Deny skips
        Positioned(
          left: 18.w,
          right: 18.w,
          bottom: 24.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                title: l10n.onboardingNotificationEnableBtn,
                onTap: isFinishing ? null : onAllow,
                isLoading: isFinishing,
                height: 65.h,
              ),
              SizedBox(height: 10.h),
              PrimaryButton.secondary(
                title: l10n.onboardingSkipLater,
                onTap: isFinishing ? null : onDeny,
                height: 65.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BenefitsCard extends StatelessWidget {
  const _BenefitsCard({required this.borderColor});

  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final badgeBg = Color.lerp(AppTheme.primary, Colors.white, 0.84)!;
    final badgeBorder = Color.lerp(AppTheme.primary, Colors.white, 0.78)!;

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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.onboardingNotificationBenefitsTitle,
                          style: AppTextStyleFactory.style(
                            size: AppFontSizes.titleSmall,
                            weight: FontWeight.w700,
                            color: AppTheme.textBlack,
                            letterSpacing: -0.02,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          l10n.onboardingNotificationBenefitsDesc,
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
                        '✓',
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
              SizedBox(height: 10.h),
              OnboardingBenefitItem(
                icon: '💳',
                title: l10n.onboardingNotificationBenefit1Title,
                description: l10n.onboardingNotificationBenefit1Desc,
              ),
              SizedBox(height: 10.h),
              OnboardingBenefitItem(
                icon: '📉',
                title: l10n.onboardingNotificationBenefit2Title,
                description: l10n.onboardingNotificationBenefit2Desc,
              ),
              SizedBox(height: 10.h),
              OnboardingBenefitItem(
                icon: '👨‍👩‍👧',
                title: l10n.onboardingNotificationBenefit3Title,
                description: l10n.onboardingNotificationBenefit3Desc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

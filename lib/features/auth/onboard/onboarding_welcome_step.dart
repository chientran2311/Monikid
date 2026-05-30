import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_welcome_hero.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class OnboardingWelcomeStep extends StatelessWidget {
  const OnboardingWelcomeStep({
    super.key,
    required this.isFinishing,
    required this.onStart,
  });

  final bool isFinishing;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 120.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              const OnboardingWelcomeHero(),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  l10n.onboardingWelcomeTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.displaySmall,
                    weight: FontWeight.w800,
                    color: AppTheme.textBlack,
                    letterSpacing: -0.02,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  l10n.onboardingWelcomeSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.bodyMedium,
                    weight: FontWeight.w400,
                    color: AppTheme.textGrey,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    _FeatureItem(
                      icon: Icons.calendar_month_outlined,
                      title: l10n.onboardingWelcomeFeature1Title,
                      description: l10n.onboardingWelcomeFeature1Desc,
                    ),
                    SizedBox(height: 12.h),
                    _FeatureItem(
                      icon: Icons.document_scanner_outlined,
                      title: l10n.onboardingWelcomeFeature2Title,
                      description: l10n.onboardingWelcomeFeature2Desc,
                    ),
                    SizedBox(height: 12.h),
                    _FeatureItem(
                      icon: Icons.people_outline,
                      title: l10n.onboardingWelcomeFeature3Title,
                      description: l10n.onboardingWelcomeFeature3Desc,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Fixed bottom CTA with gradient fade (from HTML .action-area)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 34.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.backgroundLight.withValues(alpha: 0),
                  AppTheme.backgroundLight.withValues(alpha: 0.9),
                  AppTheme.backgroundLight,
                ],
                stops: const [0.0, 0.2, 1.0],
              ),
            ),
            child: PrimaryButton(
              title: l10n.onboardingWelcomeStartBtn,
              onTap: isFinishing ? null : onStart,
              isLoading: isFinishing,
              icon: const Icon(Icons.arrow_forward_rounded),
              height: 60.h,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppTheme.borderLight),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8.h),
            blurRadius: 24.r,
            color: AppTheme.textBlack.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Center(
              child: Icon(icon, color: AppTheme.primary, size: 24.r),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.bodyBig,
                    weight: FontWeight.w700,
                    color: AppTheme.textBlack,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
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
        ],
      ),
    );
  }
}

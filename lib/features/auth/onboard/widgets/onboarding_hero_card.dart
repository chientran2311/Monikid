import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';

class OnboardingHeroCard extends StatelessWidget {
  const OnboardingHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final borderColor = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
          decoration: BoxDecoration(
            color: AppTheme.surfaceLight.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyleFactory.style(
                  size: 34,
                  weight: FontWeight.w900,
                  color: AppTheme.textBlack,
                  height: 1.02,
                  letterSpacing: -0.045,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                subtitle,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.bodyMedium,
                  weight: FontWeight.w400,
                  color: AppTheme.textGrey,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

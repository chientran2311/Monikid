import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';

class OnboardingBrandHeader extends StatelessWidget {
  const OnboardingBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppTheme.primary, AppTheme.primaryDark],
            ),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: Color.lerp(AppTheme.primary, Colors.white, 0.65)!,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 30.r,
                color: AppTheme.primary.withValues(alpha: 0.20),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'M',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.bodyBig,
                weight: FontWeight.w900,
                color: AppTheme.textWhite,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          'Monikid',
          style: AppTextStyleFactory.style(
            size: AppFontSizes.titleMedium,
            weight: FontWeight.w900,
            color: AppTheme.textBlack,
            letterSpacing: -0.03,
          ),
        ),
      ],
    );
  }
}

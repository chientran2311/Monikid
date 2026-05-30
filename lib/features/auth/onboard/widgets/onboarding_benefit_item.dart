import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';

class OnboardingBenefitItem extends StatelessWidget {
  const OnboardingBenefitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final borderColor = Color.lerp(AppTheme.textBlack, Colors.transparent, 0.88)!;
    final iconBg = Color.lerp(AppTheme.primary, Colors.white, 0.90)!;
    final iconBorder = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: iconBorder),
            ),
            child: Center(
              child: Text(icon, style: TextStyle(fontSize: 16.sp)),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.bodyMedium,
                    weight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -0.015,
                  ),
                ),
                SizedBox(height: 3.h),
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

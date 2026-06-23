import 'package:flutter/material.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
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
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                blurRadius: 30.r,
                color: AppTheme.primary.withValues(alpha: 0.20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9.r),
            child: Image.asset(
              'assets/app_icon.png',
              width: 36.r,
              height: 36.r,
              cacheWidth: decodePixelsFor(context, 36.r),
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

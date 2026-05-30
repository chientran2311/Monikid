import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Top brand row: M logo + "Monikid" app name.
/// Shared by login and register screens.
class BrandRow extends StatelessWidget {
  const BrandRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 34.r,
          height: 34.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.primary, AppTheme.primaryDark],
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 12.h),
                blurRadius: 24.r,
                color: AppTheme.primary.withValues(alpha: 0.15),
              ),
            ],
            border: Border.all(
              color: Color.lerp(AppTheme.primary, Colors.white, 0.65)!,
            ),
          ),
          child: Center(
            child: Text(
              'M',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.titleMedium,
                weight: FontWeight.w900,
                color: Colors.white,
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

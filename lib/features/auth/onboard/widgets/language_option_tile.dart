import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/bounce_tap.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.flag,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onPressed,
  });

  final String flag;
  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? Color.lerp(AppTheme.primary, Colors.white, 0.45)!
        : Color.lerp(AppTheme.textBlack, Colors.transparent, 0.82)!;
    final flagBg = Color.lerp(AppTheme.primary, Colors.white, 0.90)!;
    final flagBorder = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;

    return BounceTap(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    blurRadius: 0,
                    spreadRadius: 1.r,
                    color: AppTheme.primary.withValues(alpha: 0.08),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: flagBg,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: flagBorder),
              ),
              child: Center(
                child: Text(flag, style: TextStyle(fontSize: 18.sp)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyleFactory.style(
                      size: 15,
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
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppTheme.primary : AppTheme.surfaceLight,
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primary
                      : Color.lerp(AppTheme.primary, Colors.white, 0.82)!,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          blurRadius: 18.r,
                          color: AppTheme.primary.withValues(alpha: 0.22),
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded,
                      color: AppTheme.textWhite, size: 14.r)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

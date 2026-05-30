import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ScreenPageHeader extends StatelessWidget {
  const ScreenPageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    required this.isDark,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7.r,
                height: 7.r,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                eyebrow,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                  letterSpacing: 0.02,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          title,
          style: context.typo.display.small.copyWith(
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.03,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 10.h),
          Text(
            subtitle!,
            style: context.typo.body.medium.copyWith(
              color: mutedColor,
              height: 1.45,
            ),
          ),
        ],
      ],
    );
  }
}

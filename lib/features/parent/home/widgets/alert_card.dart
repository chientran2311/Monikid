import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.title,
    required this.description,
    required this.isDark,
    this.onTap,
  });

  final String title;
  final String description;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.surfaceDark
              : Colors.white.withValues(alpha: 0.84),
          border: Border.all(
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.amberFill.withValues(alpha: 0.2)
                    : AppTheme.warningSurface,
                border: Border.all(
                  color: isDark
                      ? AppTheme.amberText.withValues(alpha: 0.3)
                      : AppTheme.amberText.withValues(alpha: 0.18),
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.info_outline_rounded,
                size: 22.r,
                color: AppTheme.amberText,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.typo.body.medium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      letterSpacing: -0.01 * 14,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    description,
                    style: context.typo.caption.big.copyWith(
                      color: mutedColor,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.chevron_right_rounded,
                size: 20.r,
                color: mutedColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.isDark,
    this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: 72.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.surfaceDark.withValues(alpha: 0.84)
              : Colors.white.withValues(alpha: 0.84),
          border: Border.all(color: AppTheme.primary.withValues(alpha: 0.16)),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.07),
              blurRadius: 28.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Color.lerp(Colors.white, AppTheme.primary, 0.10),
                border: Border.all(
                  color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
                ),
              ),
              child: Center(
                child: Text(emoji, style: TextStyle(fontSize: 18.sp)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.typo.button.small.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typo.label.small.copyWith(
                      color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

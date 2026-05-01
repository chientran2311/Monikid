import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class HomeAlertCard extends StatelessWidget {
  const HomeAlertCard({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: isDark
              ? Border.all(color: AppTheme.borderDark, width: 0.5)
              : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          color: isDark
              ? AppTheme.amberText.withValues(alpha: 0.08)
              : AppTheme.amberSurface.withValues(alpha: 0.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20.r,
                color: AppTheme.amberText,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.homeParAlertWeeklyLimitTitle,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : AppTheme.textBlack,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.homeParAlertWeeklyLimitBody,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

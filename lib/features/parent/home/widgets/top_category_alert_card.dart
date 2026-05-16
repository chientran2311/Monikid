import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class TopCategoryAlertCard extends StatelessWidget {
  const TopCategoryAlertCard({
    super.key,
    required this.isDark,
    required this.topCategory,
    required this.onTap,
  });

  final bool isDark;
  final StatisticCategoryData topCategory;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final amountText = context.formatStatisticCurrency(topCategory.amountMinor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: isDark ? Border.all(color: AppTheme.borderDark, width: 0.5) : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.amberText.withValues(alpha: 0.08)
                : AppTheme.amberSurface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.r),
          ),
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
                      s.homeParTopCategoryAlertTitle(topCategory.categoryLabel),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppTheme.textBlack,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      s.homeParTopCategoryAlertBody,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      amountText,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.amberText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20.r,
                color: isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

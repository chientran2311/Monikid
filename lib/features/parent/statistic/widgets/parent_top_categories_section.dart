import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class ParentTopCategoriesSection extends StatelessWidget {
  const ParentTopCategoriesSection({
    super.key,
    required this.isDark,
    required this.categories,
    this.onItemTap,
  });

  final bool isDark;
  final List<StatisticCategoryData> categories;
  final ValueChanged<StatisticCategoryData>? onItemTap;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Text(
            s.parentStatisticTopCategoriesTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: mutedColor,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        if (categories.isEmpty)
          _EmptyState(isDark: isDark)
        else
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.0 : 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: List.generate(categories.length, (i) {
                final item = categories[i];
                final isLast = i == categories.length - 1;
                return _CategoryRow(
                  item: item,
                  isDark: isDark,
                  showDivider: !isLast,
                  onTap: onItemTap != null ? () => onItemTap!(item) : null,
                );
              }),
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Text(
        s.parentStatisticNoData,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.sp, color: mutedColor),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.item,
    required this.isDark,
    required this.showDivider,
    this.onTap,
  });

  final StatisticCategoryData item;
  final bool isDark;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: _categoryColor(item).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      item.categoryIcon ?? '💸',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.categoryLabel,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        context.l10n.parentStatisticTransactionCount(
                          item.transactionCount,
                        ),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: mutedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  context.formatStatisticCurrency(item.amountMinor),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right_rounded,
                    size: 20.r, color: mutedColor),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, thickness: 0.5, color: borderColor),
      ],
    );
  }

  Color _categoryColor(StatisticCategoryData item) {
    final colors = statisticAllocationColors;
    return colors[item.categoryKey.hashCode.abs() % colors.length];
  }
}

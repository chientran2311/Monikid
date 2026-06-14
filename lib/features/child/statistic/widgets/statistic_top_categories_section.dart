import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

/// Reusable "top categories" card. Renders the highest-ranked categories for a
/// given metric (expense or income); the data semantics are decided entirely by
/// the caller through [title] and [categories], so this widget stays metric-agnostic.
class StatisticTopCategoriesSection extends StatelessWidget {
  const StatisticTopCategoriesSection({
    super.key,
    required this.title,
    required this.categories,
    this.onItemTap,
  });

  /// Maximum number of category rows shown in the card.
  static const int _maxVisibleCategories = 5;

  /// Soft drop shadow color used for the card surface in light mode.
  static const Color _cardShadowColor = Color(0x0D111811);

  final String title;
  final List<StatisticCategoryData> categories;
  final void Function(StatisticCategoryData)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final visibleCategories = categories
        .where((item) => item.amountMinor > 0)
        .take(_maxVisibleCategories)
        .toList(growable: false);
    if (visibleCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
        boxShadow: const [
          BoxShadow(
            color: _cardShadowColor,
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 14.h),
          ...List.generate(visibleCategories.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < visibleCategories.length - 1 ? 12.h : 0,
              ),
              child: _TrendItem(
                category: visibleCategories[index],
                onTap: onItemTap != null
                    ? () => onItemTap!(visibleCategories[index])
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TrendItem extends StatelessWidget {
  const _TrendItem({
    required this.category,
    this.onTap,
  });

  final StatisticCategoryData category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sharePercent = (category.shareRatio * 100).toStringAsFixed(0);

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46.w,
          height: 46.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.surfaceLightGreen,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            category.categoryIcon ?? '•',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.categoryLabel,
                style: context.typo.body.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                context.l10n.statisticTransactionCount(
                  category.transactionCount,
                ),
                style: context.typo.caption.medium.copyWith(
                  color: AppTheme.textGrey,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              context.formatStatisticCurrency(category.amountMinor),
              style: context.typo.body.medium.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              '$sharePercent%',
              style: context.typo.caption.medium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
        if (onTap != null) ...[
          SizedBox(width: 4.w),
          Icon(
            Icons.chevron_right_rounded,
            size: 18.r,
            color: AppTheme.textGrey,
          ),
        ],
      ],
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: content,
      ),
    );
  }
}

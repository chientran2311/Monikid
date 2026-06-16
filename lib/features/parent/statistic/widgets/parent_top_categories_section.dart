import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

// HTML: --border token
Color get _borderColor => AppTheme.primary.withValues(alpha: 0.16);

class ParentTopCategoriesSection extends StatelessWidget {
  const ParentTopCategoriesSection({
    super.key,
    required this.isDark,
    required this.title,
    required this.categories,
    this.isExpense = true,
    this.onItemTap,
  });

  final bool isDark;
  final String title;
  final List<StatisticCategoryData> categories;

  /// Expense lists highlight the #1 rank in danger red; income lists in the
  /// app's primary green.
  final bool isExpense;
  final ValueChanged<StatisticCategoryData>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HTML .section-title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.typo.title.medium.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppTheme.textBlack,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        if (categories.isEmpty)
          _EmptyState(isDark: isDark)
        else
          // HTML .trend-list { gap: 10px } — each item is a separate card.
          // Only the #1 category (first item) is highlighted.
          Column(
            children: List.generate(categories.length, (i) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: i < categories.length - 1 ? 10.h : 0,
                ),
                child: _CategoryCard(
                  item: categories[i],
                  isDark: isDark,
                  isTopRank: i == 0,
                  isExpense: isExpense,
                  onTap: onItemTap != null
                      ? () => onItemTap!(categories[i])
                      : null,
                ),
              );
            }),
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
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textBlack.withValues(alpha: 0.45);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: _borderColor),
      ),
      child: Text(
        s.parentStatisticNoData,
        textAlign: TextAlign.center,
        style: context.typo.body.medium.copyWith(color: mutedColor),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.item,
    required this.isDark,
    required this.isTopRank,
    required this.isExpense,
    this.onTap,
  });

  final StatisticCategoryData item;
  final bool isDark;
  final bool isTopRank;
  final bool isExpense;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // HTML .trend-item tokens:
    // bg: rgba(white,.94)  border: mix(accent 16%, white)
    // radius: 24px  padding: 16px
    // shadow: 0 12px 28px rgba(47,127,51,.06)
    final bgColor =
        isDark ? AppTheme.surfaceDark : Colors.white.withValues(alpha: 0.94);
    final borderColor =
        isDark ? AppTheme.borderDark : _borderColor;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark
        ? AppTheme.textMuted
        : AppTheme.textBlack.withValues(alpha: 0.45);
    // #1 rank highlight: expense → danger red, income → primary green.
    final topRankColor = isExpense ? AppTheme.redAlert : AppTheme.primary;
    final effectiveBorderColor = isTopRank ? topRankColor : borderColor;
    final borderWidth = isTopRank ? 1.5 : 1.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: effectiveBorderColor, width: borderWidth),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: isDark ? 0.0 : 0.06),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            // HTML .trend-icon { width:40, height:40, border-radius:14px }
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: _categoryBgColor(item),
                borderRadius: BorderRadius.circular(14.r),
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
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.categoryLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typo.body.medium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: textColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      if (isTopRank) ...[
                        SizedBox(width: 6.w),
                        _TopBadge(isExpense: isExpense),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    context.l10n.parentStatisticTransactionCount(
                      item.transactionCount,
                    ),
                    style: context.typo.caption.small.copyWith(
                      color: mutedColor,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // HTML .trend-amount { font-size:15, weight:900 }
                Text(
                  context.formatStatisticCompactCurrency(item.amountMinor),
                  style: context.typo.body.medium.copyWith(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    fontSize: 15.sp,
                  ),
                ),
                if (_hasComparablePercent(item)) ...[
                  SizedBox(height: 4.h),
                  _TrendPill(item: item, isDark: isDark),
                ],
              ],
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.r,
              color: mutedColor,
            ),
          ],
        ),
      ),
    );
  }

  Color _categoryBgColor(StatisticCategoryData item) {
    // Each category gets a colored icon bg matching HTML's inline styles
    final colors = statisticAllocationColors;
    final base = colors[item.categoryKey.hashCode.abs() % colors.length];
    return base.withValues(alpha: 0.15);
  }

  bool _hasComparablePercent(StatisticCategoryData item) {
    return item.changePercent != null &&
        (item.trendDirection == StatisticTrendDirection.up ||
            item.trendDirection == StatisticTrendDirection.down);
  }
}

class _TrendPill extends StatelessWidget {
  const _TrendPill({required this.item, required this.isDark});

  final StatisticCategoryData item;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final direction = item.trendDirection;
    final color = statisticTrendColor(direction);
    final surface = statisticTrendSurfaceColor(direction, isDark: isDark);
    final isUp = direction == StatisticTrendDirection.up;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
            size: 14.r,
            color: color,
          ),
          Text(
            '${item.changePercent!.toStringAsFixed(0)}%',
            style: context.typo.caption.small.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBadge extends StatelessWidget {
  const _TopBadge({required this.isExpense});

  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    // #1 rank badge — expense: danger red, income: app primary green gradient.
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isExpense ? AppTheme.redAlert : null,
        gradient: isExpense ? null : AppTheme.primaryButtonGradient,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events_rounded,
            size: 11.r,
            color: Colors.white,
          ),
          SizedBox(width: 3.w),
          Text(
            context.l10n.statisticTopBadge,
            style: context.typo.caption.small.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

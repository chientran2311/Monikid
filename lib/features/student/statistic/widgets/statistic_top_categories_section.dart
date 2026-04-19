import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_ui_helpers.dart';

class StatisticTopCategoriesSection extends StatelessWidget {
  const StatisticTopCategoriesSection({
    super.key,
    required this.categories,
    required this.onViewAll,
  });

  final List<StatisticCategoryData> categories;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final visibleCategories = categories
        .where((item) => item.amountMinor > 0)
        .take(3)
        .toList(growable: false);
    if (visibleCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.statisticTopCategoriesTitle,
                style: TextStyle(
                  fontSize: 17.r,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textBlack,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                context.l10n.homeStudentViewAll,
                style: TextStyle(
                  fontSize: 12.r,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ...List.generate(visibleCategories.length, (index) {
          final category = visibleCategories[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _TopCategoryCard(
              category: category,
              backgroundColor: _categorySurface(index),
            ),
          );
        }),
      ],
    );
  }

  Color _categorySurface(int index) {
    switch (index) {
      case 0:
        return AppTheme.amberSurface;
      case 1:
        return AppTheme.infoSurface;
      default:
        return const Color(0xFFF5F3FF);
    }
  }
}

class _TopCategoryCard extends StatelessWidget {
  const _TopCategoryCard({
    required this.category,
    required this.backgroundColor,
  });

  final StatisticCategoryData category;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final badgeColor = statisticTrendColor(category.trendDirection);
    final badgeSurface = statisticTrendSurfaceColor(category.trendDirection);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              category.categoryIcon ?? '•',
              style: TextStyle(fontSize: 22.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.categoryLabel,
                        style: TextStyle(
                          fontSize: 14.r,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textBlack,
                        ),
                      ),
                    ),
                    Text(
                      context.formatStatisticCurrency(category.amountMinor),
                      style: TextStyle(
                        fontSize: 14.r,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.statisticTransactionCount(
                          category.transactionCount,
                        ),
                        style: TextStyle(
                          fontSize: 11.r,
                          color: AppTheme.textGrey,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: badgeSurface,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        context.statisticTrendBadgeLabel(category),
                        style: TextStyle(
                          fontSize: 10.r,
                          fontWeight: FontWeight.w700,
                          color: badgeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

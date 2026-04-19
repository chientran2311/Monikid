import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_ui_helpers.dart';

class StatisticSpendingAllocationSection extends StatelessWidget {
  const StatisticSpendingAllocationSection({
    super.key,
    required this.categories,
    required this.totalExpenseMinor,
  });

  final List<StatisticCategoryData> categories;
  final int totalExpenseMinor;

  @override
  Widget build(BuildContext context) {
    final sourceCategories = categories.where((item) => item.amountMinor > 0).isEmpty
        ? _mockCategories
        : categories;
    final visibleCategories = sourceCategories
        .where((item) => item.amountMinor > 0)
        .take(3)
        .toList(growable: false);
    final effectiveTotalExpenseMinor = totalExpenseMinor > 0
        ? totalExpenseMinor
        : visibleCategories.fold<int>(
            0,
            (total, category) => total + category.amountMinor,
          );
    final gridItems = visibleCategories.length.isOdd
        ? [...visibleCategories, null]
        : visibleCategories.cast<StatisticCategoryData?>();
    if (visibleCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.statisticSpendingAllocationTitle,
          style: TextStyle(
            fontSize: 17.r,
            fontWeight: FontWeight.w800,
            color: AppTheme.textBlack,
          ),
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            Center(
              child: SizedBox(
                width: 220.w,
                height: 220.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        centerSpaceRadius: 58.r,
                        sectionsSpace: 0,
                        startDegreeOffset: -90,
                        sections: List.generate(visibleCategories.length, (index) {
                          final category = visibleCategories[index];
                          return PieChartSectionData(
                            color: statisticAllocationColors[
                                index % statisticAllocationColors.length],
                            value: category.shareRatio * 100,
                            radius: 24.r,
                            showTitle: false,
                          );
                        }),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.statisticTotalSpentShort,
                          style: TextStyle(
                            fontSize: 10.r,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          context.formatStatisticCompactCurrency(
                            effectiveTotalExpenseMinor,
                          ),
                          style: TextStyle(
                            fontSize: 24.r,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: SizedBox(
                width: 220.w,
                child: Column(
                  children: List.generate(
                    (gridItems.length / 2).ceil(),
                    (rowIndex) {
                      final startIndex = rowIndex * 2;

                      return Padding(
                        padding: EdgeInsets.only(bottom: rowIndex == 0 ? 0 : 10.h),
                        child: Row(
                          children: List.generate(2, (columnIndex) {
                            final itemIndex = startIndex + columnIndex;
                            final item =
                                itemIndex < gridItems.length ? gridItems[itemIndex] : null;

                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: item == null
                                    ? const SizedBox.shrink()
                                    : _AllocationLegendItem(
                                        category: item,
                                        color: statisticAllocationColors[
                                            itemIndex % statisticAllocationColors.length],
                                      ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

const List<StatisticCategoryData> _mockCategories = [
  StatisticCategoryData(
    categoryKey: 'food',
    categoryLabel: 'Ăn uống',
    categoryIcon: '🍜',
    amountMinor: 450000,
    transactionCount: 6,
    shareRatio: 0.45,
  ),
  StatisticCategoryData(
    categoryKey: 'study',
    categoryLabel: 'Học tập',
    categoryIcon: '📚',
    amountMinor: 350000,
    transactionCount: 4,
    shareRatio: 0.35,
  ),
  StatisticCategoryData(
    categoryKey: 'fun',
    categoryLabel: 'Giải trí',
    categoryIcon: '🎮',
    amountMinor: 200000,
    transactionCount: 3,
    shareRatio: 0.20,
  ),
];

class _AllocationLegendItem extends StatelessWidget {
  const _AllocationLegendItem({
    required this.category,
    required this.color,
  });

  final StatisticCategoryData category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final percent = (category.shareRatio * 100).toStringAsFixed(0);

    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              '${category.categoryLabel} ($percent%)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.r,
                fontWeight: FontWeight.w600,
                color: AppTheme.textGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

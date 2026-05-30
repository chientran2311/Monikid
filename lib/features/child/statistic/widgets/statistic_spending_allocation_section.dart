import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

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
    final sourceCategories =
        categories.where((item) => item.amountMinor > 0).isEmpty
            ? _mockCategories
            : categories;
    final visibleCategories = sourceCategories
        .where((item) => item.amountMinor > 0)
        .take(5)
        .toList(growable: false);
    final effectiveTotal = totalExpenseMinor > 0
        ? totalExpenseMinor
        : visibleCategories.fold<int>(0, (sum, c) => sum + c.amountMinor);

    if (visibleCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: AppTheme.borderLight),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.statisticSpendingAllocationTitle,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.textBlack,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 168.w,
                height: 168.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        centerSpaceRadius: 44.r,
                        sectionsSpace: 0,
                        startDegreeOffset: -90,
                        sections: List.generate(
                          visibleCategories.length,
                          (index) => PieChartSectionData(
                            color: statisticAllocationColors[
                                index % statisticAllocationColors.length],
                            value: visibleCategories[index].shareRatio * 100,
                            radius: 28.r,
                            showTitle: false,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.statisticTotalSpentShort,
                          style: context.typo.caption.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          context.formatStatisticCompactCurrency(effectiveTotal),
                          style: context.typo.title.medium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textBlack,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(visibleCategories.length, (index) {
                    final category = visibleCategories[index];
                    final color = statisticAllocationColors[
                        index % statisticAllocationColors.length];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom:
                            index < visibleCategories.length - 1 ? 10.h : 0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 11.w,
                            height: 11.w,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              category.categoryLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typo.caption.big.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textBlack,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${(category.shareRatio * 100).toStringAsFixed(0)}%',
                            style: context.typo.caption.big.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
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

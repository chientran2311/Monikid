import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_ui_helpers.dart';

class StatisticSpendingTrendSection extends StatelessWidget {
  const StatisticSpendingTrendSection({
    super.key,
    required this.selectedMonthIndex,
    required this.currentOverview,
    required this.comparisonDirection,
    required this.comparisonPercent,
  });

  final int selectedMonthIndex;
  final StatisticPeriodOverview currentOverview;
  final StatisticTrendDirection comparisonDirection;
  final double? comparisonPercent;

  @override
  Widget build(BuildContext context) {
    final directionColor = statisticTrendColor(comparisonDirection);
    final badgeBackground = statisticTrendSurfaceColor(comparisonDirection);
    final comparisonLabel = switch (comparisonDirection) {
      StatisticTrendDirection.up => context.l10n.statisticHigher,
      StatisticTrendDirection.down => context.l10n.statisticLower,
      StatisticTrendDirection.stable || StatisticTrendDirection.none =>
        context.l10n.statisticStable,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.statisticSpendingTrendTitle,
          style: TextStyle(
            fontSize: 17.r,
            fontWeight: FontWeight.w800,
            color: AppTheme.textBlack,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _TrendMetricCard(
                title: context.l10n.statisticCurrentPeriodTotal(
                  selectedMonthIndex == 0
                      ? context.l10n.statisticWeekNoun
                      : context.l10n.statisticMonthNoun,
                ),
                value: context.formatStatisticCurrency(
                  currentOverview.totalExpenseMinor,
                ),
                dailyExpenses: currentOverview.dailyExpenses,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                height: 144.h,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.statisticComparedToPrevious(
                        selectedMonthIndex == 0
                            ? context.l10n.statisticWeekNoun
                            : context.l10n.statisticMonthNoun,
                      ),
                      style: TextStyle(
                        fontSize: 12.r,
                        color: AppTheme.textGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          comparisonPercent == null
                              ? '--'
                              : '${comparisonDirection == StatisticTrendDirection.down ? '-' : '+'}${comparisonPercent!.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 24.r,
                            fontWeight: FontWeight.w800,
                            color: directionColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: badgeBackground,
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Icon(
                            comparisonDirection == StatisticTrendDirection.down
                                ? Icons.trending_down_rounded
                                : comparisonDirection == StatisticTrendDirection.up
                                    ? Icons.trending_up_rounded
                                    : Icons.remove_rounded,
                            size: 16.r,
                            color: directionColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: badgeBackground,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        comparisonLabel,
                        style: TextStyle(
                          fontSize: 10.r,
                          fontWeight: FontWeight.w700,
                          color: directionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrendMetricCard extends StatelessWidget {
  const _TrendMetricCard({
    required this.title,
    required this.value,
    required this.dailyExpenses,
  });

  final String title;
  final String value;
  final List<StatisticDailyExpenseData> dailyExpenses;

  @override
  Widget build(BuildContext context) {
    final maxAmount = dailyExpenses.fold<int>(
      0,
      (current, point) => point.amountMinor > current ? point.amountMinor : current,
    );

    return Container(
      height: 144.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.r,
              color: AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 21.r,
              fontWeight: FontWeight.w800,
              color: AppTheme.textBlack,
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: dailyExpenses.take(7).map((point) {
              final barHeight = maxAmount <= 0
                  ? 6.h
                  : ((point.amountMinor / maxAmount) * 42.h).clamp(6.h, 42.h);
              final isPeak = point.amountMinor == maxAmount && maxAmount > 0;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: isPeak ? AppTheme.primary : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
                  ),
                ),
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class StatisticSpendingTrendSection extends StatefulWidget {
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
  State<StatisticSpendingTrendSection> createState() =>
      _StatisticSpendingTrendSectionState();
}

class _StatisticSpendingTrendSectionState
    extends State<StatisticSpendingTrendSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void didUpdateWidget(StatisticSpendingTrendSection old) {
    super.didUpdateWidget(old);
    if (old.currentOverview != widget.currentOverview ||
        old.selectedMonthIndex != widget.selectedMonthIndex) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _barAnimation(int index) {
    final start = (0.05 * index).clamp(0.0, 0.5);
    final end = (start + 0.55).clamp(0.0, 1.0);
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyExpenses =
        widget.currentOverview.dailyExpenses.take(7).toList();
    final maxAmount = dailyExpenses.fold<int>(
      0,
      (v, p) => p.amountMinor > v ? p.amountMinor : v,
    );
    final periodLabel = widget.selectedMonthIndex == 2
        ? context.l10n.statisticByYear
        : widget.selectedMonthIndex == 0
            ? context.l10n.statisticByWeek
            : context.l10n.statisticByMonth;

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: AppTheme.borderLight),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.statisticChartSectionTitle,
            style: context.typo.caption.medium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textGrey,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            context.l10n.statisticChartComparisonTitle,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.textBlack,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: dailyExpenses.isEmpty
                ? Center(
                    child: Text(
                      context.l10n.statisticNoPreviousData(periodLabel),
                      style: context.typo.caption.big
                          .copyWith(color: AppTheme.textGrey),
                    ),
                  )
                : _BarChart(
                    dailyExpenses: dailyExpenses,
                    maxAmount: maxAmount,
                    animationOf: _barAnimation,
                    selectedMonthIndex: widget.selectedMonthIndex,
                  ),
          ),
          SizedBox(height: 14.h),
          _PeriodPill(label: periodLabel),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.dailyExpenses,
    required this.maxAmount,
    required this.animationOf,
    required this.selectedMonthIndex,
  });

  final List<StatisticDailyExpenseData> dailyExpenses;
  final int maxAmount;
  final Animation<double> Function(int index) animationOf;
  final int selectedMonthIndex;

  String _dayLabel(StatisticDailyExpenseData point, int index) {
    if (selectedMonthIndex == 0) {
      const weekLabels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
      return weekLabels[index % 7];
    }
    return '${point.date.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(dailyExpenses.length, (i) {
        final point = dailyExpenses[i];
        final isMax = point.amountMinor == maxAmount && maxAmount > 0;
        final isEmpty = point.amountMinor == 0;
        final heightFactor = maxAmount <= 0
            ? 0.03
            : (point.amountMinor / maxAmount).clamp(0.03, 1.0);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  context.formatStatisticCompactCurrency(point.amountMinor),
                  textAlign: TextAlign.center,
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isMax ? AppTheme.primaryDark : AppTheme.textGrey,
                    fontSize: 9.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                AnimatedBuilder(
                  animation: animationOf(i),
                  builder: (context, _) {
                    final factor =
                        (heightFactor * animationOf(i).value).clamp(0.03, 1.0);
                    return SizedBox(
                      height: 120.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: factor,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: isMax
                                    ? [
                                        const Color(0xFF4E9B52),
                                        AppTheme.primaryDark,
                                      ]
                                    : isEmpty
                                        ? [
                                            const Color(0xFFD9E8DA),
                                            const Color(0xFFA7CDA9),
                                          ]
                                        : [
                                            const Color(0xFF5AA05D),
                                            AppTheme.primary,
                                          ],
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8.r),
                                bottom: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 6.h),
                Text(
                  _dayLabel(point, i),
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isMax ? AppTheme.primaryDark : AppTheme.textGrey,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _PeriodPill extends StatelessWidget {
  const _PeriodPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 0, 12.w, 0),
      height: 38.h,
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.typo.caption.big.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryDark,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 12.r,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

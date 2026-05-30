import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/app_popup_menu_button.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';

class ParentSpendingTrendSection extends HookConsumerWidget {
  const ParentSpendingTrendSection({
    super.key,
    required this.isDark,
    required this.period,
    required this.dailyData,
  });

  final bool isDark;
  final ParentStatisticPeriod period;
  final List<StatisticDailyExpenseData> dailyData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    
    // Month selection
    final now = DateTime.now();
    final selectedMonth = useState(now.month);
    final selectedYear = useState(now.year);
    final selectedDay = useState(now.day); // For week selection
    
    final visibleData = _getVisibleDataForMonth(
      selectedYear.value,
      selectedMonth.value,
      selectedDay.value,
    );
    
    // Calculate max amount from visible data to scale chart
    // Left axis will display amounts from 0 to maxAmount * 1.2
    // This ensures amounts are shown from smallest to largest based on selected period
    final maxAmount = visibleData.fold<int>(
      0,
      (current, item) => item.amountMinor > current ? item.amountMinor : current,
    );
    
    final spots = List.generate(
      visibleData.length,
      (index) => FlSpot(index.toDouble(), visibleData[index].amountMinor.toDouble()),
    );

    // Calculate chart width for scrolling
    final dataPoints = visibleData.length;
    final minWidth = MediaQuery.of(context).size.width - 80.w;
    final pointWidth = 40.w;
    // Add extra width for last point label to prevent clipping
    final chartWidth = (dataPoints * pointWidth + 40.w).clamp(minWidth, double.infinity);

    return Container(
      padding: EdgeInsets.all(20.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  s.parentStatisticTrendTitle,
                  style: context.typo.subtitle.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                ),
              ),
              _PeriodSelector(
                isDark: isDark,
                textColor: textColor,
                mutedColor: mutedColor,
                period: period,
                selectedDate: DateTime(selectedYear.value, selectedMonth.value, selectedDay.value),
                onPeriodChanged: (date) {
                  selectedYear.value = date.year;
                  selectedMonth.value = date.month;
                  selectedDay.value = date.day;
                },
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: _getChartHeight(),
            child: visibleData.isEmpty || maxAmount == 0
                ? Center(
                    child: Text(
                      s.parentStatisticNoData,
                      style: context.typo.body.medium.copyWith(
                        color: mutedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: chartWidth,
                      height: _getChartHeight(),
                      child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: spots.isEmpty ? 0 : (spots.length - 1).toDouble() + 1.0,
                    minY: 0,
                    maxY: maxAmount == 0 ? 1 : maxAmount * 1.2,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: maxAmount == 0 ? 1 : maxAmount / 3,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                        strokeWidth: 0.6,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: maxAmount > 0,
                          reservedSize: maxAmount > 0 ? 50.w : 0,
                          interval: maxAmount == 0 ? 1 : maxAmount / 3,
                          getTitlesWidget: (value, meta) {
                            if (maxAmount == 0 || value == meta.max || value == meta.min) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Text(
                                CurrencyFormatter.formatCompact(value.toInt()),
                                textAlign: TextAlign.right,
                                style: context.typo.caption.small.copyWith(
                                color: mutedColor,
                                fontWeight: FontWeight.w400,
                              ),
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: _getBottomTitlesReservedSize(),
                          interval: _getLabelInterval(visibleData),
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= visibleData.length) {
                              return const SizedBox.shrink();
                            }
                            final item = visibleData[index];
                            final isHighlight = item.amountMinor == maxAmount && maxAmount > 0;
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                _labelFor(item.date, locale),
                                style: TextStyle(
                                  fontSize: _getLabelFontSize(),
                                  fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w400,
                                  color: isHighlight ? textColor : mutedColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => isDark
                            ? AppTheme.surfaceVariant
                            : AppTheme.borderDark,
                        tooltipRoundedRadius: 12.r,
                        tooltipPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        tooltipMargin: 12.h,
                        getTooltipItems: (items) => items.map((item) {
                          final index = item.x.toInt();
                          if (index < 0 || index >= visibleData.length) {
                            return null;
                          }
                          final data = visibleData[index];
                          return LineTooltipItem(
                            '${_labelFor(data.date, locale)}\n${CurrencyFormatter.format(item.y.toInt())}',
                            context.typo.caption.big.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          );
                        }).toList(),
                      ),
                      getTouchedSpotIndicator: (barData, spotIndexes) {
                        return spotIndexes.map((index) {
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: AppTheme.primary.withValues(alpha: 0.3),
                              strokeWidth: 2.r,
                            ),
                            FlDotData(
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 5.r,
                                  color: AppTheme.primary,
                                  strokeWidth: 3.r,
                                  strokeColor: surfaceColor,
                                );
                              },
                            ),
                          );
                        }).toList();
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.4,
                        preventCurveOverShooting: true,
                        color: AppTheme.primary,
                        barWidth: 1.5.r,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 3.r,
                              color: AppTheme.primary,
                              strokeWidth: 2.r,
                              strokeColor: surfaceColor,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.primary.withValues(alpha: 0.2),
                              AppTheme.primary.withValues(alpha: 0.05),
                              AppTheme.primary.withValues(alpha: 0.0),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getChartHeight() {
    switch (period) {
      case ParentStatisticPeriod.week:
        return 200.h;
      case ParentStatisticPeriod.month:
        return 210.h;
      case ParentStatisticPeriod.year:
        return 220.h;
    }
  }

  double _getBottomTitlesReservedSize() {
    switch (period) {
      case ParentStatisticPeriod.week:
        return 32.h;
      case ParentStatisticPeriod.month:
        return 38.h;
      case ParentStatisticPeriod.year:
        return 32.h;
    }
  }

  double _getLabelFontSize() {
    switch (period) {
      case ParentStatisticPeriod.week:
        return 10.sp; // Smaller for dd/MM format
      case ParentStatisticPeriod.month:
        return 9.sp;
      case ParentStatisticPeriod.year:
        return 10.sp;
    }
  }

  List<StatisticDailyExpenseData> _getVisibleDataForMonth(int year, int month, int day) {
    switch (period) {
      case ParentStatisticPeriod.week:
        // Show 7 days for selected week
        final weekStart = DateTime(year, month, day);
        final weekEnd = weekStart.add(const Duration(days: 6));
        return dailyData.where((item) {
          return !item.date.isBefore(weekStart) && !item.date.isAfter(weekEnd);
        }).toList();
      case ParentStatisticPeriod.month:
        // Filter data for selected month
        return dailyData.where((item) {
          return item.date.year == year && item.date.month == month;
        }).toList();
      case ParentStatisticPeriod.year:
        // Aggregate daily data into 12 monthly data points
        return _aggregateByMonth(year);
    }
  }

  List<StatisticDailyExpenseData> _aggregateByMonth(int year) {
    final monthlyData = <StatisticDailyExpenseData>[];
    
    // Always show all 12 months
    for (int month = 1; month <= 12; month++) {
      final monthDate = DateTime(year, month, 1);
      
      // Sum all daily expenses for this month
      // If no data, monthTotal will be 0 (point at baseline)
      final monthTotal = dailyData
          .where((item) => item.date.year == year && item.date.month == month)
          .fold<int>(0, (sum, item) => sum + item.amountMinor);
      
      // Add data point for all 12 months (0 if no spending)
      monthlyData.add(
        StatisticDailyExpenseData(
          date: monthDate,
          amountMinor: monthTotal,
        ),
      );
    }
    
    return monthlyData;
  }

  double _getLabelInterval(List<StatisticDailyExpenseData> visibleData) {
    final dataPoints = visibleData.length;
    switch (period) {
      case ParentStatisticPeriod.week:
        return 1.0; // Show all days for week view
      case ParentStatisticPeriod.month:
        // Show every 3-5 days depending on data points
        if (dataPoints <= 15) {
          return 3.0;
        } else if (dataPoints <= 20) {
          return 4.0;
        } else {
          return 5.0;
        }
      case ParentStatisticPeriod.year:
        // Always show 12 months, display every 2 or 3 months for readability
        return dataPoints <= 8 ? 2.0 : 3.0;
    }
  }

  String _labelFor(DateTime date, String locale) {
    switch (period) {
      case ParentStatisticPeriod.week:
        // Format: dd/MM (e.g., 01/05, 15/12)
        return DateFormat('dd/MM').format(date);
      case ParentStatisticPeriod.month:
        // Format: dd MMM (e.g., 15 Jan, 20 Feb / 15 Thg 1, 20 Thg 2)
        return '${date.day} ${DateFormat.MMM(locale).format(date)}';
      case ParentStatisticPeriod.year:
        // Format: MMM (e.g., Jan, Feb, Mar / Thg 1, Thg 2, Thg 3)
        return DateFormat.MMM(locale).format(date);
    }
  }
}

/// A dropdown selector for choosing time periods (week, month, or year).
/// Displays the 6 most recent periods from now.
class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector({
    required this.isDark,
    required this.textColor,
    required this.mutedColor,
    required this.period,
    required this.selectedDate,
    required this.onPeriodChanged,
  });

  final bool isDark;
  final Color textColor;
  final Color mutedColor;
  final ParentStatisticPeriod period;
  final DateTime selectedDate;
  final void Function(DateTime) onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final locale = Localizations.localeOf(context).toString();
    
    return AppPopupMenuButton<DateTime>(
      onSelected: onPeriodChanged,
      itemBuilder: (context) {
        final items = <PopupMenuItem<DateTime>>[];
        
        switch (period) {
          case ParentStatisticPeriod.week:
            // Show 6 most recent weeks
            for (int i = 0; i < 6; i++) {
              final weekStart = now.subtract(Duration(days: now.weekday - 1 + (7 * i)));
              items.add(
                PopupMenuItem<DateTime>(
                  value: weekStart,
                  child: Text(_formatWeekLabel(weekStart, locale)),
                ),
              );
            }
          case ParentStatisticPeriod.month:
            // Show 6 most recent months
            for (int i = 0; i < 6; i++) {
              final date = DateTime(now.year, now.month - i);
              items.add(
                PopupMenuItem<DateTime>(
                  value: date,
                  child: Text(DateFormat.yMMMM(locale).format(date)),
                ),
              );
            }
          case ParentStatisticPeriod.year:
            // Show 6 most recent years
            for (int i = 0; i < 6; i++) {
              final date = DateTime(now.year - i);
              items.add(
                PopupMenuItem<DateTime>(
                  value: date,
                  child: Text(DateFormat.y().format(date)),
                ),
              );
            }
        }
        
        return items;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _formatSelectedLabel(context),
              style: context.typo.caption.big.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 18.r,
              color: mutedColor,
            ),
          ],
        ),
      ),
    );
  }

  String _formatSelectedLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    switch (period) {
      case ParentStatisticPeriod.week:
        return _formatWeekLabel(selectedDate, locale);
      case ParentStatisticPeriod.month:
        return DateFormat.MMM(locale).format(selectedDate);
      case ParentStatisticPeriod.year:
        return DateFormat.y(locale).format(selectedDate);
    }
  }

  String _formatWeekLabel(DateTime weekStart, String locale) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    if (weekStart.month == weekEnd.month) {
      // Same month: "1-7 Jan" / "1-7 Thg 1"
      return '${weekStart.day}-${weekEnd.day} ${DateFormat.MMM(locale).format(weekStart)}';
    } else {
      // Different months: "25 Jan - 2 Feb" / "25 Thg 1 - 2 Thg 2"
      return '${weekStart.day} ${DateFormat.MMM(locale).format(weekStart)} - ${weekEnd.day} ${DateFormat.MMM(locale).format(weekEnd)}';
    }
  }
}

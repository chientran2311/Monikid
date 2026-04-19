import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';

extension StatisticBuildContextX on BuildContext {
  String formatStatisticCurrency(int amountMinor) {
    return NumberFormat.currency(
      locale: Localizations.localeOf(this).languageCode,
      symbol: 'đ',
      decimalDigits: 0,
    ).format(amountMinor);
  }

  String formatStatisticCompactCurrency(int amountMinor) {
    if (amountMinor >= 1000000) {
      final value = amountMinor / 1000000;
      final text = value >= 10 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
      return '${text}Mđ';
    }
    if (amountMinor >= 1000) {
      return '${(amountMinor / 1000).round()}kđ';
    }
    return '$amountMinorđ';
  }

  String statisticPeriodNoun(int selectedMonthIndex) {
    return selectedMonthIndex == 0 ? l10n.statisticThisWeek : l10n.statisticThisMonth;
  }

  String statisticRelativePeriodNoun(int selectedMonthIndex) {
    return selectedMonthIndex == 0 ? 'tuần' : 'tháng';
  }

  String statisticPeriodLabel({
    required int selectedMonthIndex,
    required DateTime anchorDate,
  }) {
    if (selectedMonthIndex == 0) {
      final start = _weekStart(anchorDate);
      final nowStart = _weekStart(DateTime.now());
      if (_isSameDay(start, nowStart)) {
        return l10n.statisticThisWeek;
      }
      if (_isSameDay(start, nowStart.subtract(const Duration(days: 7)))) {
        return l10n.statisticLastWeek;
      }

      final end = start.add(const Duration(days: 6));
      return '${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')} - '
          '${end.day.toString().padLeft(2, '0')}/${end.month.toString().padLeft(2, '0')}';
    }

    final now = DateTime.now();
    if (anchorDate.year == now.year && anchorDate.month == now.month) {
      return l10n.statisticThisMonth;
    }
    final previousMonth = DateTime(now.year, now.month - 1, 1);
    if (anchorDate.year == previousMonth.year &&
        anchorDate.month == previousMonth.month) {
      return l10n.statisticLastMonth;
    }
    return DateFormat('MM/yyyy').format(anchorDate);
  }

  String statisticInsightMessage({
    required StatisticInsightData? insight,
    required int selectedMonthIndex,
  }) {
    if (insight == null) {
      return l10n.statisticSmartInsightFallback;
    }

    return l10n.statisticSmartInsightMessage(
      selectedMonthIndex == 0 ? l10n.statisticWeekNoun : l10n.statisticMonthNoun,
      insight.changePercent.toStringAsFixed(0),
      insight.categoryLabel,
    );
  }

  String statisticComparisonMessage({
    required StatisticBudgetOverview? budgetOverview,
    required int selectedMonthIndex,
  }) {
    if (budgetOverview == null) {
      return l10n.statisticNoPreviousData(
        selectedMonthIndex == 0 ? l10n.statisticWeekNoun : l10n.statisticMonthNoun,
      );
    }

    final periodLabel =
        selectedMonthIndex == 0 ? l10n.statisticWeekNoun : l10n.statisticMonthNoun;
    final percent = budgetOverview.comparisonPercent?.toStringAsFixed(0);
    if (percent == null) {
      return l10n.statisticNoPreviousData(periodLabel);
    }

    switch (budgetOverview.comparisonDirection) {
      case StatisticTrendDirection.down:
        return l10n.statisticSavedComparedToPrevious(percent, periodLabel);
      case StatisticTrendDirection.up:
        return l10n.statisticSpentComparedToPrevious(percent, periodLabel);
      case StatisticTrendDirection.stable:
        return l10n.statisticStable;
      case StatisticTrendDirection.none:
        return l10n.statisticNoPreviousData(periodLabel);
    }
  }

  String statisticBudgetStatusLabel(StatisticBudgetStatus status) {
    switch (status) {
      case StatisticBudgetStatus.onTrack:
        return l10n.statisticBudgetOnTrack;
      case StatisticBudgetStatus.warning:
        return l10n.statisticBudgetWarning;
      case StatisticBudgetStatus.exceeded:
        return l10n.statisticBudgetExceeded;
      case StatisticBudgetStatus.noLimit:
        return l10n.homeStudentMonthlyLimitNotSet;
    }
  }

  String statisticTrendBadgeLabel(StatisticCategoryData category) {
    switch (category.trendDirection) {
      case StatisticTrendDirection.up:
        return l10n.statisticTrendIncrease;
      case StatisticTrendDirection.down:
        return l10n.statisticTrendDecrease;
      case StatisticTrendDirection.stable:
        return l10n.statisticTrendStable;
      case StatisticTrendDirection.none:
        return l10n.statisticTrendStable;
    }
  }
}

Color statisticTrendColor(StatisticTrendDirection direction) {
  switch (direction) {
    case StatisticTrendDirection.up:
      return AppTheme.redAlert;
    case StatisticTrendDirection.down:
      return AppTheme.chartGreen;
    case StatisticTrendDirection.stable:
      return AppTheme.chartBlue;
    case StatisticTrendDirection.none:
      return AppTheme.textGrey;
  }
}

Color statisticTrendSurfaceColor(StatisticTrendDirection direction) {
  switch (direction) {
    case StatisticTrendDirection.up:
      return AppTheme.dangerSurface;
    case StatisticTrendDirection.down:
      return AppTheme.successSurface;
    case StatisticTrendDirection.stable:
      return AppTheme.infoSurface;
    case StatisticTrendDirection.none:
      return AppTheme.surfaceLight;
  }
}

List<Color> statisticAllocationColors = const [
  AppTheme.chartOrange,
  AppTheme.chartPurple,
  AppTheme.chartBlue,
  AppTheme.chartGreen,
];

DateTime _weekStart(DateTime date) {
  final normalized = DateTime(date.year, date.month, date.day);
  return normalized.subtract(Duration(days: normalized.weekday - 1));
}

bool _isSameDay(DateTime left, DateTime right) {
  return left.year == right.year &&
      left.month == right.month &&
      left.day == right.day;
}

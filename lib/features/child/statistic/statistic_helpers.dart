import 'package:monikid/features/child/statistic/statistic_models.dart';

/// Pure utility functions for statistic calculations.
/// Extracted from statistic_provider.dart to reduce file size.
class StatisticHelpers {
  StatisticHelpers._();

  /// Builds budget overview with limit, spending, and comparison data.
  static StatisticBudgetOverview buildBudgetOverview({
    required int? limitMinor,
    required int currentTotalExpenseMinor,
    required int previousTotalExpenseMinor,
  }) {
    if (limitMinor == null || limitMinor <= 0) {
      return StatisticBudgetOverview(
        spentMinor: currentTotalExpenseMinor,
        comparisonDirection: calculateComparisonDirection(
          currentTotalExpenseMinor,
          previousTotalExpenseMinor,
        ),
        comparisonPercent: calculateComparisonPercent(
          currentTotalExpenseMinor,
          previousTotalExpenseMinor,
        ),
      );
    }

    final remainingMinor = limitMinor - currentTotalExpenseMinor;
    final usageRatio = currentTotalExpenseMinor <= 0
        ? 0.0
        : currentTotalExpenseMinor / limitMinor;

    return StatisticBudgetOverview(
      limitMinor: limitMinor,
      spentMinor: currentTotalExpenseMinor,
      remainingMinor: remainingMinor,
      usageRatio: usageRatio.clamp(0.0, 1.0),
      status: calculateBudgetStatus(usageRatio, remainingMinor),
      comparisonDirection: calculateComparisonDirection(
        currentTotalExpenseMinor,
        previousTotalExpenseMinor,
      ),
      comparisonPercent: calculateComparisonPercent(
        currentTotalExpenseMinor,
        previousTotalExpenseMinor,
      ),
    );
  }

  /// Determines budget status based on usage ratio and remaining amount.
  static StatisticBudgetStatus calculateBudgetStatus(
    double usageRatio,
    int remainingMinor,
  ) {
    if (remainingMinor < 0) {
      return StatisticBudgetStatus.exceeded;
    }
    if (usageRatio >= 0.8) {
      return StatisticBudgetStatus.warning;
    }
    return StatisticBudgetStatus.onTrack;
  }

  /// Calculates trend direction by comparing current and previous period.
  static StatisticTrendDirection calculateComparisonDirection(
    int currentTotalExpenseMinor,
    int previousTotalExpenseMinor,
  ) {
    if (currentTotalExpenseMinor > previousTotalExpenseMinor) {
      return StatisticTrendDirection.up;
    }
    if (currentTotalExpenseMinor < previousTotalExpenseMinor) {
      return StatisticTrendDirection.down;
    }
    if (currentTotalExpenseMinor == 0 && previousTotalExpenseMinor == 0) {
      return StatisticTrendDirection.none;
    }
    return StatisticTrendDirection.stable;
  }

  /// Calculates percentage change between current and previous period.
  /// Returns null if both periods are zero.
  static double? calculateComparisonPercent(
    int currentTotalExpenseMinor,
    int previousTotalExpenseMinor,
  ) {
    if (previousTotalExpenseMinor <= 0) {
      if (currentTotalExpenseMinor <= 0) {
        return null;
      }
      return 100.0;
    }

    final difference =
        (currentTotalExpenseMinor - previousTotalExpenseMinor).abs();
    return (difference / previousTotalExpenseMinor) * 100;
  }

  /// Converts minor unit (cents) to double representation.
  static double minorToDouble(int amountMinor) {
    return amountMinor.toDouble();
  }
}

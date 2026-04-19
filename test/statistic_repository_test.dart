import 'package:flutter_test/flutter_test.dart';
import 'package:monikid/features/student/statistic/statistic_models.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/statistic/statistic_repository.dart';

void main() {
  group('StatisticRepository helpers', () {
    test('statisticGetPeriodRange returns Monday to Sunday for week mode', () {
      final range = statisticGetPeriodRange(
        selectedMonthIndex: 0,
        anchorDate: DateTime(2026, 4, 16),
      );

      expect(range.start, DateTime(2026, 4, 13));
      expect(range.end, DateTime(2026, 4, 19, 23, 59, 59, 999));
    });

    test('statisticGetPreviousPeriodRange returns previous month', () {
      final range = statisticGetPreviousPeriodRange(
        selectedMonthIndex: 1,
        anchorDate: DateTime(2026, 4, 16),
      );

      expect(range.start, DateTime(2026, 3, 1));
      expect(range.end, DateTime(2026, 3, 31, 23, 59, 59, 999));
    });

    test('buildStatisticPeriodOverview falls back to transaction totals', () {
      final overview = buildStatisticPeriodOverview(
        range: StatisticDateRange(
          start: DateTime(2026, 4, 1),
          end: DateTime(2026, 4, 30, 23, 59, 59, 999),
        ),
        transactions: [
          _expenseTransaction(
            id: 'tx-1',
            amountMinor: 120000,
            categoryKey: 'food',
            categoryLabel: 'Food',
            date: DateTime(2026, 4, 1, 12),
          ),
          _expenseTransaction(
            id: 'tx-2',
            amountMinor: 80000,
            categoryKey: 'travel',
            categoryLabel: 'Travel',
            date: DateTime(2026, 4, 2, 12),
          ),
        ],
        previousTransactions: const [],
      );

      expect(overview.totalExpenseMinor, 200000);
      expect(overview.transactionCount, 2);
      expect(overview.categories.first.categoryKey, 'food');
      expect(overview.dailyExpenses.where((point) => point.amountMinor > 0), hasLength(2));
    });

    test('buildStatisticPeriodOverview uses summary totals and computes trends', () {
      final overview = buildStatisticPeriodOverview(
        range: StatisticDateRange(
          start: DateTime(2026, 4, 1),
          end: DateTime(2026, 4, 30, 23, 59, 59, 999),
        ),
        transactions: [
          _expenseTransaction(
            id: 'tx-1',
            amountMinor: 200000,
            categoryKey: 'food',
            categoryLabel: 'Food',
            date: DateTime(2026, 4, 1, 12),
          ),
          _expenseTransaction(
            id: 'tx-2',
            amountMinor: 100000,
            categoryKey: 'travel',
            categoryLabel: 'Travel',
            date: DateTime(2026, 4, 2, 12),
          ),
        ],
        previousTransactions: [
          _expenseTransaction(
            id: 'tx-0',
            amountMinor: 100000,
            categoryKey: 'food',
            categoryLabel: 'Food',
            date: DateTime(2026, 3, 20, 12),
          ),
          _expenseTransaction(
            id: 'tx-prev-2',
            amountMinor: 150000,
            categoryKey: 'game',
            categoryLabel: 'Game',
            date: DateTime(2026, 3, 21, 12),
          ),
        ],
        summaryData: const {
          'total_expense_minor': 450000,
          'daily_expense_minor': {
            '2026-04-01': 200000,
            '2026-04-02': 250000,
          },
        },
      );

      expect(overview.totalExpenseMinor, 450000);
      expect(overview.smartInsight?.categoryKey, 'food');
      expect(overview.strongestIncrease?.direction, StatisticTrendDirection.up);
      expect(overview.strongestDecrease?.categoryKey, 'game');
      expect(
        overview.dailyExpenses
            .where((point) => point.date.month == 4 && point.amountMinor > 0),
        hasLength(2),
      );
    });
  });
}

TransactionModel _expenseTransaction({
  required String id,
  required int amountMinor,
  required String categoryKey,
  required String categoryLabel,
  required DateTime date,
}) {
  return TransactionModel(
    transactionId: id,
    userId: 'user-1',
    amountMinor: amountMinor,
    type: 'expense',
    categoryKey: categoryKey,
    categoryLabel: categoryLabel,
    dateTs: date,
  );
}

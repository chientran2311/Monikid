import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/summary_card.dart';
import 'package:monikid/shared/widgets/switchtab_three_item.dart';

class SummaryAndTabsSection extends ConsumerWidget {
  const SummaryAndTabsSection({
    required this.summaryAsyncValue,
    required this.selectedDate,
    required this.typeFilter,
    required this.notifier,
    required this.isDark,
    this.monthlyLimitMinor,
    this.monthlyTotalExpense,
    this.showMonthlyLimit = true,
    super.key,
  });

  final AsyncValue<({double totalExpense, double totalIncome})> summaryAsyncValue;
  final DateTime? selectedDate;
  final String? typeFilter;
  final TransactionHistory notifier;
  final bool isDark;
  final int? monthlyLimitMinor;
  final double? monthlyTotalExpense;
  final bool showMonthlyLimit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map filter string to index for SwitchTabThreeItem
    final filterValues = ['all', 'income', 'expense'];
    final selectedIndex = filterValues.indexOf(typeFilter ?? 'all').clamp(0, 2);

    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: summaryAsyncValue.when(
              skipLoadingOnReload: true,
              skipLoadingOnRefresh: true,
              loading: () {
                if (summaryAsyncValue.hasValue) {
                  return SummaryCard(
                    totalIncome: summaryAsyncValue.value!.totalIncome,
                    totalExpense: summaryAsyncValue.value!.totalExpense,
                    selectedDate: selectedDate,
                    displayMonth: selectedDate ?? DateTime.now(),
                    monthlyLimitMinor: monthlyLimitMinor,
                    monthlyTotalExpense: monthlyTotalExpense,
                    showMonthlyLimit: showMonthlyLimit,
                  );
                }
                return SummaryCard(
                  totalIncome: 0,
                  totalExpense: 0,
                  selectedDate: selectedDate,
                  displayMonth: selectedDate ?? DateTime.now(),
                  monthlyLimitMinor: monthlyLimitMinor,
                  monthlyTotalExpense: monthlyTotalExpense,
                  showMonthlyLimit: showMonthlyLimit,
                );
              },
              error: (error, StackTrace? stack) {
                logger.e(
                  'Failed to load the transaction history summary card.',
                  error: error,
                  stackTrace: stack,
                );
                return SummaryCard(
                  totalIncome: 0,
                  totalExpense: 0,
                  selectedDate: selectedDate,
                  displayMonth: selectedDate ?? DateTime.now(),
                  monthlyLimitMinor: monthlyLimitMinor,
                  monthlyTotalExpense: monthlyTotalExpense,
                  showMonthlyLimit: showMonthlyLimit,
                );
              },
              data: (summary) => SummaryCard(
                totalIncome: summary.totalIncome,
                totalExpense: summary.totalExpense,
                selectedDate: selectedDate,
                displayMonth: selectedDate ?? DateTime.now(),
                monthlyLimitMinor: monthlyLimitMinor,
                monthlyTotalExpense: monthlyTotalExpense,
                showMonthlyLimit: showMonthlyLimit,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SwitchTabThreeItem(
              title1: 'Tất cả',
              title2: 'Thu tiền',
              title3: 'Chi tiền',
              selectedIndex: selectedIndex,
              onChanged: (index) => notifier.setTypeFilter(filterValues[index]),
            ),
          ),
        ],
      ),
    );
  }
}

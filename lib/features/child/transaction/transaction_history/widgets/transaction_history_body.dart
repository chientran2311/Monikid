import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/transaction_history/providers/transaction_summary_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_skeleton.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/grouped_transaction_list.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/summary_and_tabs_section.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class TransactionHistoryBody extends ConsumerWidget {
  const TransactionHistoryBody({
    super.key,
    required this.scrollController,
    required this.isDark,
  });

  final ScrollController scrollController;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(transactionHistoryProvider.notifier);

    final transactions = ref.watch(
      transactionHistoryProvider.select((v) => v.transactions),
    );
    final isLoading = ref.watch(
      transactionHistoryProvider.select((v) => v.isLoading),
    );
    final isListLoading = ref.watch(
      transactionHistoryProvider.select((v) => v.isListLoading),
    );
    final isLoadingMore = ref.watch(
      transactionHistoryProvider.select((v) => v.isLoadingMore),
    );
    final errorMessage = ref.watch(
      transactionHistoryProvider.select((v) => v.errorMessage),
    );
    final selectedDate = ref.watch(
      transactionHistoryProvider.select((v) => v.selectedDate),
    );
    final transactionTypeFilter = ref.watch(
      transactionHistoryProvider.select((v) => v.transactionTypeFilter),
    );
    final selectedCategoryKey = ref.watch(
      transactionHistoryProvider.select((v) => v.selectedCategoryKey),
    );
    final hasMore = ref.watch(
      transactionHistoryProvider.select((v) => v.hasMore),
    );

    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final summaryAsyncValue = ref.watch(
      streamSummaryCardProvider(
        date: selectedDate,
        month: selectedDate == null ? currentMonth : null,
        categoryKey: selectedCategoryKey,
        type: transactionTypeFilter == 'all' ? null : transactionTypeFilter,
      ),
    );

    if (isLoading) {
      return Expanded(child: TransactionHistorySkeleton(isDark: isDark));
    }

    if (errorMessage != null) {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: notifier.refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppTheme.redAlert,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? AppTheme.textWhite.withValues(alpha: 0.7)
                              : AppTheme.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (transactions.isEmpty && !isListLoading) {
      return Expanded(
        child: RefreshIndicator(
          color: AppTheme.primary,
          onRefresh: notifier.refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SummaryAndTabsSection(
                summaryAsyncValue: summaryAsyncValue,
                selectedDate: selectedDate,
                typeFilter: transactionTypeFilter,
                notifier: notifier,
                isDark: isDark,
              ),
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long,
                        size: 56,
                        color: isDark ? Colors.white24 : Colors.black12,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Không có giao dịch nào.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppTheme.textWhite.withValues(alpha: 0.54)
                              : AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Map<String, List<TransactionModel>> sortAndGroup(List<TransactionModel> txs) {
      final map = <String, List<TransactionModel>>{};
      for (final tx in txs) {
        final key = DateFormat('dd/MM/yyyy').format(tx.date);
        (map[key] ??= []).add(tx);
      }
      return map;
    }

    return Expanded(
      child: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: notifier.refresh,
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SummaryAndTabsSection(
              summaryAsyncValue: summaryAsyncValue,
              selectedDate: selectedDate,
              typeFilter: transactionTypeFilter,
              notifier: notifier,
              isDark: isDark,
            ),
            if (isListLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: List.generate(
                      4,
                      (_) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: TransactionItemSkeleton(isDark: isDark),
                      ),
                    ),
                  ),
                ),
              )
            else
              GroupedTransactionList(
                grouped: sortAndGroup(transactions),
                isDark: isDark,
                onTap: (tx) {
                  notifier.selectTransaction(tx);
                  context.push(AppRoutes.detailTransactionPath(tx.transactionId));
                },
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: isLoadingMore
                    ? Column(
                        children: List.generate(
                          2,
                          (_) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: TransactionItemSkeleton(isDark: isDark),
                          ),
                        ),
                      )
                    : (!hasMore && transactions.isNotEmpty)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Đã hiển thị tất cả giao dịch',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white38 : Colors.black26,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

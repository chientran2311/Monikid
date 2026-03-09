import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_skeleton.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'widgets/calendar_dialog.dart';
import 'widgets/category_dialog.dart';
import 'widgets/summary_card.dart';
import 'widgets/summary_card_skeleton.dart';
import 'widgets/type_filter_tab.dart';
import 'widgets/grouped_transaction_list.dart';
import 'package:monikid/features/student/transaction/providers/category_provider.dart';
import 'package:logger/logger.dart';

// =============================================================================
// SCREEN
// =============================================================================

class TransactionHistoryScreen extends HookConsumerWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    final scrollCtrl = useScrollController();

    // Initialize data on mount
    useEffect(() {
      Future.microtask(() {
        ref.read(transactionHistoryProvider.notifier).init();
      });
      return null;
    }, const []);

    // Explicitly watch pagination flags
    final isLoadingMore = ref.watch(
      transactionHistoryProvider.select((v) => v.isLoadingMore),
    );
    final hasMore = ref.watch(
      transactionHistoryProvider.select((v) => v.hasMore),
    );

    // Trigger loadMore when near bottom of scroll
    useEffect(() {
      void onScroll() {
        if (!scrollCtrl.hasClients) return;
        final position = scrollCtrl.position;
        if (position.pixels >= position.maxScrollExtent - 120 &&
            !isLoadingMore &&
            hasMore) {
          ref.read(transactionHistoryProvider.notifier).loadMore();
        }
      }

      scrollCtrl.addListener(onScroll);
      return () => scrollCtrl.removeListener(onScroll);
    }, [scrollCtrl, isLoadingMore, hasMore]);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppTheme.surfaceDark.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Lịch sử Giao dịch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _filterBar(context, ref, isDark),
            _bodyWidget(context, ref, scrollCtrl, isDark),
          ],
        ),
      ),
    );
  }

  Widget _filterBar(BuildContext context, WidgetRef ref, bool isDark) {
    final notifier = ref.read(transactionHistoryProvider.notifier);
    
    // Watch select parts
    final selectedDate = ref.watch(
      transactionHistoryProvider.select((v) => v.selectedDate),
    );
    final selectedCategory = ref.watch(
      transactionHistoryProvider.select((v) => v.selectedCategory),
    );

    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month picker chip
              GestureDetector(
                onTap: () => _showMonthPicker(context, selectedDate, notifier),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.primary.withOpacity(0.2) : const Color(0xFFeaf2eb),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        selectedDate == null
                            ? 'Chọn ngày'
                            : DateFormat('dd/MM/yyyy').format(selectedDate),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
                        ),
                      ),
                      if (selectedDate != null) ...[
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => notifier.getTransByDate(null),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
                          ),
                        ),
                      ] else ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.expand_more,
                          size: 18,
                          color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Filter icon (category)
              GestureDetector(
                onTap: () => _showCategoryDialog(context, selectedCategory, notifier, isDark),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedCategory != null
                        ? AppTheme.primary.withOpacity(0.15)
                        : isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: selectedCategory != null
                        ? Border.all(color: AppTheme.primary.withOpacity(0.4))
                        : null,
                  ),
                  child: Icon(
                    Icons.filter_list,
                    size: 20,
                    color: selectedCategory != null
                        ? AppTheme.primary
                        : isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Active category chip
        if (selectedCategory != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => notifier.getTransByCategory(null),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          categories
                              .firstWhere(
                                (c) => c.label == selectedCategory,
                                orElse: () => const CategoryModel(id: '', label: '', icon: '📦'),
                              )
                              .icon,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          selectedCategory,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.close, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _bodyWidget(
    BuildContext context,
    WidgetRef ref,
    ScrollController scrollController,
    bool isDark,
  ) {
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
    final hasMore = ref.watch(
      transactionHistoryProvider.select((v) => v.hasMore),
    );

    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final summaryAsyncValue = ref.watch(
      streamSummaryCardProvider(
        date: selectedDate,
        month: selectedDate == null ? currentMonth : null,
      ),
    );

    // 1. Full Screen Loading
    if (isLoading) {
      return Expanded(
        child: TransactionHistorySkeleton(isDark: isDark),
      );
    }

    // 2. Error State
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
                      const Icon(Icons.error_outline, size: 48, color: AppTheme.redAlert),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : const Color(0xFF64748B),
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

    // 3. Empty State (No Transactions)
    if (transactions.isEmpty && !isListLoading) {
      return Expanded(
        child: RefreshIndicator(
          color: AppTheme.primary,
          onRefresh: notifier.refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              _buildSummaryAndTabs(
                summaryAsyncValue,
                selectedDate,
                transactionTypeFilter,
                notifier,
                isDark,
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
                          color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
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

    // Helper to group transactions by date
    Map<String, List<TransactionModel>> sortAndGroup(List<TransactionModel> txs) {
      final map = <String, List<TransactionModel>>{};
      for (final tx in txs) {
        final key = DateFormat('dd/MM/yyyy').format(tx.date);
        (map[key] ??= []).add(tx);
      }
      return map;
    }

    // 4. Success State (List Transactions)
    return Expanded(
      child: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: notifier.refresh,
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _buildSummaryAndTabs(
              summaryAsyncValue,
              selectedDate,
              transactionTypeFilter,
              notifier,
              isDark,
            ),
            
            // List Loading (When changing filter but we don't want to hide Summary/Tabs)
            if (isListLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: List.generate(
                      4,
                      (_) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                onTap: (tx) => context.push(AppRoutes.detailTransaction, extra: tx),
              ),

            // Load-more indicator at the bottom
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: isLoadingMore
                    ? Column(
                        children: List.generate(
                          2,
                          (_) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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

  Widget _buildSummaryAndTabs(
    AsyncValue<({double totalExpense, double totalIncome})> summaryAsyncValue,
    DateTime? selectedDate,
    String typeFilter,
    TransactionHistory notifier,
    bool isDark,
  ) {
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
                  );
                }
                return const SummaryCardSkeleton();
              },
              error: (error, StackTrace? stack) {
                final log = Logger();
                log.e('❌ Lỗi load SummaryCard stream: $error', error: error, stackTrace: stack);
                return SummaryCard(
                  totalIncome: 0,
                  totalExpense: 0,
                  selectedDate: selectedDate,
                  displayMonth: selectedDate ?? DateTime.now(),
                );
              },
              data: (summary) => SummaryCard(
                totalIncome: summary.totalIncome,
                totalExpense: summary.totalExpense,
                selectedDate: selectedDate,
                displayMonth: selectedDate ?? DateTime.now(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TypeFilterTab(
              selected: typeFilter,
              isDark: isDark,
              onChanged: notifier.setTypeFilter,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dialog Helpers
  // ---------------------------------------------------------------------------
  void _showMonthPicker(
    BuildContext context,
    DateTime? currentDate,
    TransactionHistory notifier,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CalendarDialog(
        initialMonth: currentDate ?? DateTime.now(),
        // Khi nhấn "Xác nhận": hủy stream, fetch trans theo ngày, reload SummaryCard
        onDateConfirmed: (date) => notifier.getTransByDate(date),
      ),
    );
  }

  void _showCategoryDialog(
    BuildContext context,
    String? currentCategory,
    TransactionHistory notifier,
    bool isDark,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CategoryDialog(
        selectedCategory: currentCategory,
        // Khi chọn category: giữ nguyên filter date + type, fetch lại trans
        onCategorySelected: (category) =>
            notifier.getTransByCategory(category?.label),
      ),
    );
  }
}

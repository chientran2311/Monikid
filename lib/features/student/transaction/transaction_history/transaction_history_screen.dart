import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_skeleton.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_item.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'widgets/calendar_dialog.dart';
import 'widgets/category_dialog.dart';
import 'widgets/summary_card.dart';
import 'package:monikid/features/student/transaction/providers/category_provider.dart';

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

    final txState = ref.watch(transactionHistoryProvider);
    final notifier = ref.read(transactionHistoryProvider.notifier);

    final categories =
        ref.watch(categoryStreamProvider).value ?? defaultCategories;

    // Normalize tháng hiện tại về year+month để key của Riverpod family
    // không thay đổi mỗi khi widget rebuild (DateTime.now() khác nhau từng ms)
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);

    // Lắng nghe StreamProvider streamSummaryCard cho SummaryCard
    final summaryAsyncValue = ref.watch(
      streamSummaryCardProvider(
        date: txState.selectedDate,
        month: txState.selectedDate == null ? currentMonth : null,
      ),
    );

    // Scroll controller for pagination
    final scrollCtrl = useScrollController();

    // Load first page on mount
    useEffect(() {
      Future.microtask(() => notifier.loadFirstPage());
      return null;
    }, const []);

    // Trigger loadMore when near bottom of scroll
    useEffect(() {
      void onScroll() {
        if (scrollCtrl.position.pixels >=
            scrollCtrl.position.maxScrollExtent - 120) {
          notifier.loadMore();
        }
      }

      scrollCtrl.addListener(onScroll);
      return () => scrollCtrl.removeListener(onScroll);
    }, [scrollCtrl]);

    // Server already filters by type

    // Group transactions by date
    Map<String, List<TransactionModel>> grouped(
      List<TransactionModel> transactions,
    ) {
      final map = <String, List<TransactionModel>>{};
      for (final tx in transactions) {
        final key = DateFormat('dd/MM/yyyy').format(tx.date);
        (map[key] ??= []).add(tx);
      }
      return map;
    }

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
      body: RefreshIndicator(
        color: AppTheme.primary,
        onRefresh: notifier.refresh,
        child: txState.isLoading
            ? TransactionHistorySkeleton(isDark: isDark)
            : CustomScrollView(
                controller: scrollCtrl,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // ── FILTER BAR ──────────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Month picker chip
                          GestureDetector(
                            onTap: () => _showMonthPicker(
                              context,
                              txState.selectedDate,
                              notifier,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppTheme.primary.withOpacity(0.2)
                                    : const Color(0xFFeaf2eb),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 20,
                                    color: isDark
                                        ? const Color(0xFFeaf2eb)
                                        : AppTheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    txState.selectedDate == null
                                        ? 'Chọn ngày'
                                        : DateFormat(
                                            'dd/MM/yyyy',
                                          ).format(txState.selectedDate!),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? const Color(0xFFeaf2eb)
                                          : AppTheme.primary,
                                    ),
                                  ),
                                  if (txState.selectedDate != null) ...[
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        notifier.setDate(null);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: isDark
                                            ? const Color(0xFFeaf2eb)
                                            : AppTheme.primary,
                                      ),
                                    ),
                                  ] else ...[
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.expand_more,
                                      size: 18,
                                      color: isDark
                                          ? const Color(0xFFeaf2eb)
                                          : AppTheme.primary,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          // Filter icon (category)
                          GestureDetector(
                            onTap: () => _showCategoryDialog(
                              context,
                              txState.selectedCategory,
                              notifier,
                              isDark,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: txState.selectedCategory != null
                                    ? AppTheme.primary.withOpacity(0.15)
                                    : isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(8),
                                border: txState.selectedCategory != null
                                    ? Border.all(
                                        color: AppTheme.primary.withOpacity(
                                          0.4,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Icon(
                                Icons.filter_list,
                                size: 20,
                                color: txState.selectedCategory != null
                                    ? AppTheme.primary
                                    : isDark
                                    ? const Color(0xFF94A3B8)
                                    : const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Active category chip
                  if (txState.selectedCategory != null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Wrap(
                          children: [
                            GestureDetector(
                              onTap: () => notifier.setCategory(null),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
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
                                            (c) =>
                                                c.label ==
                                                txState.selectedCategory,
                                            orElse: () => const CategoryModel(
                                              id: '',
                                              label: '',
                                              icon: '📦',
                                            ),
                                          )
                                          .icon,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      txState.selectedCategory!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // ── BODY ────────────────────────────────────────────────────
                  if (txState.errorMessage != null)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: AppTheme.redAlert,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              txState.errorMessage!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white70
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (txState.transactions.isEmpty && !txState.isLoading)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 56,
                              color: isDark ? Colors.white24 : Colors.black12,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Không có giao dịch nào\ntrong tháng này.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? Colors.white54
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    // ── Summary card ─────────────────────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: summaryAsyncValue.when(
                          skipLoadingOnReload: true,
                          skipLoadingOnRefresh: true,
                          loading: () {
                            if (summaryAsyncValue.hasValue) {
                              return SummaryCard(
                                totalIncome:
                                    summaryAsyncValue.value!.totalIncome,
                                totalExpense:
                                    summaryAsyncValue.value!.totalExpense,
                                selectedDate: txState.selectedDate,
                                displayMonth:
                                    txState.selectedDate ?? DateTime.now(),
                              );
                            }
                            return const _SummaryCardSkeleton();
                          },
                          error: (_, __) => SummaryCard(
                            totalIncome: 0,
                            totalExpense: 0,
                            selectedDate: txState.selectedDate,
                            displayMonth:
                                txState.selectedDate ?? DateTime.now(),
                          ),
                          data: (summary) => SummaryCard(
                            totalIncome: summary.totalIncome,
                            totalExpense: summary.totalExpense,
                            selectedDate: txState.selectedDate,
                            displayMonth:
                                txState.selectedDate ?? DateTime.now(),
                          ),
                        ),
                      ),
                    ),

                    // ── Transaction type switch tab ───────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: _TypeFilterTab(
                          selected: txState.transactionTypeFilter,
                          isDark: isDark,
                          onChanged: (type) {
                            notifier.setTypeFilter(type);
                          },
                        ),
                      ),
                    ),

                    // Grouped transaction list (filtered client side)
                    if (txState.isListLoading)
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
                      _GroupedTransactionList(
                        grouped: grouped(
                          txState.transactions
                              .where(
                                (tx) =>
                                    tx.type == txState.transactionTypeFilter,
                              )
                              .toList(),
                        ),
                        isDark: isDark,
                        onTap: (tx) => context.push(
                          AppRoutes.detailTransaction,
                          extra: tx,
                        ),
                      ),

                    // Load-more indicator
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: txState.isLoadingMore
                            ? Column(
                                children: List.generate(
                                  3,
                                  (_) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: TransactionItemSkeleton(
                                      isDark: isDark,
                                    ),
                                  ),
                                ),
                              )
                            : !txState.hasMore
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Đã hiển thị tất cả giao dịch',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.black26,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Month picker dialog
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
        onMonthSelected: (date) => notifier.setDate(date),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Category filter dialog
  // ---------------------------------------------------------------------------
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
        onCategorySelected: (category) => notifier.setCategory(category?.label),
      ),
    );
  }
}

class _TypeFilterTab extends StatelessWidget {
  final String selected; // 'income' | 'expense'
  final bool isDark;
  final void Function(String) onChanged;

  const _TypeFilterTab({
    required this.selected,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _tab(context, 'income', 'Thu tiền'),
          _tab(context, 'expense', 'Chi tiền'),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String value, String label) {
    final isActive = selected == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isActive
                ? (value == 'income'
                      ? const Color(0xFF2563EB)
                      : value == 'expense'
                      ? AppTheme.redAlert
                      : AppTheme.primary)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? Colors.white
                  : isDark
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }
}

class _GroupedTransactionList extends StatelessWidget {
  final Map<String, List<TransactionModel>> grouped;
  final bool isDark;
  final void Function(TransactionModel) onTap;

  const _GroupedTransactionList({
    required this.grouped,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateKeys = grouped.keys.toList();

    if (dateKeys.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text(
              'Không có giao dịch nào.',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
              ),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final dateKey = dateKeys[index];
        final dateTxs = grouped[dateKey]!;

        double dailyTotal = 0;
        for (final tx in dateTxs) {
          dailyTotal += tx.type == 'expense' ? -tx.amount : tx.amount;
        }
        final isIncome = dailyTotal >= 0;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateKey.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF94A3B8),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '${isIncome ? '+' : '-'} ${CurrencyFormatter.format(dailyTotal.abs())}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isIncome
                          ? const Color(0xFF2563eb)
                          : AppTheme.redAlert,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...dateTxs.map(
                (tx) =>
                    TransactionItem(transaction: tx, onTap: () => onTap(tx)),
              ),
            ],
          ),
        );
      }, childCount: dateKeys.length),
    );
  }
}

/// Skeleton hiển thị trong lúc provider đang loading
class _SummaryCardSkeleton extends StatelessWidget {
  const _SummaryCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF1e5222)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 180,
            height: 26,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

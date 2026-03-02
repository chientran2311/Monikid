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
import 'widgets/calendar_dialog.dart';
import 'widgets/category_dialog.dart'; // =============================================================================
// CATEGORY MODEL
// =============================================================================

class _Category {
  final String emoji;
  final String label;
  final String value;
  const _Category(this.emoji, this.label, this.value);
}

const _categories = [
  _Category('🍜', 'Ăn uống', 'food'),
  _Category('🚌', 'Di chuyển', 'transport'),
  _Category('📚', 'Học tập', 'education'),
  _Category('🎬', 'Giải trí', 'entertainment'),
  _Category('🛍️', 'Mua sắm', 'shopping'),
  _Category('💊', 'Sức khỏe', 'health'),
  _Category('🏠', 'Sinh hoạt', 'living'),
  _Category('📦', 'Khác', 'other'),
];

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
                                      _categories
                                          .firstWhere(
                                            (c) =>
                                                c.value ==
                                                txState.selectedCategory,
                                            orElse: () => _Category(
                                              '📦',
                                              txState.selectedCategory!,
                                              txState.selectedCategory!,
                                            ),
                                          )
                                          .emoji,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _categories
                                          .firstWhere(
                                            (c) =>
                                                c.value ==
                                                txState.selectedCategory,
                                            orElse: () => _Category(
                                              '',
                                              txState.selectedCategory!,
                                              txState.selectedCategory!,
                                            ),
                                          )
                                          .label,
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
                    // Summary card
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: _SummaryCard(
                          transactions: txState.transactions,
                          selectedDate: txState.selectedDate,
                        ),
                      ),
                    ),

                    // Grouped transaction list
                    _GroupedTransactionList(
                      grouped: grouped(txState.transactions),
                      isDark: isDark,
                      onTap: (tx) =>
                          context.push(AppRoutes.detailTransaction, extra: tx),
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
        onCategorySelected: (category) => notifier.setCategory(category),
      ),
    );
  }
}

// =============================================================================
// PRIVATE WIDGETS
// =============================================================================

class _SummaryCard extends StatelessWidget {
  final List<TransactionModel> transactions;
  final DateTime? selectedDate;
  const _SummaryCard({required this.transactions, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    double totalExpense = 0;
    double totalIncome = 0;
    for (final t in transactions) {
      if (t.type == 'expense') {
        totalExpense += t.amount;
      } else {
        totalIncome += t.amount;
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF1e5222)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate == null
                    ? 'TỔNG CHI TIÊU'
                    : 'TỔNG CHI TIÊU NGÀY ${DateFormat('dd/MM/yyyy').format(selectedDate!)}',
                style: const TextStyle(
                  color: Color(0xFFeaf2eb),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              Icon(
                Icons.pie_chart,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            CurrencyFormatter.format(totalExpense),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _badge(
                Icons.arrow_downward,
                'Chi: ${CurrencyFormatter.formatCompact(totalExpense)}',
              ),
              const SizedBox(width: 16),
              _badge(
                Icons.arrow_upward,
                'Thu: ${CurrencyFormatter.formatCompact(totalIncome)}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
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

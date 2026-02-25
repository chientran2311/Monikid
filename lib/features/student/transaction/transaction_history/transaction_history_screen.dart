import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_item.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/core/utils/currency_formatter.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  DateTime _currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    // Watch the transaction stream
    final transactionAsync = ref.watch(transactionNotifierProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppTheme.surfaceDark.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Lịch sử Giao dịch",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          // Search & Filter Area
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFF8FAFC), // slate-800 / slate-50
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm giao dịch...",
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tháng filter
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
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
                              DateFormat('MM/yyyy').format(_currentMonth),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? const Color(0xFFeaf2eb)
                                    : AppTheme.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.expand_more,
                              size: 18,
                              color: isDark
                                  ? const Color(0xFFeaf2eb)
                                  : AppTheme.primary,
                            ),
                          ],
                        ),
                      ),
                      // Filter & Export Buttons
                      Row(
                        children: [
                          _buildIconButton(Icons.filter_list, isDark),
                          const SizedBox(width: 8),
                          _buildIconButton(Icons.download, isDark),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Stream evaluation
          transactionAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('Chưa có giao dịch nào trong tháng này.'),
                  ),
                );
              }

              // Calculate total income and expense
              double totalExpense = 0;
              double totalIncome = 0;
              for (var t in transactions) {
                if (t.type == 'expense') {
                  totalExpense += t.amount;
                } else {
                  totalIncome += t.amount;
                }
              }

              // Group transactions by Date
              final groupedTxs = _groupTransactionsByDate(transactions);

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) {
                      // Summary Card
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "TỔNG CHI TIÊU THÁNG NÀY",
                                    style: TextStyle(
                                      color: Color(0xFFeaf2eb),
                                      fontSize: 12,
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
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  _buildSummaryBadge(
                                    Icons.arrow_downward,
                                    "Chi: ${CurrencyFormatter.formatCompact(totalExpense)}",
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSummaryBadge(
                                    Icons.arrow_upward,
                                    "Thu: ${CurrencyFormatter.formatCompact(totalIncome)}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // Index 1 is the start of the list
                    final dateKey = groupedTxs.keys.elementAt(index - 1);
                    final dateTxs = groupedTxs[dateKey]!;

                    // Optional: Calculate daily total
                    double dailyTotal = 0;
                    for (var tx in dateTxs) {
                      dailyTotal += (tx.type == 'expense'
                          ? -tx.amount
                          : tx.amount);
                    }

                    final isIncome = dailyTotal >= 0;
                    final absDailyTotal = dailyTotal.abs();

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateHeader(
                            dateKey,
                            "${isIncome ? '+' : '-'} ${CurrencyFormatter.format(absDailyTotal)}",
                            isIncome: isIncome,
                          ),
                          const SizedBox(height: 12),
                          ...dateTxs.map(
                            (tx) => TransactionItem(
                              transaction: tx,
                              onTap: () {
                                context.push(
                                  AppRoutes.detailTransaction,
                                  extra: tx,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: groupedTxs.length + 1, // +1 for the Summary Card
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) =>
                SliverFillRemaining(child: Center(child: Text('Lỗi: $err'))),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ), // Bottom nav bar padding
        ],
      ),
    );
  }

  // Helper method to group transactions by date format "Ngày DD, Tháng MM"
  Map<String, List<TransactionModel>> _groupTransactionsByDate(
    List<TransactionModel> transactions,
  ) {
    var mappedData = <String, List<TransactionModel>>{};
    for (var tx in transactions) {
      final key = DateFormat("dd/MM/yyyy").format(tx.date); // or custom string
      if (mappedData.containsKey(key)) {
        mappedData[key]!.add(tx);
      } else {
        mappedData[key] = [tx];
      }
    }
    return mappedData;
  }

  Widget _buildIconButton(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
      ),
    );
  }

  Widget _buildSummaryBadge(IconData icon, String text) {
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

  Widget _buildDateHeader(
    String dateText,
    String amountText, {
    required bool isIncome,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dateText.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.5,
          ),
        ),
        Text(
          amountText,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isIncome ? const Color(0xFF2563eb) : AppTheme.redAlert,
          ),
        ),
      ],
    );
  }
}

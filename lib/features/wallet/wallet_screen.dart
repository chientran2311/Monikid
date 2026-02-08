import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/models/entities/wallet/transaction.dart';
import 'providers/wallet_provider.dart';
import 'package:monikid/models/entities/wallet/wallet_model.dart';
// --- MÀN HÌNH VÍ (WALLET) ---
class WalletScreen extends ConsumerWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "My Wallet",
          style: TextStyle(color: AppTheme.textWhite, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppTheme.textWhite),
            onPressed: () => ref.read(walletProvider.notifier).refresh(),
          ),
        ],
      ),
      body: walletState.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryGreen),
            )
          : walletState.hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        walletState.errorMessage ?? 'Something went wrong',
                        style: const TextStyle(color: AppTheme.textGrey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(walletProvider.notifier).refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () => ref.read(walletProvider.notifier).refresh(),
                    color: AppTheme.primaryGreen,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. BALANCE CARD (Card tổng)
                          _buildTotalBalanceCard(context, walletState.balance),

                          const SizedBox(height: 24),

                          // 1.5 STATISTICS SUMMARY
                          _buildStatisticsSummary(walletState.wallet),

                          const SizedBox(height: 24),

                          // 2. INCOME & EXPENSE (Tóm tắt thu chi)
                          Row(
                            children: [
                              Expanded(child: _buildSummaryCard(
                                "Income",
                                _formatCurrency(_calculateIncome(walletState.transactions)),
                                Icons.arrow_downward,
                                AppTheme.primaryGreen,
                              )),
                              const SizedBox(width: 16),
                              Expanded(child: _buildSummaryCard(
                                "Expense",
                                _formatCurrency(_calculateExpense(walletState.transactions)),
                                Icons.arrow_upward,
                                AppTheme.redAlert,
                              )),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // 3. ANALYTICS CHART (Biểu đồ chi tiêu tuần)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Weekly Analytics", style: TextStyle(color: AppTheme.textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white10),
                                ),
                                child: const Row(
                                  children: [
                                    Text("This Week", style: TextStyle(color: AppTheme.textGrey, fontSize: 12)),
                                    SizedBox(width: 4),
                                    Icon(Icons.keyboard_arrow_down, color: AppTheme.textGrey, size: 16),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildCustomBarChart(context, walletState.transactions),

                          const SizedBox(height: 32),

                          // 4. RECENT TRANSACTIONS
                          const Text("Transactions", style: TextStyle(color: AppTheme.textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          _buildTransactionList(walletState.transactions),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return formatter.format(amount);
  }

  double _calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.bankDeposit || 
                      t.type == TransactionType.allowance && t.toWalletId != null)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double _calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.bankWithdraw || 
                      t.type == TransactionType.payment ||
                      (t.type == TransactionType.allowance && t.fromWalletId != null))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // --- WIDGET: Total Balance Card ---
  Widget _buildTotalBalanceCard(BuildContext context, double balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          const Text("Total Balance", style: TextStyle(color: AppTheme.textGrey, fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            _formatCurrency(balance), 
            style: const TextStyle(color: AppTheme.textWhite, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Nút hành động chính
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => context.push(AppRoutes.parentTransfer),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text("Transfer Money", style: TextStyle(color: AppTheme.background, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: Summary Income/Expense ---
  Widget _buildSummaryCard(String label, String amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 16),
              ),
              const Spacer(),
              const Icon(Icons.more_vert, color: AppTheme.textGrey, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: AppTheme.textGrey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(amount, style: const TextStyle(color: AppTheme.textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- WIDGET: Custom Bar Chart (Không cần thư viện) ---
  Widget _buildCustomBarChart(BuildContext context, List<Transaction> transactions) {
    // Calculate weekly spending
    final now = DateTime.now();
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    // Group transactions by day of week
    final Map<int, double> dailySpending = {};
    for (final t in transactions) {
      if (t.createdAt != null && 
          t.createdAt!.isAfter(now.subtract(const Duration(days: 7))) &&
          (t.type == TransactionType.payment || t.type == TransactionType.bankWithdraw)) {
        final dayOfWeek = t.createdAt!.weekday;
        dailySpending[dayOfWeek] = (dailySpending[dayOfWeek] ?? 0) + t.amount;
      }
    }

    // Calculate max for normalization
    final maxVal = dailySpending.values.isEmpty ? 1.0 : dailySpending.values.reduce((a, b) => a > b ? a : b);

    final List<Map<String, dynamic>> data = List.generate(7, (i) {
      final dayIndex = i + 1; // 1=Mon, 7=Sun
      final spending = dailySpending[dayIndex] ?? 0;
      final normalizedVal = maxVal > 0 ? spending / maxVal : 0.0;
      return {
        'day': weekDays[i],
        'val': normalizedVal,
        'amount': spending,
      };
    });

    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((e) {
          final isMax = (e['val'] as double) > 0.7;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 140 * (e['val'] as double).clamp(0.05, 1.0),
                width: 12,
                decoration: BoxDecoration(
                  color: isMax ? AppTheme.primaryGreen : AppTheme.surface, 
                  borderRadius: BorderRadius.circular(6),
                  border: !isMax ? Border.all(color: Colors.white24) : null,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                e['day'] as String,
                style: TextStyle(
                  color: isMax ? AppTheme.textWhite : AppTheme.textGrey,
                  fontSize: 12,
                  fontWeight: isMax ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // --- WIDGET: Transaction List from real data ---
  Widget _buildTransactionList(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No transactions yet',
            style: TextStyle(color: AppTheme.textGrey),
          ),
        ),
      );
    }

    // Group by date
    final Map<String, List<Transaction>> grouped = {};
    for (final t in transactions) {
      final date = t.createdAt != null 
          ? _formatDate(t.createdAt!)
          : 'Unknown';
      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(t);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.key, style: const TextStyle(color: AppTheme.textGrey, fontSize: 14)),
            const SizedBox(height: 12),
            ...entry.value.map((t) => _buildTransactionItem(t)),
          ],
        );
      }).toList(),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txDate = DateTime(date.year, date.month, date.day);

    if (txDate == today) return 'Today';
    if (txDate == yesterday) return 'Yesterday';
    return DateFormat('MMM d, yyyy').format(date);
  }

  Widget _buildTransactionItem(Transaction t) {
    final isExpense = t.type == TransactionType.bankWithdraw || 
                      t.type == TransactionType.payment ||
                      (t.type == TransactionType.allowance && t.fromWalletId != null);

    final icon = _getTransactionIcon(t.type);
    final title = t.description ?? _getTransactionTitle(t.type);
    final time = t.createdAt != null ? DateFormat('hh:mm a').format(t.createdAt!) : '';
    final amount = isExpense ? '-${_formatCurrency(t.amount)}' : '+${_formatCurrency(t.amount)}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Icon(
              icon,
              color: isExpense ? AppTheme.textWhite : AppTheme.primaryGreen,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppTheme.textWhite, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("${_getTransactionCategory(t.type)} • $time", style: const TextStyle(color: AppTheme.textGrey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isExpense ? AppTheme.textWhite : AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.bankDeposit:
        return Icons.account_balance_wallet_outlined;
      case TransactionType.bankWithdraw:
        return Icons.account_balance_outlined;
      case TransactionType.allowance:
        return Icons.card_giftcard_outlined;
      case TransactionType.payment:
        return Icons.shopping_bag_outlined;
      case TransactionType.requestTransfer:
        return Icons.swap_horiz_outlined;
    }
  }

  String _getTransactionTitle(TransactionType type) {
    switch (type) {
      case TransactionType.bankDeposit:
        return 'Deposit';
      case TransactionType.bankWithdraw:
        return 'Withdraw';
      case TransactionType.allowance:
        return 'Allowance';
      case TransactionType.payment:
        return 'Payment';
      case TransactionType.requestTransfer:
        return 'Transfer';
    }
  }

  String _getTransactionCategory(TransactionType type) {
    switch (type) {
      case TransactionType.bankDeposit:
        return 'Deposit';
      case TransactionType.bankWithdraw:
        return 'Withdrawal';
      case TransactionType.allowance:
        return 'Family';
      case TransactionType.payment:
        return 'Shopping';
      case TransactionType.requestTransfer:
        return 'Transfer';
    }
  }

  Widget _buildStatisticsSummary(WalletModel? wallet) {
    if (wallet == null) {
      return const SizedBox.shrink();
    }

    final totalTransferred = wallet.totalTransferred;
    final totalSpent = wallet.totalSpent;
    final totalWithdrawn = wallet.totalWithdrawn;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Statistics",
            style: TextStyle(
              color: AppTheme.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow("💸 Transferred to Children", totalTransferred, AppTheme.primaryGreen),
          const SizedBox(height: 12),
          _buildStatRow("🛍️ Total Spent", totalSpent, AppTheme.redAlert),
          const SizedBox(height: 12),
          _buildStatRow("🏦 Total Withdrawn", totalWithdrawn, Colors.orangeAccent),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, double amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppTheme.textGrey, fontSize: 14),
        ),
        Text(
          _formatCurrency(amount),
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
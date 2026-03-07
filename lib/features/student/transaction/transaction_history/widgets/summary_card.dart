import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';

/// Card tổng hợp số dư (thu − chi) — có thể tái sử dụng ở nhiều màn hình.
///
/// Widget này KHÔNG tự tính — nhận [totalIncome] và [totalExpense] đã được
/// query đầy đủ từ Firestore qua `monthlySummaryProvider`.
///
/// - [selectedDate]: ngày đang được chọn bởi user qua Calendar dialog.
///   - `null`  → label hiển thị "Tháng <số tháng>" (tháng hiện tại).
///   - non-null → label hiển thị "Ngày dd/MM" (lọc theo ngày cụ thể).
/// - [displayMonth]: tháng đang query (dùng để hiển thị label khi selectedDate == null).
///   Nếu null, mặc định là tháng hiện tại.
class SummaryCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final DateTime? selectedDate;
  final DateTime? displayMonth;

  const SummaryCard({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
    this.selectedDate,
    this.displayMonth,
  });

  @override
  Widget build(BuildContext context) {
    final double netBalance = totalIncome - totalExpense;
    final bool isPositive = netBalance >= 0;

    // Label logic:
    // - Không filter ngày → "Số dư • Tháng X"
    // - Filter theo ngày cụ thể → "Số dư • Ngày dd/MM"
    final String label;
    if (selectedDate == null) {
      final month = displayMonth ?? DateTime.now();
      label = 'SỐ DƯ • THÁNG ${month.month}';
    } else {
      label = 'SỐ DƯ • NGÀY ${DateFormat('dd/MM').format(selectedDate!)}';
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
                label,
                style: const TextStyle(
                  color: Color(0xFFeaf2eb),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${isPositive ? '+' : '-'} ${CurrencyFormatter.format(netBalance.abs())}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.white : const Color(0xFFFF8A80),
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

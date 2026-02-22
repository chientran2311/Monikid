import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/transaction_item.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppTheme.surfaceDark.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        elevation: 1, // border-b border-slate-100 tương đương elevation nhỏ
        centerTitle: true,
        title: Text(
          "Lịch sử Giao dịch",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        // Nút back giả định HTML có nhưng tabbar không cần back nếu đây là base tab,
        // ở đây cứ để trống leading hoặc để default
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
                              "Tháng 2, 2024",
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

          // Summary Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.primary,
                      Color(0xFF1e5222),
                    ], // primary to primary-dark
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
                        const Text(
                          "TỔNG CHI TIÊU THÁNG NÀY",
                          style: TextStyle(
                            color: Color(0xFFeaf2eb), // primary-light
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
                    const Text(
                      "4.250.000 đ",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildSummaryBadge(Icons.arrow_downward, "Chi: 5.120k"),
                        const SizedBox(width: 16),
                        _buildSummaryBadge(Icons.arrow_upward, "Thu: 870k"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Transactions List - Group 1 (Hôm nay)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateHeader(
                    "Hôm nay, 21 Tháng 2",
                    "- 155.000 đ",
                    isIncome: false,
                  ),
                  const SizedBox(height: 12),
                  TransactionItem(
                    emoji: "🍽️",
                    title: "Cơm tấm sườn bì",
                    subtitle: "Ăn trưa • 12:30",
                    amount: "- 35.000 đ",
                    isIncome: false,
                    bgColor: Colors.orange.withOpacity(0.2),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  TransactionItem(
                    emoji: "📖",
                    title: "Giáo trình Toán Cao Cấp",
                    subtitle: "Học tập • 09:15",
                    amount: "- 120.000 đ",
                    isIncome: false,
                    bgColor: Colors.blue.withOpacity(0.2),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),

          // Transactions List - Group 2 (Hôm qua)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateHeader(
                    "Hôm qua, 20 Tháng 2",
                    "+ 493.000 đ",
                    isIncome: true,
                  ),
                  const SizedBox(height: 12),
                  TransactionItem(
                    emoji: "💳",
                    title: "Mẹ chuyển khoản",
                    subtitle: "Tiền tiêu vặt • 15:20",
                    amount: "+ 500.000 đ",
                    isIncome: true,
                    bgColor: Colors.green.withOpacity(0.2),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  TransactionItem(
                    emoji: "☕",
                    title: "Cà phê muối",
                    subtitle: "Ăn uống • 08:15",
                    amount: "- 7.000 đ",
                    isIncome: false,
                    bgColor: Colors.brown.withOpacity(0.2),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ), // Bottom nav bar padding
        ],
      ),
    );
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
            color: isIncome
                ? const Color(0xFF2563eb)
                : AppTheme.redAlert, // HTML uses 2563eb
          ),
        ),
      ],
    );
  }
}

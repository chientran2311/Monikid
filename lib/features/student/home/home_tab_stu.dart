import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/shared/widgets/transaction_item.dart';
import 'package:monikid/shared/widgets/pin_dialog.dart';

class HomeTabStudent extends ConsumerStatefulWidget {
  const HomeTabStudent({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeTabStudent> createState() => _HomeTabStudentState();
}

class _HomeTabStudentState extends ConsumerState<HomeTabStudent> {
  // Trạng thái hiển thị số dư
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPinDialogIfNeeded(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chào buổi sáng,",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Đạt Chiến",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primary.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuD8i2nO1sdgMgKpryBtLIehCSzgrBNubs2XQtPQQk-5Dn1amotsHY1sLW9YWJerlk4YomNQelTgWuQsAkMJo43zbN1MI-RmE9_bcb0kFhDUfaXe1rwxAWiM6lbZDOHoc_4-_226qRV6w8aQK5nCuquBPQhR09YFgfgEZi591BAdehHtekwXPZoB8A563_Z3OxXuNRvoAj28pmleeNjZtar9eo77zbCOP8wlc7QZx1okz9K9n7OJfeGb3F__V0pjZWspN48L7ts5ZBQ",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.person,
                                    color: AppTheme.primary,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade400,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF1c2a1e)
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2f7f34), Color(0xFF246228)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Decorative background elements (mimicking CSS blur circles)
                      Positioned(
                        top: -40,
                        right: -40,
                        child: Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -32,
                        left: -32,
                        child: Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Số dư hiện tại",
                                style: TextStyle(
                                  color: Colors.green.shade100.withOpacity(0.9),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(
                                  () => _isBalanceVisible = !_isBalanceVisible,
                                ),
                                child: Icon(
                                  _isBalanceVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.green.shade100,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isBalanceVisible ? "5.000.000 ₫" : "******",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Income & Expense Row
                          Row(
                            children: [
                              _buildSummaryMiniCard(
                                title: "Tổng Thu",
                                amount: "2.000.000 ₫",
                                icon: Icons.arrow_downward,
                                iconColor: Colors.blue.shade200,
                                iconBgColor: Colors.blue.shade500.withOpacity(
                                  0.2,
                                ),
                                isVisible: _isBalanceVisible,
                              ),
                              const SizedBox(width: 16),
                              _buildSummaryMiniCard(
                                title: "Tổng Chi",
                                amount: "1.500.000 ₫",
                                icon: Icons.arrow_upward,
                                iconColor: Colors.red.shade200,
                                iconBgColor: Colors.red.shade500.withOpacity(
                                  0.2,
                                ),
                                isVisible: _isBalanceVisible,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Quick Actions Grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuickAction(
                      icon: Icons.qr_code_scanner,
                      label: "Quét QR",
                      color: Colors.orange,
                      isDark: isDark,
                    ),
                    _buildQuickAction(
                      icon: Icons.account_balance_wallet,
                      label: "Nạp tiền",
                      color: Colors.blue,
                      isDark: isDark,
                    ),
                    _buildQuickAction(
                      icon: Icons.savings,
                      label: "Tiết kiệm",
                      color: Colors.purple,
                      isDark: isDark,
                    ),
                    _buildQuickAction(
                      icon: Icons.more_horiz,
                      label: "Xem thêm",
                      color: Colors.pink,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),

            // Recent Transactions Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 24.0,
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Giao dịch gần đây",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Xem tất cả",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recent Transactions List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  TransactionItem(
                    emoji: "🍜",
                    title: "Ăn uống",
                    subtitle: "Sáng nay • 08:30",
                    amount: "-35.000 ₫",
                    isIncome: false,
                    bgColor: Colors.yellow.withOpacity(isDark ? 0.3 : 0.2),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  TransactionItem(
                    emoji: "📚",
                    title: "Học tập",
                    subtitle: "Hôm qua • 14:20",
                    amount: "-120.000 ₫",
                    isIncome: false,
                    bgColor: Colors.blue.withOpacity(isDark ? 0.3 : 0.2),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  TransactionItem(
                    emoji: "🎮",
                    title: "Giải trí",
                    subtitle: "20/10 • 19:45",
                    amount: "-50.000 ₫",
                    isIncome: false,
                    bgColor: Colors.purple.withOpacity(isDark ? 0.3 : 0.2),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  TransactionItem(
                    emoji: "💻",
                    title: "Lương làm thêm",
                    subtitle: "15/10 • 10:00",
                    amount: "+500.000 ₫",
                    isIncome: true,
                    bgColor: Colors.green.withOpacity(isDark ? 0.3 : 0.2),
                    isDark: isDark,
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Padding cho Bottom Nav Bar chìm
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryMiniCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required bool isVisible,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 14, color: iconColor),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade100.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isVisible ? amount : "*****",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required MaterialColor color,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? color.shade900.withOpacity(0.3) : color.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: isDark ? color.shade400 : color.shade600,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}

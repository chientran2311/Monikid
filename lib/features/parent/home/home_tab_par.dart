import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/shared/widgets/transaction_item.dart';
import 'package:monikid/shared/widgets/pin_dialog.dart';

class HomeTabParent extends ConsumerStatefulWidget {
  const HomeTabParent({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeTabParent> createState() => _HomeTabParentState();
}

class _HomeTabParentState extends ConsumerState<HomeTabParent> {
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

    // Define colors used in this page specifically
    final bgColor = isDark ? const Color(0xFF152210) : const Color(0xFFF6F8F6);
    final surfaceColor = isDark ? const Color(0xFF1E2E1A) : Colors.white;
    final parentPrimary = const Color(0xFF49EC13);
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final textSubColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: surfaceColor.withOpacity(0.9),
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            // User Avatar
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: parentPrimary.withOpacity(0.2),
                      width: 2,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://i.pravatar.cc/150?img=11',
                      ), // Placeholder avatar
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: parentPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(color: surfaceColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Greeting & Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chào phụ huynh,",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textSubColor,
                  ),
                ),
                Text(
                  "Nguyễn Văn An",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: const EdgeInsets.only(right: 16),
            icon: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: textSubColor,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppTheme.redAlert,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            // Account Summary Card
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildSummaryCard(parentPrimary),
            ),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    icon: Icons.add_card,
                    label: "Nạp tiền",
                    isPrimary: true,
                    parentPrimary: parentPrimary,
                    isDark: isDark,
                  ),
                  _buildQuickAction(
                    icon: Icons.gpp_maybe,
                    label: "Giới hạn",
                    isPrimary: false,
                    parentPrimary: parentPrimary,
                    isDark: isDark,
                  ),
                  _buildQuickAction(
                    icon: Icons.savings,
                    label: "Tiết kiệm",
                    isPrimary: false,
                    parentPrimary: parentPrimary,
                    isDark: isDark,
                  ),
                  _buildQuickAction(
                    icon: Icons.more_horiz,
                    label: "Thêm",
                    isPrimary: false,
                    parentPrimary: parentPrimary,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Transactions List
            Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Giao dịch mới nhất",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: parentPrimary,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            "Xem tất cả",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Transaction items (reusing TransactionItem from shared)
                    TransactionItem(
                      emoji: "🍔",
                      title: "Canteen trường",
                      subtitle: "Hôm nay, 10:30",
                      amount: "-35.000đ",
                      isIncome: false,
                      bgColor: Colors.orange.shade100,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    TransactionItem(
                      emoji: "📚",
                      title: "Nhà sách Fahasa",
                      subtitle: "Hôm qua, 16:15",
                      amount: "-120.000đ",
                      isIncome: false,
                      bgColor: Colors.blue.shade100,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    TransactionItem(
                      emoji: "💰",
                      title: "Tiền tiêu vặt",
                      subtitle: "01/10, 08:00",
                      amount: "+500.000đ",
                      isIncome: true,
                      bgColor: parentPrimary.withOpacity(0.2),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    TransactionItem(
                      emoji: "🎬",
                      title: "Rạp phim CGV",
                      subtitle: "30/09, 19:30",
                      amount: "-90.000đ",
                      isIncome: false,
                      bgColor: Colors.purple.shade100,
                      isDark: isDark,
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

  Widget _buildSummaryCard(Color parentPrimary) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(
          0xFF0F172A,
        ), // Lấy base nền dark blue sẫm hoặc xám đen giống HTML
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decor Elements
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: parentPrimary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: parentPrimary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Số dư của con (Đạt Chiến)",
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _isBalanceVisible ? "2.500.000đ" : "****** đ",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                            icon: Icon(
                              _isBalanceVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white70,
                              size: 20,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildMiniDashboardItem(
                    title: "Thu nhập",
                    amount: "+500.000đ",
                    icon: Icons.arrow_downward,
                    color: parentPrimary,
                  ),
                  const SizedBox(width: 16),
                  _buildMiniDashboardItem(
                    title: "Chi tiêu",
                    amount: "-1.200.000đ",
                    icon: Icons.arrow_upward,
                    color: AppTheme.redAlert,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniDashboardItem({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
    required bool isPrimary,
    required Color parentPrimary,
    required bool isDark,
  }) {
    final bgColor = isPrimary
        ? (isDark
              ? parentPrimary.withOpacity(0.2)
              : parentPrimary.withOpacity(0.1))
        : (isDark ? const Color(0xFF1E2E1A) : Colors.white);

    final iconColor = isPrimary
        ? parentPrimary
        : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569));

    final borderColor = isPrimary
        ? Colors.transparent
        : (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9));

    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
            boxShadow: [
              if (!isDark && !isPrimary)
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}

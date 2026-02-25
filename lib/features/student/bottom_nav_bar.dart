import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/app/router.dart';

// Import Tabs
import 'package:monikid/features/student/home/home_tab_stu.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_screen.dart';
import 'package:monikid/features/student/statistic/statistic_screen.dart';
import 'package:monikid/features/student/setting/setting_tab_stu.dart';

class StudentBottomNavBar extends StatefulWidget {
  const StudentBottomNavBar({Key? key}) : super(key: key);

  @override
  State<StudentBottomNavBar> createState() => _StudentBottomNavBarState();
}

class _StudentBottomNavBarState extends State<StudentBottomNavBar> {
  // Logic index để chuyển hướng giữa các màn hình
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTabStudent(),
    const TransactionHistoryScreen(),
    const StatisticScreen(),
    const SettingTabStudent(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Background based on HTML: `bg-white dark:bg-[#1c2a1e]`
    final bgColor = isDark ? const Color(0xFF1c2a1e) : Colors.white;

    // Unselected colors based on HTML: `text-slate-400 dark:text-slate-500`
    final unselectedColor = isDark
        ? const Color(0xFF64748B)
        : const Color(0xFF94A3B8);

    return Scaffold(
      // IndexedStack dùng để giữ state của các tab không bị reload khi chuyển qua lại
      body: IndexedStack(index: _currentIndex, children: _tabs),

      // Nút (+) thêm giao dịch ở giữa
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            context.push(AppRoutes.addTransaction);
          },
          backgroundColor: AppTheme.primary,
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(Icons.add_rounded, size: 36, color: Colors.white),
        ),
      ),

      // Ghim FAB ở giữa navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: bgColor,
        shape: const CircularNotchedRectangle(), // Khoét lỗ giữa cho FAB
        notchMargin: 8.0,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Nhóm bên trái
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(
                  0,
                  Icons.home_rounded,
                  "Trang chủ",
                  unselectedColor,
                ),
                const SizedBox(width: 32),
                _buildNavItem(
                  1,
                  Icons.receipt_long_rounded,
                  "Giao dịch",
                  unselectedColor,
                ),
              ],
            ),
            // Khoảng trống ở giữa cho FAB (tự bù trừ do spaceBetween của Row lớn)

            // Nhóm bên phải
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(
                  2,
                  Icons.bar_chart_rounded,
                  "Thống kê",
                  unselectedColor,
                ),
                const SizedBox(width: 32),
                _buildNavItem(
                  3,
                  Icons.settings_rounded,
                  "Cài đặt",
                  unselectedColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    Color unselectedColor,
  ) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppTheme.primary : unselectedColor;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

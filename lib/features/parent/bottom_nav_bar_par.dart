import 'package:flutter/material.dart';

// Import Tabs
import 'package:monikid/features/parent/home/home_tab_par.dart';
import 'package:monikid/features/parent/statistic/statistic_tab_par.dart';
import 'package:monikid/features/parent/setting/setting_tab_par.dart';

class ParentBottomNavBar extends StatefulWidget {
  const ParentBottomNavBar({Key? key}) : super(key: key);

  @override
  State<ParentBottomNavBar> createState() => _ParentBottomNavBarState();
}

class _ParentBottomNavBarState extends State<ParentBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTabParent(),
    const StatisticTabParent(),
    const SettingTabParent(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Background based on HTML: `bg-surface-light dark:bg-surface-dark`
    final bgColor = isDark ? const Color(0xFF1e2e1a) : Colors.white;
    final parentPrimary = const Color(0xFF49ec13); // primary color from HTML
    final unselectedColor = isDark
        ? const Color(0xFF64748B)
        : const Color(0xFF94A3B8); // slate-400

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            ),
          ),
        ),
        child: SafeArea(
          // Padding cho iPhone home indicator
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  0,
                  Icons.home_filled,
                  "Trang chủ",
                  parentPrimary,
                  unselectedColor,
                ),
                _buildCenterNavItem(
                  1,
                  Icons.pie_chart,
                  "Thống kê",
                  parentPrimary,
                  unselectedColor,
                  isDark,
                  bgColor,
                ),
                _buildNavItem(
                  2,
                  Icons.settings,
                  "Cài đặt",
                  parentPrimary,
                  unselectedColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    Color primaryColor,
    Color unselectedColor,
  ) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? primaryColor : unselectedColor;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64, // w-16 in tailwind
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
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
      ),
    );
  }

  // Custom Center Item (The Thống kê tab has a special look in HTML)
  Widget _buildCenterNavItem(
    int index,
    IconData icon,
    String label,
    Color primaryColor,
    Color unselectedColor,
    bool isDark,
    Color bgColor,
  ) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? primaryColor : unselectedColor;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thống kê icon in HTML has relative -top-5 for floating effect when active (or just a special circle)
            // Lấy cảm hứng từ HTML: <div class="bg-primary text-white h-14 w-14 rounded-full flex items-center justify-center...">
            if (isSelected)
              Transform.translate(
                offset: const Offset(0, -16), // Nâng lên
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: bgColor, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.pie_chart, color: Colors.white, size: 28),
                  ),
                ),
              )
            else
              Icon(icon, color: color, size: 28),

            const SizedBox(height: 4),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'widgets/month_tab.dart';
import 'widgets/legend_item.dart';
import 'widgets/category_progress_item.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  // 0: Tháng trước, 1: Tháng này
  int _selectedMonthIndex = 1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : const Color(0xFFf9fbf9);
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppTheme.surfaceDark.withOpacity(0.9)
            : const Color(0xFFf9fbf9).withOpacity(0.9),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Thống kê Chi tiêu",
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Month Selector
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFF1F5F9), // slate-800 / slate-100
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        MonthTab(
                          title: "Tháng trước",
                          index: 0,
                          isDark: isDark,
                          selectedMonthIndex: _selectedMonthIndex,
                          onMonthSelected: (idx) =>
                              setState(() => _selectedMonthIndex = idx),
                        ),
                        MonthTab(
                          title: "Tháng này",
                          index: 1,
                          isDark: isDark,
                          selectedMonthIndex: _selectedMonthIndex,
                          onMonthSelected: (idx) =>
                              setState(() => _selectedMonthIndex = idx),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Total Spend Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -40,
                          right: -30,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tổng chi tiêu tháng này",
                              style: TextStyle(
                                color: Color(0xFFeaf5ea),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "2.500.000 đ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_down,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Thấp hơn 5% so với tháng trước",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Chart Section (Fake UI circle chart)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phân bổ chi tiêu",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Circular Chart Mockup
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 180,
                                height: 180,
                                child: CircularProgressIndicator(
                                  value:
                                      0.8, // 80% to show multiple colors (fake visual)
                                  strokeWidth: 20,
                                  color: AppTheme.primary,
                                  backgroundColor: const Color(
                                    0xFFE89F29,
                                  ), // secondary
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              // Another progress on top to simulate 3rd color
                              SizedBox(
                                width: 180,
                                height: 180,
                                child: CircularProgressIndicator(
                                  value: 0.35,
                                  strokeWidth: 20,
                                  color: const Color(0xFF5e8761),
                                  backgroundColor: Colors.transparent,
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Cao nhất",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                  Text(
                                    "Ăn uống",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Legend
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            LegendItem(
                              label: "Ăn uống",
                              color: AppTheme.primary,
                              isDark: isDark,
                            ),
                            LegendItem(
                              label: "Học tập",
                              color: const Color(0xFFE89F29),
                              isDark: isDark,
                            ),
                            LegendItem(
                              label: "Di chuyển",
                              color: const Color(0xFF5e8761),
                              isDark: isDark,
                            ),
                            LegendItem(
                              label: "Khác",
                              color: const Color(0xFFa3c4a6),
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top Categories List
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top 3 danh mục chi tiêu",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const Text(
                        "Xem tất cả",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  CategoryProgressItem(
                    icon: Icons.restaurant,
                    name: "Ăn uống",
                    amount: "1.500.000đ",
                    percent: 0.6,
                    color: AppTheme.primary,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  CategoryProgressItem(
                    icon: Icons.school,
                    name: "Học tập",
                    amount: "500.000đ",
                    percent: 0.2,
                    color: const Color(0xFFE89F29),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  CategoryProgressItem(
                    icon: Icons.directions_bus,
                    name: "Di chuyển",
                    amount: "300.000đ",
                    percent: 0.12,
                    color: const Color(0xFF5e8761),
                    isDark: isDark,
                  ),

                  const SizedBox(height: 100), // Bottom nav padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

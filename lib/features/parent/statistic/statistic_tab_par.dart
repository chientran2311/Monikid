import 'package:flutter/material.dart';

class StatisticTabParent extends StatefulWidget {
  const StatisticTabParent({Key? key}) : super(key: key);

  @override
  State<StatisticTabParent> createState() => _StatisticTabParentState();
}

class _StatisticTabParentState extends State<StatisticTabParent> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Theme colors from statustuc_par.html
    final bgColor = isDark ? const Color(0xFF102212) : const Color(0xFFF6F8F6);
    final surfaceColor = isDark ? const Color(0xFF1A2E1D) : Colors.white;
    final primary = const Color(0xFF13EC22); // parent green
    final textColor = isDark
        ? const Color(0xFFE0ECE0)
        : const Color(0xFF0D1B0E);
    final textSubColor = isDark
        ? const Color(0xFF8A9E8C)
        : const Color(0xFF5F7161);
    final borderColor = isDark
        ? const Color(0xFF1F2937)
        : const Color(0xFFF3F4F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor.withOpacity(0.95),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () {},
        ),
        title: Text(
          "Thống kê Chi tiêu",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month, color: textColor),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: borderColor)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMonthTab("Tháng 9", false, primary, textSubColor),
                _buildMonthTab("Tháng 10", true, primary, textSubColor),
                _buildMonthTab("Tháng 11", false, primary, textSubColor),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 100),
        child: Column(
          children: [
            // Pie Chart Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: borderColor),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Tổng chi tiêu tháng này",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Simplified Custom Donut Chart (Stack with CircularProgressIndicator)
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      children: [
                        // Background circle
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 20,
                              color: isDark
                                  ? const Color(0xFF374151)
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                        ),
                        // Segment 1 (Khác)
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 20,
                              color: const Color(0xFF065F46),
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                        // Segment 2 (Học tập)
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.8, // 100% - 20%
                              strokeWidth: 20,
                              color: const Color(0xFF10B981),
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                        // Segment 3 (Di chuyển)
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.68, // 80% - 12%
                              strokeWidth: 20,
                              color: const Color(0xFF2DD4BF),
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                        // Segment 4 (Ăn uống)
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.48, // 68% - 20%
                              strokeWidth: 20,
                              color: const Color(0xFF13EC22), // primary green
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),

                        // Center text
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tổng cộng",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textSubColor,
                                ),
                              ),
                              Text(
                                "2.500k",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Legend
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildLegendItem(
                        "Ăn uống",
                        const Color(0xFF13EC22),
                        textSubColor,
                      ),
                      _buildLegendItem(
                        "Di chuyển",
                        const Color(0xFF2DD4BF),
                        textSubColor,
                      ),
                      _buildLegendItem(
                        "Học tập",
                        const Color(0xFF10B981),
                        textSubColor,
                      ),
                      _buildLegendItem(
                        "Khác",
                        const Color(0xFF065F46),
                        textSubColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Analysis Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.analytics,
                              color: primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Phân tích ngân sách",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Trong hạn mức",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark ? primary : const Color(0xFF0EB51A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đã dùng",
                        style: TextStyle(fontSize: 14, color: textSubColor),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "2.500.000đ ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            TextSpan(
                              text: "/ 3.000.000đ",
                              style: TextStyle(
                                fontSize: 14,
                                color: textSubColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 2.5 / 3.0,
                      backgroundColor: isDark
                          ? const Color(0xFF374151)
                          : const Color(0xFFF3F4F6),
                      valueColor: AlwaysStoppedAnimation<Color>(primary),
                      minHeight: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Còn lại 500.000đ cho tháng này",
                      style: TextStyle(fontSize: 12, color: textSubColor),
                    ),
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
                  "Danh mục chi tiêu",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: primary,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    "Xem tất cả",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildCategoryItem(
              icon: Icons.restaurant,
              title: "Ăn uống",
              amount: "1.200.000đ",
              percentage: "48%",
              value: 0.48,
              color: const Color(0xFF13EC22), // primary
              bgColor: isDark
                  ? const Color(0xFF1A3820)
                  : const Color(0xFFE7F8E8),
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              textColor: textColor,
              textSubColor: textSubColor,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildCategoryItem(
              icon: Icons.directions_bus,
              title: "Di chuyển",
              amount: "500.000đ",
              percentage: "20%",
              value: 0.20,
              color: const Color(0xFF2DD4BF), // teal
              bgColor: isDark
                  ? const Color(0xFF134E4A)
                  : const Color(0xFFF0FDFA),
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              textColor: textColor,
              textSubColor: textSubColor,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildCategoryItem(
              icon: Icons.school,
              title: "Học tập",
              amount: "300.000đ",
              percentage: "12%",
              value: 0.12,
              color: const Color(0xFF10B981), // emerald
              bgColor: isDark
                  ? const Color(0xFF064E3B)
                  : const Color(0xFFECFDF5),
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              textColor: textColor,
              textSubColor: textSubColor,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildCategoryItem(
              icon: Icons.more_horiz,
              title: "Khác",
              amount: "500.000đ",
              percentage: "20%",
              value: 0.20,
              color: const Color(0xFF64748B), // slate
              bgColor: isDark
                  ? const Color(0xFF1E293B)
                  : const Color(0xFFF1F5F9),
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              textColor: textColor,
              textSubColor: textSubColor,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthTab(
    String title,
    bool isActive,
    Color primaryColor,
    Color unselectedColor,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isActive ? 16 : 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? primaryColor : unselectedColor,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, Color textSubColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSubColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String title,
    required String amount,
    required String percentage,
    required double value,
    required Color color,
    required Color bgColor,
    required Color surfaceColor,
    required Color borderColor,
    required Color textColor,
    required Color textSubColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: value,
                          backgroundColor: isDark
                              ? const Color(0xFF374151)
                              : const Color(0xFFF3F4F6),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 32,
                      child: Text(
                        percentage,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: textSubColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

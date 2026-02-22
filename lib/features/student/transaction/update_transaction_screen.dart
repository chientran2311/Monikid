import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';

class UpdateTransactionScreen extends StatefulWidget {
  const UpdateTransactionScreen({Key? key}) : super(key: key);

  @override
  State<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState extends State<UpdateTransactionScreen> {
  int _transactionType = 0; // 0: Tiền chi, 1: Tiền thu

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppTheme.backgroundDark.withOpacity(0.95)
            : AppTheme.backgroundLight.withOpacity(0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Chỉnh sửa Giao dịch",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amount Input
                const Text(
                  "Số tiền",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
                    suffixText: "₫",
                    suffixStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94A3B8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.primary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primary, width: 2),
                    ),
                  ),
                  controller: TextEditingController(text: "50.000"),
                ),
                const SizedBox(height: 24),

                // Segmented Control
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildTypeTab("Tiền chi", 0, isDark),
                      _buildTypeTab("Tiền thu", 1, isDark),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form Fields Group
                _buildActionRow(
                  iconStr: "🍜",
                  label: "Danh mục",
                  value: "Ăn uống",
                  iconBgColor: Colors.orange.shade100,
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                ),
                const SizedBox(height: 16),
                _buildActionRow(
                  iconData: Icons.calendar_today,
                  label: "Ngày",
                  value: "Hôm nay, 24/05/2024",
                  iconBgColor: AppTheme.primary.withOpacity(0.1),
                  iconColor: AppTheme.primary,
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                ),
                const SizedBox(height: 16),

                // Note Input
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                        ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_note,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ghi chú",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            TextField(
                              maxLines: 2,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Thêm ghi chú...",
                                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                              ),
                              controller: TextEditingController(
                                text: "Ăn trưa với bạn bè",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Wallet Selector
                _buildActionRow(
                  iconData: Icons.account_balance_wallet,
                  label: "Ví nguồn",
                  value: "Ví tiền mặt",
                  iconBgColor: Colors.green.shade100,
                  iconColor: Colors.green.shade700,
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                  trailingIcon: Icons.expand_more,
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // Bottom Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.backgroundDark.withOpacity(0.9)
                    : AppTheme.backgroundLight.withOpacity(0.9),
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF1e5222,
                  ), // primary-dark as in HTML
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Cập nhật giao dịch",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeTab(String title, int index, bool isDark) {
    final isSelected = _transactionType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _transactionType = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.white
                  : (isDark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow({
    String? iconStr,
    IconData? iconData,
    Color? iconBgColor,
    Color? iconColor,
    required String label,
    required String value,
    required bool isDark,
    required Color surfaceColor,
    IconData trailingIcon = Icons.chevron_right,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: iconStr != null
                  ? Text(iconStr, style: const TextStyle(fontSize: 24))
                  : Icon(iconData, color: iconColor),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
          Icon(trailingIcon, color: const Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Widget tái sử dụng cho 1 dòng Setting item
/// Dùng chung được cho cả Student và Parent setting.
class SettingItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing; // Widget phụ bên phải (ví dụ icon QR)
  final bool showChevron;
  final bool showBorder;

  const SettingItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    this.onTap,
    this.trailing,
    this.showChevron = true,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF1F2937)
        : const Color(0xFFF9FAFB);

    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: borderColor))
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icon tròn
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ),
                // Trailing widgets
                if (trailing != null) ...[trailing!, const SizedBox(width: 4)],
                if (showChevron)
                  Icon(
                    Icons.chevron_right,
                    color: isDark
                        ? const Color(0xFF4B5563)
                        : const Color(0xFF9CA3AF),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

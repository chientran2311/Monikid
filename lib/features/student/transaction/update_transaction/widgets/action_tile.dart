import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({
    super.key,
    this.iconStr,
    this.iconData,
    this.iconBgColor,
    this.iconColor,
    required this.label,
    required this.value,
    required this.isDark,
    required this.surfaceColor,
    required this.enabled,
    this.onTap,
    this.trailingIcon = Icons.chevron_right,
  });

  final String? iconStr;
  final IconData? iconData;
  final Color? iconBgColor;
  final Color? iconColor;
  final String label;
  final String value;
  final bool isDark;
  final Color surfaceColor;
  final bool enabled;
  final VoidCallback? onTap;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
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
                child: iconStr != null && iconStr!.isNotEmpty
                    ? Text(iconStr!, style: const TextStyle(fontSize: 24))
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
            Icon(
              trailingIcon,
              color: enabled
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFFCBD5E1),
            ),
          ],
        ),
      ),
    );
  }
}

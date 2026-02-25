import 'package:flutter/material.dart';

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final Color parentPrimary;
  final bool isDark;

  const QuickAction({
    Key? key,
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.parentPrimary,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

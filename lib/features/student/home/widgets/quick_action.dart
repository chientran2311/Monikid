import 'package:flutter/material.dart';

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final MaterialColor color;
  final bool isDark;

  const QuickAction({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

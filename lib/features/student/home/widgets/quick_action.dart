import 'package:flutter/material.dart';

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final MaterialColor color;
  final bool isDark;
  final VoidCallback? onTap;

  const QuickAction({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Ink(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? color.shade900.withOpacity(0.3) : color.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDark ? color.shade400 : color.shade600,
              size: 24,
            ),
          ),
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

import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    required this.circleSize,
    required this.iconSize,
    required this.labelFontSize,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final MaterialColor color;
  final bool isDark;
  final double circleSize;
  final double iconSize;
  final double labelFontSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Ink(
              width: circleSize,
              height: circleSize,
              decoration: BoxDecoration(
                color: isDark
                    ? color.shade900.withValues(alpha: 0.3)
                    : color.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDark ? color.shade400 : color.shade600,
                size: iconSize,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: labelFontSize,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class MiniDashboardItem extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const MiniDashboardItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 14),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: context.typo.caption.big.copyWith(
                  color: AppTheme.iconLight,
                ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: context.typo.subtitle.small.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),
    );
  }
}

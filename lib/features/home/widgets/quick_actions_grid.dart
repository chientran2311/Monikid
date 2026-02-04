import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget hiển thị lưới các Quick Action buttons
class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: QuickActionButton(icon: Icons.history, label: "Recent"),
            ),
            SizedBox(width: 16),
            Expanded(
              child: QuickActionButton(icon: Icons.bookmark, label: "Saved"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: QuickActionButton(icon: Icons.download, label: "Export"),
            ),
            SizedBox(width: 16),
            Expanded(
              child: QuickActionButton(icon: Icons.settings, label: "Settings"),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget button đơn lẻ cho Quick Action
/// Được tách riêng để có thể tái sử dụng ở nhiều nơi
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardFill,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

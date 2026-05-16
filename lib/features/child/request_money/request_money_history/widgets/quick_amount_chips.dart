import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class QuickAmountChips extends StatelessWidget {
  const QuickAmountChips({
    required this.onAddAmount,
    super.key,
  });

  final void Function(double amount) onAddAmount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAmountChip(10000, '+10.000đ', () => onAddAmount(10000)),
          const SizedBox(width: 8),
          _buildAmountChip(20000, '+20.000đ', () => onAddAmount(20000)),
          const SizedBox(width: 8),
          _buildAmountPrimaryChip(50000, '+50.000đ', () => onAddAmount(50000)),
        ],
      ),
    );
  }

  Widget _buildAmountChip(double amount, String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.transparent,
      side: BorderSide(color: Colors.grey.shade400),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.textGrey,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget _buildAmountPrimaryChip(double amount, String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.green.shade50,
      side: const BorderSide(color: AppTheme.primary),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

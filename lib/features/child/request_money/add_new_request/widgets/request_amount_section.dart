import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RequestAmountSection extends StatelessWidget {
  const RequestAmountSection({
    required this.amountController,
    required this.isDark,
    required this.onAddAmount,
    super.key,
  });

  final TextEditingController amountController;
  final bool isDark;
  final void Function(double amount) onAddAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceVariant : Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Số tiền con cần',
            style: TextStyle(
              color: isDark ? Colors.grey.shade400 : AppTheme.textGrey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              IntrinsicWidth(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'đ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AmountChip(amount: 10000, label: '+10.000đ', onAdd: onAddAmount),
                const SizedBox(width: 8),
                _AmountChip(amount: 20000, label: '+20.000đ', onAdd: onAddAmount),
                const SizedBox(width: 8),
                _AmountChip(
                  amount: 50000,
                  label: '+50.000đ',
                  onAdd: onAddAmount,
                  isSelected: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AmountChip extends StatelessWidget {
  const _AmountChip({
    required this.amount,
    required this.label,
    required this.onAdd,
    this.isSelected = false,
  });

  final double amount;
  final String label;
  final void Function(double) onAdd;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () => onAdd(amount),
      backgroundColor: isSelected ? Colors.green.shade50 : Colors.transparent,
      side: BorderSide(
        color: isSelected ? AppTheme.primary : Colors.grey.shade300,
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isSelected ? AppTheme.primary : AppTheme.textGrey,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

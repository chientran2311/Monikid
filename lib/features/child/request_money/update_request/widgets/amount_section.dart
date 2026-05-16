import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class AmountSection extends StatelessWidget {
  const AmountSection({
    super.key,
    required this.amountController,
    required this.surfaceColor,
    required this.subTextColor,
    required this.borderColor,
    required this.isDarkMode,
    required this.onAddAmount,
  });

  final TextEditingController amountController;
  final Color surfaceColor;
  final Color subTextColor;
  final Color borderColor;
  final bool isDarkMode;
  final void Function(double) onAddAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Số tiền yêu cầu',
            style: TextStyle(color: subTextColor, fontSize: 14),
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
              children: [
                _amountChip('+10.000đ', false, () => onAddAmount(10000)),
                const SizedBox(width: 8),
                _amountChip('+20.000đ', false, () => onAddAmount(20000)),
                const SizedBox(width: 8),
                _amountChip('+50.000đ', true, () => onAddAmount(50000)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountChip(String label, bool isPrimary, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: isPrimary ? Colors.green.shade50 : Colors.transparent,
      side: BorderSide(color: isPrimary ? AppTheme.primary : borderColor),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isPrimary ? AppTheme.primary : (isDarkMode ? Colors.grey.shade400 : AppTheme.textGrey),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }
}

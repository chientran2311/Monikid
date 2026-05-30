import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';

class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({
    super.key,
    required this.isDark,
    required this.surfaceColor,
    required this.selectedType,
    required this.enabled,
    required this.onSelectExpense,
    required this.onSelectIncome,
  });

  final bool isDark;
  final Color surfaceColor;
  final TransactionType selectedType;
  final bool enabled;
  final VoidCallback onSelectExpense;
  final VoidCallback onSelectIncome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppTheme.surfaceVariant
              : AppTheme.borderLight,
        ),
      ),
      child: Row(
        children: [
          _TypeTab(
            title: s.transactionExpenseType,
            type: TransactionType.expense,
            selectedType: selectedType,
            isDark: isDark,
            enabled: enabled,
            onTap: onSelectExpense,
          ),
          _TypeTab(
            title: s.transactionIncomeType,
            type: TransactionType.income,
            selectedType: selectedType,
            isDark: isDark,
            enabled: enabled,
            onTap: onSelectIncome,
          ),
        ],
      ),
    );
  }
}

class _TypeTab extends StatelessWidget {
  const _TypeTab({
    required this.title,
    required this.type,
    required this.selectedType,
    required this.isDark,
    required this.enabled,
    required this.onTap,
  });

  final String title;
  final TransactionType type;
  final TransactionType selectedType;
  final bool isDark;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (type == TransactionType.expense
                      ? AppTheme.redAlert
                      : AppTheme.chartGreen)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: context.typo.body.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.white
                  : (isDark
                        ? AppTheme.textMuted
                        : AppTheme.textGrey),
            ),
          ),
        ),
      ),
    );
  }
}

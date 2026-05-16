import 'package:flutter/material.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_type_tab.dart';

class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({
    required this.selectedIndex,
    required this.onTypeChanged,
    required this.expenseLabel,
    required this.incomeLabel,
    required this.isDark,
    required this.surfaceColor,
    required this.enabled,
    super.key,
  });

  final int selectedIndex;
  final void Function(int index) onTypeChanged;
  final String expenseLabel;
  final String incomeLabel;
  final bool isDark;
  final Color surfaceColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? surfaceColor : const Color(0xFFeaf0ea),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          TransactionTypeTab(
            title: expenseLabel,
            index: 0,
            selectedIndex: selectedIndex,
            onTabSelected: enabled ? onTypeChanged : (_) {},
          ),
          TransactionTypeTab(
            title: incomeLabel,
            index: 1,
            selectedIndex: selectedIndex,
            onTabSelected: enabled ? onTypeChanged : (_) {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class SummaryHeader extends StatelessWidget {
  const SummaryHeader({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: transaction.type == 'income'
                ? Colors.green.withValues(alpha: 0.1)
                : AppTheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: transaction.type == 'income'
                  ? Colors.green.withValues(alpha: 0.2)
                  : AppTheme.primary.withValues(alpha: 0.1),
              width: 4,
            ),
          ),
          child: Center(
            child: Text(
              transaction.categoryEmoji ??
                  (transaction.type == 'income' ? '💰' : '💸'),
              style: const TextStyle(fontSize: 36),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          transaction.category,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          CurrencyFormatter.formatWithSign(
            transaction.amount,
            transaction.type,
          ),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: transaction.type == 'income'
                ? Colors.green
                : AppTheme.redAlert,
          ),
        ),
      ],
    );
  }
}

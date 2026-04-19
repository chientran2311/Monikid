import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_item.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class HomeRecentTransactionsSection extends ConsumerWidget {
  const HomeRecentTransactionsSection({
    super.key,
    required this.title,
    required this.viewAllLabel,
    required this.transactions,
    required this.emptyLabel,
  });

  final String title;
  final String viewAllLabel;
  final List<TransactionModel> transactions;
  final String emptyLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : const Color(0xFF0F172A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.transactionHistory),
              child: Text(
                viewAllLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (transactions.isEmpty)
          Center(child: Text(emptyLabel))
        else
          ...transactions.map(
            (transaction) => TransactionItem(
              transaction: transaction,
              onTap: () {
                ref
                    .read(transactionHistoryProvider.notifier)
                    .selectTransaction(transaction);
                context.push(
                  AppRoutes.detailTransactionPath(transaction.transactionId),
                );
              },
            ),
          ),
      ],
    );
  }
}

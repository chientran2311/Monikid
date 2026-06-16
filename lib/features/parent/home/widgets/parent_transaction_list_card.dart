import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_item.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class ParentTransactionListCard extends StatelessWidget {
  const ParentTransactionListCard({
    required this.transactions,
    required this.isLoading,
    required this.emptyLabel,
    super.key,
  });

  final List<TransactionModel> transactions;
  final bool isLoading;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: Text(
            emptyLabel,
            style: context.typo.body.medium.copyWith(color: mutedColor),
          ),
        ),
      );
    }

    return Column(
      children: transactions
          .map((tx) => TransactionItem(transaction: tx))
          .toList(),
    );
  }
}

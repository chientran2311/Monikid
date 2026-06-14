import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/widgets/home_transaction_row.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class ParentTransactionListCard extends StatelessWidget {
  const ParentTransactionListCard({
    required this.isDark,
    required this.transactions,
    required this.isLoading,
    required this.emptyLabel,
    this.memberName,
    super.key,
  });

  final bool isDark;
  final List<TransactionModel> transactions;
  final bool isLoading;
  final String emptyLabel;
  final String? memberName;

  @override
  Widget build(BuildContext context) {
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
      children: List.generate(transactions.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < transactions.length - 1 ? 10.h : 0),
          child: HomeTransactionRow(
            tx: transactions[i],
            isDark: isDark,
            memberName: memberName,
          ),
        );
      }),
    );
  }
}

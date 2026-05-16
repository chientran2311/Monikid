import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/widgets/home_transaction_row.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class ParentTransactionListCard extends StatelessWidget {
  const ParentTransactionListCard({
    required this.isDark,
    required this.surfaceColor,
    required this.borderColor,
    required this.textColor,
    required this.mutedColor,
    required this.transactions,
    required this.isLoading,
    required this.emptyLabel,
    super.key,
  });

  final bool isDark;
  final Color surfaceColor;
  final Color borderColor;
  final Color textColor;
  final Color mutedColor;
  final List<TransactionModel> transactions;
  final bool isLoading;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: isDark ? Border.all(color: borderColor, width: 0.5) : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: isLoading
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: const Center(child: CircularProgressIndicator()),
            )
          : transactions.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Center(
                    child: Text(
                      emptyLabel,
                      style: TextStyle(color: mutedColor, fontSize: 14.sp),
                    ),
                  ),
                )
              : Column(
                  children: List.generate(transactions.length, (i) {
                    return HomeTransactionRow(
                      tx: transactions[i],
                      textColor: textColor,
                      mutedColor: mutedColor,
                      borderColor: borderColor,
                      showDivider: i < transactions.length - 1,
                    );
                  }),
                ),
    );
  }
}

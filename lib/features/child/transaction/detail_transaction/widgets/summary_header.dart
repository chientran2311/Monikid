import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class SummaryHeader extends StatelessWidget {
  const SummaryHeader({super.key, required this.transaction, required this.isDark});

  final TransactionModel transaction;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type != 'income';
    final dotColor = isExpense ? AppTheme.redAlert : AppTheme.chartGreen;
    final typeLabel = isExpense ? s.transactionExpenseType : s.transactionIncomeType;
    final formatted = CurrencyFormatter.formatWithSign(transaction.amount, transaction.type);
    final amountText = formatted.endsWith('đ')
        ? formatted.substring(0, formatted.length - 1).trim()
        : formatted;
    final textColor = isExpense
        ? (isDark ? AppTheme.textWhite : AppTheme.textBlack)
        : AppTheme.chartGreen;

    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 28.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
              SizedBox(width: 6.w),
              Text(
                typeLabel.toUpperCase(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textGrey,
                  letterSpacing: 0.65,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amountText,
                style: TextStyle(
                  fontSize: 44.sp,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  letterSpacing: -1.5,
                  height: 1.1,
                ),
              ),
              SizedBox(width: 4.w),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'đ',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

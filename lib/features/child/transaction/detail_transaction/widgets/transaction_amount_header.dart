import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class TransactionAmountHeader extends StatelessWidget {
  const TransactionAmountHeader({
    super.key,
    required this.transaction,
    required this.isDark,
  });

  final TransactionModel transaction;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';
    return Column(
      children: [
        SizedBox(height: 32.h),
        _AmountDisplay(transaction: transaction, isDark: isDark),
        SizedBox(height: 24.h),
        _TypeIndicator(isIncome: isIncome, isDark: isDark),
        SizedBox(height: 24.h),
        _CategoryChip(
          emoji: transaction.categoryEmoji ?? (isIncome ? '💰' : '💸'),
          name: transaction.category,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay({required this.transaction, required this.isDark});

  final TransactionModel transaction;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          s.transactionAmountLabel.toUpperCase(),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.textGrey,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                'đ',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textMuted,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              CurrencyFormatter.format(transaction.amount)
                  .replaceAll('đ', '')
                  .trim(),
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w800,
                color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                letterSpacing: -1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TypeIndicator extends StatelessWidget {
  const _TypeIndicator({required this.isIncome, required this.isDark});

  final bool isIncome;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final trackColor = isDark ? AppTheme.surfaceDark : AppTheme.controlTrack;
    return Container(
      height: 40.h,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: Row(
        children: [
          _Tab(label: s.customCategoryTypeExpense, isActive: !isIncome, isDark: isDark),
          _Tab(label: s.customCategoryTypeIncome, isActive: isIncome, isDark: isDark),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.isActive, required this.isDark});

  final String label;
  final bool isActive;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive
              ? (isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLight)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(11.r),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: isActive ? AppTheme.primary : AppTheme.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.emoji, required this.name});

  final String emoji;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            border: Border.all(color: AppTheme.primary, width: 1.5.r),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.1),
                blurRadius: 16.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Center(
            child: Text(emoji, style: TextStyle(fontSize: 26.sp)),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class MemberSpendingCard extends StatelessWidget {
  const MemberSpendingCard({
    super.key,
    required this.isDark,
    required this.isLoading,
    required this.expenseMinor,
    required this.incomeMinor,
  });

  final bool isDark;
  final bool isLoading;
  final int expenseMinor;
  final int incomeMinor;

  String _formatAmount(int minor) {
    final amount = minor / 100;
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor =
        isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

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
      padding: EdgeInsets.all(16.r),
      child: isLoading
          ? SizedBox(
              height: 60.h,
              child: const Center(child: CircularProgressIndicator()),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.homeParSpendingOverview.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: mutedColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _MetricTile(
                        label: s.homeParMonthlyExpense,
                        amount: _formatAmount(expenseMinor),
                        color: AppTheme.redAlert,
                        isDark: isDark,
                        textColor: textColor,
                        mutedColor: mutedColor,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _MetricTile(
                        label: s.homeParMonthlyIncome,
                        amount: _formatAmount(incomeMinor),
                        color: AppTheme.primary,
                        isDark: isDark,
                        textColor: textColor,
                        mutedColor: mutedColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.amount,
    required this.color,
    required this.isDark,
    required this.textColor,
    required this.mutedColor,
  });

  final String label;
  final String amount;
  final Color color;
  final bool isDark;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark
        ? color.withValues(alpha: 0.15)
        : color.withValues(alpha: 0.08);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: mutedColor),
          ),
          SizedBox(height: 4.h),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

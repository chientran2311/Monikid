import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ParentBudgetOverviewCard extends StatelessWidget {
  const ParentBudgetOverviewCard({
    super.key,
    required this.isDark,
    this.budgetLabel,
    this.totalAmount,
    this.spentAmount,
    this.leftAmount,
    this.progress,
  });

  final bool isDark;
  final String? budgetLabel;
  final String? totalAmount;
  final String? spentAmount;
  final String? leftAmount;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final barBg = isDark ? AppTheme.borderDark : const Color(0xFFF4F4F5);

    final label = budgetLabel ?? s.parentStatisticBudgetTitle;
    final total = totalAmount ?? '--';
    final spent = spentAmount ?? '--';
    final left = leftAmount ?? '--';
    final prog = progress ?? 0.0;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 0.5),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: mutedColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      total,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppTheme.primary,
                  size: 20.r,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${s.parentStatisticSpentLabel}: $spent',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              Text(
                '${s.parentStatisticLeftLabel}: $left',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: mutedColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: LinearProgressIndicator(
              value: prog,
              minHeight: 10.h,
              backgroundColor: barBg,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

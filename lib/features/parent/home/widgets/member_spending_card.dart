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
    this.onViewDetail,
  });

  final bool isDark;
  final bool isLoading;
  final int expenseMinor;
  final int incomeMinor;
  final VoidCallback? onViewDetail;

  String _formatAmount(int minor) {
    return NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    ).format(minor / 100);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

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
      padding: EdgeInsets.all(20.r),
      child: isLoading
          ? SizedBox(
              height: 120.h,
              child: const Center(child: CircularProgressIndicator()),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(
                  isDark: isDark,
                  textColor: textColor,
                  mutedColor: mutedColor,
                  label: s.homeParThisMonth,
                  actionLabel: s.homeParViewDetail,
                  onAction: onViewDetail,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: _MetricColumn(
                        isDark: isDark,
                        label: s.homeParMonthlyExpense,
                        amount: _formatAmount(expenseMinor),
                        icon: Icons.arrow_downward_rounded,
                        iconBgColor: AppTheme.dangerSurface,
                        iconColor: AppTheme.redAlert,
                        textColor: textColor,
                        mutedColor: mutedColor,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _MetricColumn(
                        isDark: isDark,
                        label: s.homeParMonthlyIncome,
                        amount: _formatAmount(incomeMinor),
                        icon: Icons.arrow_upward_rounded,
                        iconBgColor: AppTheme.successSurface,
                        iconColor: AppTheme.greenBright,
                        textColor: textColor,
                        mutedColor: mutedColor,
                      ),
                    ),
                  ],
                ),
                if (incomeMinor > 0) ...[
                  SizedBox(height: 20.h),
                  _SpendingProgressBar(
                    expenseMinor: expenseMinor,
                    incomeMinor: incomeMinor,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    s.homeParSpentPercent(
                      (expenseMinor / incomeMinor * 100)
                          .clamp(0, 999)
                          .toStringAsFixed(1),
                    ),
                    style: context.typo.caption.big.copyWith(color: mutedColor),
                  ),
                ],
              ],
            ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.isDark,
    required this.textColor,
    required this.mutedColor,
    required this.label,
    required this.actionLabel,
    this.onAction,
  });

  final bool isDark;
  final Color textColor;
  final Color mutedColor;
  final String label;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: context.typo.body.big.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onAction,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                actionLabel,
                style: context.typo.body.small.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primary,
                ),
              ),
              SizedBox(width: 2.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16.r,
                color: AppTheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricColumn extends StatelessWidget {
  const _MetricColumn({
    required this.isDark,
    required this.label,
    required this.amount,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.textColor,
    required this.mutedColor,
  });

  final bool isDark;
  final String label;
  final String amount;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14.r, color: iconColor),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: context.typo.body.small.copyWith(
              fontWeight: FontWeight.w500,
              color: mutedColor,
            ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          amount,
          style: context.typo.title.medium.copyWith(
          color: textColor,
        ),
        ),
      ],
    );
  }
}

class _SpendingProgressBar extends StatelessWidget {
  const _SpendingProgressBar({
    required this.expenseMinor,
    required this.incomeMinor,
  });

  final int expenseMinor;
  final int incomeMinor;

  @override
  Widget build(BuildContext context) {
    final ratio = (expenseMinor / incomeMinor).clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: SizedBox(
        height: 8.h,
        child: Row(
          children: [
            if (ratio > 0)
              Expanded(
                flex: (ratio * 1000).toInt(),
                child: Container(color: AppTheme.redAlert),
              ),
            if (ratio < 1.0)
              Expanded(
                flex: ((1.0 - ratio) * 1000).toInt(),
                child: Container(color: AppTheme.greenBright),
              ),
          ],
        ),
      ),
    );
  }
}

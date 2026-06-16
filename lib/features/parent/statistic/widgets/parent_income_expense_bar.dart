import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

const _expenseGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFFFF5252), Color(0xFFD32F2F)],
);

class ParentIncomeExpenseBar extends StatelessWidget {
  const ParentIncomeExpenseBar({
    super.key,
    required this.isDark,
    required this.totalIncomeMinor,
    required this.totalExpenseMinor,
  });

  final bool isDark;
  final int totalIncomeMinor;
  final int totalExpenseMinor;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final total = totalIncomeMinor + totalExpenseMinor;
    final incomeRatio = total == 0 ? 0.5 : totalIncomeMinor / total;
    final expenseRatio = total == 0 ? 0.5 : totalExpenseMinor / total;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: isDark
                  ? AppTheme.borderDark
                  : Colors.white.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: isDark ? 0.0 : 0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.parentStatisticBalanceTitle,
                style: context.typo.body.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 14.h),
              _BarRow(
                label: s.parentStatisticBalanceIncome,
                amountMinor: totalIncomeMinor,
                ratio: incomeRatio,
                dotColor: AppTheme.primaryButtonGradientTop,
                gradient: AppTheme.primaryButtonGradient,
                isDark: isDark,
              ),
              SizedBox(height: 10.h),
              _BarRow(
                label: s.parentStatisticBalanceExpense,
                amountMinor: totalExpenseMinor,
                ratio: expenseRatio,
                dotColor: AppTheme.redAlert,
                gradient: _expenseGradient,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  const _BarRow({
    required this.label,
    required this.amountMinor,
    required this.ratio,
    required this.dotColor,
    required this.gradient,
    required this.isDark,
  });

  final String label;
  final int amountMinor;
  final double ratio;
  final Color dotColor;
  final Gradient gradient;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor =
        isDark ? AppTheme.textMuted : AppTheme.textBlack.withValues(alpha: 0.45);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.r,
              height: 8.r,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: context.typo.caption.small.copyWith(
                  color: mutedColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Text(
              context.formatStatisticCompactCurrency(amountMinor),
              style: context.typo.body.medium.copyWith(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(999.r),
          child: Container(
            height: 8.h,
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
            child: TweenAnimationBuilder<double>(
              key: ValueKey(amountMinor),
              tween: Tween(begin: 0.0, end: ratio),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (_, t, __) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: t,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

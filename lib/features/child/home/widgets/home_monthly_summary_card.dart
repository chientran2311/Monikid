import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';

class HomeMonthlySummaryCard extends StatelessWidget {
  const HomeMonthlySummaryCard({
    super.key,
    required this.monthlyExpense,
    required this.limitAmount,
    required this.remainingBudget,
    required this.transactionCount,
    required this.isLimitConfigured,
    required this.todayTransactionCount,
    required this.topCategoryLabel,
    required this.topCategoryAmount,
  });

  final double monthlyExpense;
  final double? limitAmount;
  final double? remainingBudget;
  final int transactionCount;
  final bool isLimitConfigured;
  final int todayTransactionCount;
  final String? topCategoryLabel;
  final double? topCategoryAmount;

  int get _usedPercent {
    if (!isLimitConfigured || limitAmount == null || limitAmount! <= 0) return 0;
    return ((monthlyExpense / limitAmount!) * 100).round().clamp(0, 999);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final now = DateTime.now();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 20.h),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.6, -1),
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Color.lerp(AppTheme.surfaceDark, AppTheme.primary, 0.18)!,
                  AppTheme.surfaceDark,
                ]
              : [
                  Color.lerp(Colors.white, AppTheme.primary, 0.16)!,
                  Colors.white,
                ],
        ),
        border: Border.all(
          color: isDark
              ? AppTheme.darkBorder
              : Color.lerp(Colors.white, AppTheme.primary, 0.14)!,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.10),
            blurRadius: 32.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderRow(month: now.month),
              SizedBox(height: 14.h),
              _AmountRow(
                monthlyExpense: monthlyExpense,
                remainingBudget: remainingBudget,
                isLimitConfigured: isLimitConfigured,
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: s.homeStudentSetMonthlyLimit.toUpperCase(),
                      value: isLimitConfigured && limitAmount != null
                          ? CurrencyFormatter.format(limitAmount!)
                          : 'N/A',
                      subtitle: isLimitConfigured
                          ? s.homeStudentUsedPercent(_usedPercent)
                          : null,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _StatCard(
                      label: s.homeStudentTransactionsLabel.toUpperCase(),
                      value: s.homeStudentTransactionCountLabel(transactionCount),
                      subtitle: s.homeStudentTodayTransactionsSub(todayTransactionCount),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _StatCard(
                      label: s.homeStudentTopCategoryLabel.toUpperCase(),
                      value: topCategoryLabel ?? 'N/A',
                      subtitle: topCategoryAmount != null
                          ? CurrencyFormatter.format(topCategoryAmount!)
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.month});

  final int month;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.homeStudentSummaryEyebrow.toUpperCase(),
                style: context.typo.caption.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Color.lerp(AppTheme.textGrey, AppTheme.primary, 0.60),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                s.homeStudentSummaryTitle(month),
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.titleMedium,
                  weight: FontWeight.w800,
                  color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            border: Border.all(
              color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
            ),
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            s.homeStudentMonthPill(month),
            style: AppTextStyleFactory.style(
              size: AppFontSizes.labelSmall,
              weight: FontWeight.w800,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.monthlyExpense,
    required this.remainingBudget,
    required this.isLimitConfigured,
  });

  final double monthlyExpense;
  final double? remainingBudget;
  final bool isLimitConfigured;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    return Wrap(
      spacing: 10.w,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          CurrencyFormatter.format(monthlyExpense),
          style: AppTextStyleFactory.style(
            size: 38,
            weight: FontWeight.w900,
            color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
            letterSpacing: -1.5,
          ),
        ),
        if (isLimitConfigured && remainingBudget != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Text(
              s.homeStudentRemainingAmount(CurrencyFormatter.format(remainingBudget!)),
              style: AppTextStyleFactory.style(
                size: AppFontSizes.labelSmall,
                weight: FontWeight.w800,
                color: AppTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    this.subtitle,
  });

  final String label;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.68),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Color.lerp(Colors.white, AppTheme.primary, 0.12)!,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.typo.caption.small.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppTheme.darkTextSecondary
                  : Color.lerp(AppTheme.textGrey, AppTheme.primary, 0.55),
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.labelBig,
              weight: FontWeight.w800,
              color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
              letterSpacing: -0.4,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typo.caption.small.copyWith(
                color: Color.lerp(AppTheme.textGrey, AppTheme.primary, 0.40),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';

class SummaryCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final DateTime? selectedDate;
  final DateTime? displayMonth;

  const SummaryCard({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
    this.selectedDate,
    this.displayMonth,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final month = displayMonth ?? DateTime.now();
    final monthLabel = selectedDate != null
        ? 'Ngày ${DateFormat('dd/MM/yyyy').format(selectedDate!)}'
        : 'Tháng ${month.month} / ${month.year}';

    if (isDark) {
      return _DarkSummaryCard(
        totalIncome: totalIncome,
        totalExpense: totalExpense,
        monthLabel: monthLabel,
      );
    }

    return _LightSummaryCard(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      monthLabel: monthLabel,
    );
  }
}

// ── Light mode card (glassmorphism from HTML) ────────────────────────────────

class _LightSummaryCard extends StatelessWidget {
  const _LightSummaryCard({
    required this.totalIncome,
    required this.totalExpense,
    required this.monthLabel,
  });

  final double totalIncome;
  final double totalExpense;
  final String monthLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.lerp(AppTheme.primary, Colors.white, 0.84)!,
                Colors.white.withValues(alpha: 0.94),
              ],
            ),
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.16),
            ),
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.10),
                blurRadius: 60.r,
                offset: Offset(0, 24.h),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Decorative radial gradient circle (CSS ::before pseudo-element)
              Positioned(
                right: -70.w,
                top: -88.h,
                child: Container(
                  width: 210.w,
                  height: 210.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.primary.withValues(alpha: 0.18),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.68],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryHeader(monthLabel: monthLabel),
                  SizedBox(height: 14.h),
                  _SummaryMainAmount(totalExpense: totalExpense),
                  SizedBox(height: 14.h),
                  _SummaryStats(
                    totalIncome: totalIncome,
                    totalExpense: totalExpense,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.monthLabel});
  final String monthLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tổng quan giao dịch',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.captionBig,
                weight: FontWeight.w800,
                color: AppTheme.textGrey,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              monthLabel,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.titleMedium,
                weight: FontWeight.w700,
                letterSpacing: -0.03 * AppFontSizes.titleMedium,
                color: AppTheme.textBlack,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryMainAmount extends StatelessWidget {
  const _SummaryMainAmount({required this.totalExpense});
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            CurrencyFormatter.format(totalExpense),
            style: AppTextStyleFactory.style(
              size: 34,
              weight: FontWeight.w900,
              letterSpacing: -0.05 * 34,
              color: AppTheme.textBlack,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 10.w),
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Text(
              'Đã chi tháng này',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.captionBig,
                weight: FontWeight.w800,
                color: AppTheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryStats extends StatelessWidget {
  const _SummaryStats({
    required this.totalIncome,
    required this.totalExpense,
  });

  final double totalIncome;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    final netBalance = totalIncome - totalExpense;
    final isNet = netBalance >= 0;
    return Row(
      children: [
        Expanded(
          child: _StatBox(
            label: 'Thu tiền',
            value: CurrencyFormatter.formatCompact(totalIncome),
            valueColor: const Color(0xFF23815E),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _StatBox(
            label: 'Chi tiền',
            value: CurrencyFormatter.formatCompact(totalExpense),
            valueColor: AppTheme.redAlert,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _StatBox(
            label: 'Số dư',
            value: '${isNet ? '+' : ''}${CurrencyFormatter.formatCompact(netBalance)}',
            valueColor: isNet ? AppTheme.primary : AppTheme.redAlert,
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.12),
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.captionSmall,
              weight: FontWeight.w700,
              color: AppTheme.textGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.bodyMedium,
              weight: FontWeight.w900,
              letterSpacing: -0.02 * AppFontSizes.bodyMedium,
              color: valueColor ?? AppTheme.textBlack,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Dark mode card (gradient — unchanged) ────────────────────────────────────

class _DarkSummaryCard extends StatelessWidget {
  const _DarkSummaryCard({
    required this.totalIncome,
    required this.totalExpense,
    required this.monthLabel,
  });

  final double totalIncome;
  final double totalExpense;
  final String monthLabel;

  @override
  Widget build(BuildContext context) {
    final double netBalance = totalIncome - totalExpense;
    final bool isPositive = netBalance >= 0;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF1E5222)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.2),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthLabel.toUpperCase(),
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                  color: AppTheme.surfaceLightGreen,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20.r,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${isPositive ? '+' : '-'} ${CurrencyFormatter.format(netBalance.abs())}',
            style: context.typo.headline.medium.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: isPositive ? Colors.white : AppTheme.redAlert,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _DarkBadge(
                  icon: Icons.arrow_downward,
                  label: 'Chi: ${CurrencyFormatter.formatCompact(totalExpense)}',
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _DarkBadge(
                  icon: Icons.arrow_upward,
                  label: 'Thu: ${CurrencyFormatter.formatCompact(totalIncome)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DarkBadge extends StatelessWidget {
  const _DarkBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: Colors.white),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              label,
              style: context.typo.caption.big.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

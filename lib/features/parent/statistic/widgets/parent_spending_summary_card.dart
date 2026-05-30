import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';

class ParentSpendingSummaryCard extends StatelessWidget {
  const ParentSpendingSummaryCard({
    super.key,
    required this.isDark,
    required this.totalAmountLabel,
    required this.percentChange,
    required this.trendDirection,
  });

  final bool isDark;
  final String totalAmountLabel;
  final double percentChange;
  final StatisticTrendDirection trendDirection;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.0 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppTheme.primary,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                s.parentStatisticTotalSpentTitle,
                style: context.typo.body.medium.copyWith(
                fontWeight: FontWeight.w500,
                color: mutedColor,
              ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            totalAmountLabel,
            style: context.typo.display.medium.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
          ),
          SizedBox(height: 8.h),
          _TrendBadge(
            isDark: isDark,
            percentChange: percentChange,
            trendDirection: trendDirection,
            vsLabel: s.parentStatisticVsLastMonth,
          ),
        ],
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  const _TrendBadge({
    required this.isDark,
    required this.percentChange,
    required this.trendDirection,
    required this.vsLabel,
  });

  final bool isDark;
  final double percentChange;
  final StatisticTrendDirection trendDirection;
  final String vsLabel;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;

    final Color badgeColor;
    final Color textColor;
    final String label;

    switch (trendDirection) {
      case StatisticTrendDirection.up:
        badgeColor = AppTheme.dangerSurface;
        textColor = AppTheme.redAlert;
        label = s.parentStatisticSpendingUp(percentChange.toStringAsFixed(1));
      case StatisticTrendDirection.down:
        badgeColor = AppTheme.successSurface;
        textColor = AppTheme.chartGreen;
        label = s.parentStatisticSpendingDown(
          percentChange.abs().toStringAsFixed(1),
        );
      case StatisticTrendDirection.stable:
      case StatisticTrendDirection.none:
        badgeColor = isDark ? AppTheme.backgroundDark : AppTheme.surfaceGrey;
        textColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
        label = s.parentStatisticSpendingStable;
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            label,
            style: context.typo.caption.big.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          vsLabel,
          style: context.typo.caption.big.copyWith(
          color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
        ),
        ),
      ],
    );
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class ParentStatInsightsRow extends StatelessWidget {
  const ParentStatInsightsRow({
    super.key,
    required this.isDark,
    required this.avgPerDayMinor,
    required this.peakDay,
    required this.streak,
  });

  final bool isDark;
  final int avgPerDayMinor;
  final StatisticDailyExpenseData? peakDay;
  final int streak;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final peakAmountStr = peakDay == null
        ? s.parentStatisticInsightsNoPeak
        : context.formatStatisticCompactCurrency(peakDay!.amountMinor);
    final peakDateStr = peakDay == null
        ? null
        : DateFormat('dd/MM').format(peakDay!.date);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _InsightChip(
              isDark: isDark,
              icon: '📅',
              label: s.parentStatisticInsightsAvgPerDay,
              value: context.formatStatisticCompactCurrency(avgPerDayMinor),
              subValue: null,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _InsightChip(
              isDark: isDark,
              icon: '🔥',
              label: s.parentStatisticInsightsPeakDay,
              value: peakAmountStr,
              subValue: peakDateStr,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _InsightChip(
              isDark: isDark,
              icon: '⚡',
              label: s.parentStatisticInsightsStreak,
              value: s.parentStatisticInsightsStreakDays(streak),
              subValue: null,
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightChip extends StatelessWidget {
  const _InsightChip({
    required this.isDark,
    required this.icon,
    required this.label,
    required this.value,
    this.subValue,
  });

  final bool isDark;
  final String icon;
  final String label;
  final String value;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor =
        isDark ? AppTheme.textMuted : AppTheme.textBlack.withValues(alpha: 0.45);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20.r),
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
              Text(icon, style: TextStyle(fontSize: 20.sp)),
              SizedBox(height: 8.h),
              Text(
                label,
                style: context.typo.caption.small.copyWith(
                  color: mutedColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: context.typo.body.medium.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subValue != null) ...[
                SizedBox(height: 1.h),
                Text(
                  subValue!,
                  style: context.typo.caption.small.copyWith(
                    color: mutedColor,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

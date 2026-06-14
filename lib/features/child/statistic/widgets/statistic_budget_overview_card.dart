import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class StatisticBudgetOverviewCard extends StatelessWidget {
  const StatisticBudgetOverviewCard({
    super.key,
    required this.budgetOverview,
    required this.comparisonMessage,
    required this.onSetupLimit,
  });

  final StatisticBudgetOverview? budgetOverview;
  final String comparisonMessage;
  final VoidCallback onSetupLimit;

  @override
  Widget build(BuildContext context) {
    if (budgetOverview == null ||
        budgetOverview!.status == StatisticBudgetStatus.noLimit ||
        budgetOverview!.limitMinor == null) {
      return _NoLimitCard(onSetupLimit: onSetupLimit);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final overview = budgetOverview!;
    final limitMinor = overview.limitMinor ?? 0;
    final remainingMinor = (overview.remainingMinor ?? 0).clamp(0, limitMinor);
    final usagePercent = (overview.usageRatio * 100).clamp(0.0, 100.0);
    final statusLabel = context.statisticBudgetStatusLabel(overview.status);
    final statusColor = _statusColor(overview.status);
    final statusSurface = _statusSurface(overview.status, isDark);
    final progressBarBg = isDark ? const Color(0xFF1C3322) : const Color(0xFFEAF1EA);

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: isDark ? AppTheme.borderDark : AppTheme.borderLight),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
          BoxShadow(
            color: Color(0x0A111811),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.statisticSpendingLimitLabel,
                      style: context.typo.caption.medium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textGrey,
                        letterSpacing: 0.1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Flexible(
                          child: Text(
                            context.formatStatisticCompactCurrency(overview.spentMinor),
                            overflow: TextOverflow.ellipsis,
                            style: context.typo.display.small.copyWith(
                              fontWeight: FontWeight.w800,
                              color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
                              letterSpacing: -1.2,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            '/ ${context.formatStatisticCurrency(limitMinor)}',
                            overflow: TextOverflow.ellipsis,
                            style: context.typo.body.small.copyWith(
                              color: AppTheme.textGrey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: statusSurface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Text(
                    statusLabel,
                    style: context.typo.caption.small.copyWith(
                      fontWeight: FontWeight.w800,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.statisticProgressUsageLabel,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textGrey,
                ),
              ),
              Text(
                '${usagePercent.toStringAsFixed(0)}%',
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: Container(
              height: 12.h,
              color: progressBarBg,
              child: FractionallySizedBox(
                widthFactor: overview.usageRatio.clamp(0.0, 1.0),
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: overview.status == StatisticBudgetStatus.exceeded
                          ? [AppTheme.redAlert, AppTheme.redAlert]
                          : [AppTheme.primary, AppTheme.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(999.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.22),
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${context.l10n.statisticRemainingLabel} ${context.formatStatisticCurrency(remainingMinor)}',
                style: context.typo.caption.medium.copyWith(
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Flexible(
                child: Text(
                  context.l10n.statisticBudgetAdjustAnytime,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.caption.small.copyWith(
                    color: AppTheme.textGrey,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(StatisticBudgetStatus status) {
    switch (status) {
      case StatisticBudgetStatus.onTrack:
        return AppTheme.primary;
      case StatisticBudgetStatus.warning:
        return AppTheme.amberText;
      case StatisticBudgetStatus.exceeded:
        return AppTheme.redAlert;
      case StatisticBudgetStatus.noLimit:
        return AppTheme.primary;
    }
  }

  Color _statusSurface(StatisticBudgetStatus status, bool isDark) {
    switch (status) {
      case StatisticBudgetStatus.onTrack:
        return isDark ? AppTheme.darkSuccessSurface : AppTheme.successSurface;
      case StatisticBudgetStatus.warning:
        return isDark ? AppTheme.darkWarningSurface : AppTheme.amberSurface;
      case StatisticBudgetStatus.exceeded:
        return isDark ? AppTheme.darkDangerSurface : AppTheme.dangerSurface;
      case StatisticBudgetStatus.noLimit:
        return isDark ? AppTheme.darkPrimaryContainer : AppTheme.primaryLight;
    }
  }
}

class _NoLimitCard extends StatelessWidget {
  const _NoLimitCard({required this.onSetupLimit});

  final VoidCallback onSetupLimit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.darkPrimaryContainer : AppTheme.primaryLight;
    final textColor = isDark ? AppTheme.darkPrimaryAccent : AppTheme.primaryDark;
    final borderColor = isDark ? AppTheme.darkSuccessBorder : AppTheme.successBorder;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.statisticBudgetNoLimitTitle,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.statisticBudgetNoLimitDescription,
            style: context.typo.body.small.copyWith(
              height: 1.5,
              color: textColor,
            ),
          ),
          SizedBox(height: 18.h),
          FilledButton(
            onPressed: onSetupLimit,
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            ),
            child: Text(
              context.l10n.homeStudentSetMonthlyLimit,
              style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

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

    final overview = budgetOverview!;
    final limitMinor = overview.limitMinor ?? 0;
    final remainingMinor = (overview.remainingMinor ?? 0).clamp(0, limitMinor);
    final usagePercent = (overview.usageRatio * 100).clamp(0.0, 100.0);
    final statusLabel = context.statisticBudgetStatusLabel(overview.status);
    final statusColor = _statusColor(overview.status);
    final statusSurface = _statusSurface(overview.status);

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: AppTheme.borderLight),
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
                        Text(
                          context.formatStatisticCompactCurrency(overview.spentMinor),
                          style: context.typo.display.small.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textBlack,
                            letterSpacing: -1.2,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '/ ${context.formatStatisticCurrency(limitMinor)}',
                          style: context.typo.body.small.copyWith(
                            color: AppTheme.textGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
              color: const Color(0xFFEAF1EA),
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

  Color _statusSurface(StatisticBudgetStatus status) {
    switch (status) {
      case StatisticBudgetStatus.onTrack:
        return AppTheme.successSurface;
      case StatisticBudgetStatus.warning:
        return AppTheme.amberSurface;
      case StatisticBudgetStatus.exceeded:
        return AppTheme.dangerSurface;
      case StatisticBudgetStatus.noLimit:
        return AppTheme.primaryLight;
    }
  }
}

class _NoLimitCard extends StatelessWidget {
  const _NoLimitCard({required this.onSetupLimit});

  final VoidCallback onSetupLimit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppTheme.successBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.statisticBudgetNoLimitTitle,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryDark,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.statisticBudgetNoLimitDescription,
            style: context.typo.body.small.copyWith(
              height: 1.5,
              color: AppTheme.primaryDark,
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

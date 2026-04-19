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
    final remainingMinor = overview.remainingMinor ?? 0;
    final statusLabel = context.statisticBudgetStatusLabel(overview.status);

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x24000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -36.h,
            right: -36.w,
            child: Container(
              width: 132.w,
              height: 132.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -28.w,
            bottom: -40.h,
            child: Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: AppTheme.chartGreen.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
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
                          context.l10n.statisticSpendingLimitLabel.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.r,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          context.formatStatisticCurrency(limitMinor),
                          style: TextStyle(
                            fontSize: 30.r,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 9.r,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: _BudgetMetric(
                      label: context.l10n.statisticSpentLabel,
                      value: context.formatStatisticCurrency(overview.spentMinor),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _BudgetMetric(
                      label: context.l10n.statisticRemainingLabel,
                      value: context.formatStatisticCurrency(
                        remainingMinor.clamp(0, limitMinor),
                      ),
                      alignEnd: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(999.r),
                child: LinearProgressIndicator(
                  minHeight: 8.h,
                  value: overview.usageRatio.clamp(0.0, 1.0),
                  backgroundColor: Colors.black.withValues(alpha: 0.20),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    overview.status == StatisticBudgetStatus.exceeded
                        ? AppTheme.redAlert
                        : AppTheme.chartGreen,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _comparisonIcon(overview.comparisonDirection),
                      size: 16.r,
                      color: _comparisonColor(overview.comparisonDirection),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        comparisonMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.r,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.86),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _comparisonIcon(StatisticTrendDirection direction) {
    switch (direction) {
      case StatisticTrendDirection.down:
        return Icons.trending_down_rounded;
      case StatisticTrendDirection.up:
        return Icons.trending_up_rounded;
      case StatisticTrendDirection.stable:
      case StatisticTrendDirection.none:
        return Icons.remove_rounded;
    }
  }

  Color _comparisonColor(StatisticTrendDirection direction) {
    switch (direction) {
      case StatisticTrendDirection.down:
        return AppTheme.chartGreen;
      case StatisticTrendDirection.up:
        return AppTheme.redAlert;
      case StatisticTrendDirection.stable:
      case StatisticTrendDirection.none:
        return Colors.white;
    }
  }
}

class _NoLimitCard extends StatelessWidget {
  const _NoLimitCard({
    required this.onSetupLimit,
  });

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
            style: TextStyle(
              fontSize: 20.r,
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryDark,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.statisticBudgetNoLimitDescription,
            style: TextStyle(
              fontSize: 13.r,
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
              style: TextStyle(
                fontSize: 14.r,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetMetric extends StatelessWidget {
  const _BudgetMetric({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 9.r,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Colors.white.withValues(alpha: 0.64),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.r,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

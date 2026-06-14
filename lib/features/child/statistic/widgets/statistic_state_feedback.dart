import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class StatisticErrorCard extends StatelessWidget {
  const StatisticErrorCard({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkDangerSurface : AppTheme.dangerSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppTheme.dangerBorder),
      ),
      child: Column(
        children: [
          Text(
            context.l10n.errorGeneric(message),
            textAlign: TextAlign.center,
            style: context.typo.body.small.copyWith(fontWeight: FontWeight.w600, color: AppTheme.redAlert),
          ),
          SizedBox(height: 12.h),
          FilledButton(
            onPressed: onRetry,
            child: Text(context.l10n.actionRetry),
          ),
        ],
      ),
    );
  }
}

class StatisticEmptyCard extends StatelessWidget {
  const StatisticEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: isDark ? AppTheme.darkBorder : AppTheme.surfaceGrey),
      ),
      child: Column(
        children: [
          Icon(
            Icons.insights_rounded,
            size: 34.r,
            color: AppTheme.primary,
          ),
          SizedBox(height: 12.h),
          Text(
            context.l10n.statisticNoDataTitle,
            textAlign: TextAlign.center,
            style: context.typo.subtitle.medium.copyWith(fontWeight: FontWeight.w800, color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.statisticNoDataDescription,
            textAlign: TextAlign.center,
            style: context.typo.body.small.copyWith(height: 1.5, color: AppTheme.textGrey),
          ),
        ],
      ),
    );
  }
}

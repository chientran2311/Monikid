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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppTheme.dangerSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppTheme.dangerBorder),
      ),
      child: Column(
        children: [
          Text(
            context.l10n.errorGeneric(message),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.r,
              fontWeight: FontWeight.w600,
              color: AppTheme.redAlert,
            ),
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
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
            style: TextStyle(
              fontSize: 18.r,
              fontWeight: FontWeight.w800,
              color: AppTheme.textBlack,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.statisticNoDataDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.r,
              height: 1.5,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

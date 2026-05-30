import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class StatisticSmartInsightCard extends StatelessWidget {
  const StatisticSmartInsightCard({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7FBF7), AppTheme.primaryLight],
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.10),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: context.typo.title.medium.copyWith(
                fontWeight: FontWeight.w900,
                color: AppTheme.primary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.statisticAlertTitle,
                  style: context.typo.body.medium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textBlack,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
                  style: context.typo.caption.big.copyWith(
                    color: AppTheme.textGrey,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.10),
              ),
            ),
            child: Text(
              context.l10n.statisticAlertPriority,
              style: context.typo.caption.small.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

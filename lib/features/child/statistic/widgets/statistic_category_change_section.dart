import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';

class StatisticCategoryChangeSection extends StatelessWidget {
  const StatisticCategoryChangeSection({
    super.key,
    required this.strongestIncrease,
    required this.strongestDecrease,
  });

  final StatisticInsightData? strongestIncrease;
  final StatisticInsightData? strongestDecrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ChangeInsightTile(
            title: context.l10n.statisticStrongestIncrease,
            insight: strongestIncrease,
            borderColor: AppTheme.redAlert,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _ChangeInsightTile(
            title: context.l10n.statisticStrongestDecrease,
            insight: strongestDecrease,
            borderColor: AppTheme.chartGreen,
          ),
        ),
      ],
    );
  }
}

class _ChangeInsightTile extends StatelessWidget {
  const _ChangeInsightTile({
    required this.title,
    required this.insight,
    required this.borderColor,
  });

  final String title;
  final StatisticInsightData? insight;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border(left: BorderSide(color: borderColor, width: 4.w)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 10.r,
              fontWeight: FontWeight.w800,
              color: AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 10.h),
          if (insight == null)
            Text(
              context.l10n.statisticNoCategoryChange,
              style: TextStyle(
                fontSize: 13.r,
                fontWeight: FontWeight.w600,
                color: AppTheme.textBlack,
              ),
            )
          else
            Row(
              children: [
                Text(
                  insight!.categoryIcon ?? '•',
                  style: TextStyle(fontSize: 20.r),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    insight!.categoryLabel,
                    style: TextStyle(
                      fontSize: 13.r,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textBlack,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

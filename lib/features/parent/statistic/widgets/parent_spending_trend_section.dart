import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';

class ParentSpendingTrendSection extends StatelessWidget {
  const ParentSpendingTrendSection({
    super.key,
    required this.isDark,
    required this.period,
  });

  final bool isDark;
  final ParentStatisticPeriod period;

  static const _weekDayHeights = [0.40, 0.65, 0.30, 0.85, 0.10, 0.50, 0.25];
  static const _monthWeekHeights = [0.55, 0.70, 0.45, 0.60];

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final barBg = isDark ? AppTheme.borderDark : const Color(0xFFF4F4F5);

    final isWeek = period == ParentStatisticPeriod.week;
    final heights = isWeek ? _weekDayHeights : _monthWeekHeights;
    final labels = isWeek
        ? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
        : ['W1', 'W2', 'W3', 'W4'];
    final highlightIndex = isWeek ? 3 : 1;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 0.5),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  s.parentStatisticTrendTitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_downward_rounded,
                        size: 12.r, color: AppTheme.primary),
                    SizedBox(width: 2.w),
                    Text(
                      '12%',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 100.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(heights.length, (i) {
                final isHighlight = i == highlightIndex;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: FractionallySizedBox(
                      heightFactor: heights[i],
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHighlight ? AppTheme.primary : barBg,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: borderColor),
          SizedBox(height: 6.h),
          Row(
            children: List.generate(labels.length, (i) {
              final isHighlight = i == highlightIndex;
              return Expanded(
                child: Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight:
                        isHighlight ? FontWeight.w700 : FontWeight.w400,
                    color: isHighlight ? textColor : mutedColor,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';

class ParentPeriodSegmentedControl extends StatelessWidget {
  const ParentPeriodSegmentedControl({
    required this.isDark,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final bool isDark;
  final ParentStatisticPeriod selected;
  final ValueChanged<ParentStatisticPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final bgColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLightGrey;
    final activeColor = isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight;
    final inactiveTextColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final activeTextColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;

    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: ParentStatisticPeriod.values.map((period) {
          final isActive = selected == period;
          final label = switch (period) {
            ParentStatisticPeriod.week => s.parentStatisticWeek,
            ParentStatisticPeriod.month => s.parentStatisticMonth,
            ParentStatisticPeriod.year => s.parentStatisticYear,
          };
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  color: isActive ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: context.typo.caption.big.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isActive ? activeTextColor : inactiveTextColor,
                ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

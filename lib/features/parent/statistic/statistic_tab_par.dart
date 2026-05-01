import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_provider.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_budget_overview_card.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_spending_trend_section.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_top_categories_section.dart';
import 'package:monikid/shared/widgets/main_app_bar.dart';

class StatisticTabParent extends ConsumerWidget {
  const StatisticTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(parentStatisticProvider);
    final notifier = ref.read(parentStatisticProvider.notifier);

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: const MainAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        children: [
          _PeriodSegmentedControl(
            isDark: isDark,
            selected: state.period,
            onChanged: notifier.setPeriod,
          ),
          SizedBox(height: 20.h),
          Text(
            s.parentStatisticTitle,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppTheme.textBlack,
            ),
          ),
          SizedBox(height: 16.h),
          ParentBudgetOverviewCard(isDark: isDark),
          SizedBox(height: 16.h),
          ParentSpendingTrendSection(isDark: isDark, period: state.period),
          SizedBox(height: 24.h),
          ParentTopCategoriesSection(isDark: isDark),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _PeriodSegmentedControl extends StatelessWidget {
  const _PeriodSegmentedControl({
    required this.isDark,
    required this.selected,
    required this.onChanged,
  });

  final bool isDark;
  final ParentStatisticPeriod selected;
  final ValueChanged<ParentStatisticPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final bgColor = isDark ? AppTheme.surfaceDark : const Color(0xFFE4E4E7);
    final activeColor = isDark ? AppTheme.backgroundDark : Colors.white;
    final inactiveTextColor =
        isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final activeTextColor = isDark ? Colors.white : AppTheme.textBlack;

    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: ParentStatisticPeriod.values.map((period) {
          final isActive = selected == period;
          final label = period == ParentStatisticPeriod.week
              ? s.parentStatisticWeek
              : s.parentStatisticMonth;
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
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w400,
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';

class ParentSpendingHeatmapSection extends StatelessWidget {
  const ParentSpendingHeatmapSection({
    super.key,
    required this.isDark,
    required this.dailyData,
    required this.period,
    required this.selectedDate,
  });

  final bool isDark;
  final List<StatisticDailyExpenseData> dailyData;
  final ParentStatisticPeriod period;
  final DateTime selectedDate;

  List<StatisticDailyExpenseData?> _buildCells() {
    switch (period) {
      case ParentStatisticPeriod.week:
        final mon =
            selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        return List.generate(7, (i) {
          final day = DateTime(mon.year, mon.month, mon.day + i);
          return dailyData
              .where((d) =>
                  d.date.year == day.year &&
                  d.date.month == day.month &&
                  d.date.day == day.day)
              .firstOrNull;
        });

      case ParentStatisticPeriod.month:
        final first =
            DateTime(selectedDate.year, selectedDate.month, 1);
        final prefixNulls = first.weekday - 1;
        final daysInMonth =
            DateTime(first.year, first.month + 1, 0).day;
        final cells = <StatisticDailyExpenseData?>[
          ...List.filled(prefixNulls, null),
          ...List.generate(daysInMonth, (i) {
            final day = DateTime(first.year, first.month, i + 1);
            return dailyData
                .where((d) =>
                    d.date.year == day.year &&
                    d.date.month == day.month &&
                    d.date.day == day.day)
                .firstOrNull;
          }),
        ];
        while (cells.length % 7 != 0) {
          cells.add(null);
        }
        return cells;

      case ParentStatisticPeriod.year:
        return List.generate(12, (m) {
          final monthData = dailyData.where((d) =>
              d.date.year == selectedDate.year && d.date.month == m + 1);
          if (monthData.isEmpty) return null;
          final total = monthData.fold(0, (s, d) => s + d.amountMinor);
          return StatisticDailyExpenseData(
            date: DateTime(selectedDate.year, m + 1, 1),
            amountMinor: total,
          );
        });
    }
  }

  int get _maxAmount {
    final nonNull = dailyData.where((d) => d.amountMinor > 0);
    if (nonNull.isEmpty) return 1;
    return nonNull.map((d) => d.amountMinor).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: isDark
                  ? AppTheme.borderDark
                  : Colors.white.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: isDark ? 0.0 : 0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.parentStatisticHeatmapTitle,
                    style: context.typo.body.medium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppTheme.textBlack,
                      fontSize: 14.sp,
                    ),
                  ),
                  _LegendRow(isDark: isDark),
                ],
              ),
              SizedBox(height: 14.h),
              if (dailyData.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      s.parentStatisticHeatmapNoData,
                      style: context.typo.caption.small.copyWith(
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ),
                )
              else
                _HeatmapGrid(
                  isDark: isDark,
                  cells: _buildCells(),
                  maxAmount: _maxAmount,
                  period: period,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _heatColor(int amount, int maxAmount, bool isDark) {
  if (amount <= 0 || maxAmount <= 0) {
    return AppTheme.textMuted.withValues(alpha: isDark ? 0.15 : 0.12);
  }
  final ratio = amount / maxAmount;
  if (ratio < 0.20) return AppTheme.primary.withValues(alpha: 0.20);
  if (ratio < 0.40) return AppTheme.primary.withValues(alpha: 0.40);
  if (ratio < 0.65) return AppTheme.primary.withValues(alpha: 0.60);
  if (ratio < 0.85) return AppTheme.primary.withValues(alpha: 0.85);
  return AppTheme.accentVibrant;
}

class _HeatmapGrid extends StatefulWidget {
  const _HeatmapGrid({
    required this.isDark,
    required this.cells,
    required this.maxAmount,
    required this.period,
  });

  final bool isDark;
  final List<StatisticDailyExpenseData?> cells;
  final int maxAmount;
  final ParentStatisticPeriod period;

  @override
  State<_HeatmapGrid> createState() => _HeatmapGridState();
}

class _HeatmapGridState extends State<_HeatmapGrid> {
  StatisticDailyExpenseData? _selected;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount =
        widget.period == ParentStatisticPeriod.year ? 4 : 7;

    return Column(
      children: [
        GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4.h,
          crossAxisSpacing: 4.w,
          children: widget.cells.map((entry) {
            final isEmpty = entry == null || entry.amountMinor == 0;
            return GestureDetector(
              onTap: isEmpty
                  ? null
                  : () => setState(() {
                        _selected = _selected == entry ? null : entry;
                      }),
              child: Container(
                decoration: BoxDecoration(
                  color: _heatColor(
                    entry?.amountMinor ?? 0,
                    widget.maxAmount,
                    widget.isDark,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          }).toList(),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _selected == null
              ? const SizedBox.shrink()
              : _TooltipChip(
                  key: ValueKey(_selected!.date),
                  data: _selected!,
                  isDark: widget.isDark,
                  isYearView:
                      widget.period == ParentStatisticPeriod.year,
                ),
        ),
      ],
    );
  }
}

class _TooltipChip extends StatelessWidget {
  const _TooltipChip({
    super.key,
    required this.data,
    required this.isDark,
    required this.isYearView,
  });

  final StatisticDailyExpenseData data;
  final bool isDark;
  final bool isYearView;

  @override
  Widget build(BuildContext context) {
    final dateStr = isYearView
        ? DateFormat('MM/yyyy').format(data.date)
        : DateFormat('dd/MM').format(data.date);
    final amtStr = context.formatStatisticCompactCurrency(data.amountMinor);

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark.withValues(alpha: 0.9)
                : Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(
              color: isDark
                  ? AppTheme.borderDark
                  : Colors.white.withValues(alpha: 0.6),
            ),
          ),
          child: Text(
            '$dateStr  ·  $amtStr',
            style: context.typo.caption.small.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppTheme.textBlack,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final mutedColor =
        isDark ? AppTheme.textMuted : AppTheme.textBlack.withValues(alpha: 0.4);
    const ratios = [0.0, 0.20, 0.45, 0.70, 1.0];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Less',
          style: context.typo.caption.small
              .copyWith(color: mutedColor, fontSize: 9.sp),
        ),
        SizedBox(width: 4.w),
        ...List.generate(5, (i) {
          return Container(
            width: 10.r,
            height: 10.r,
            margin: EdgeInsets.only(right: i < 4 ? 2.w : 0),
            decoration: BoxDecoration(
              color: _heatColor(
                (ratios[i] * 100000).toInt(),
                100000,
                isDark,
              ),
              borderRadius: BorderRadius.circular(2.r),
            ),
          );
        }),
        SizedBox(width: 4.w),
        Text(
          'More',
          style: context.typo.caption.small
              .copyWith(color: mutedColor, fontSize: 9.sp),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';
import 'package:monikid/shared/widgets/done_chip.dart';

class StatisticSpendingTrendSection extends StatefulWidget {
  const StatisticSpendingTrendSection({
    super.key,
    required this.dailyExpenses,
    required this.selectedTabIndex,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final List<StatisticDailyExpenseData> dailyExpenses;
  final int selectedTabIndex;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<StatisticSpendingTrendSection> createState() =>
      _StatisticSpendingTrendSectionState();
}

class _StatisticSpendingTrendSectionState
    extends State<StatisticSpendingTrendSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void didUpdateWidget(StatisticSpendingTrendSection old) {
    super.didUpdateWidget(old);
    if (old.dailyExpenses != widget.dailyExpenses ||
        old.selectedTabIndex != widget.selectedTabIndex) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showPeriodBottomSheet(BuildContext context) async {
    final options = switch (widget.selectedTabIndex) {
      0 => _buildWeekOptions(),
      2 => _buildYearOptions(),
      _ => _buildMonthOptions(),
    };

    final initialIndex = options.indexWhere(
      (d) =>
          d.year == widget.selectedDate.year &&
          d.month == widget.selectedDate.month &&
          d.day == widget.selectedDate.day,
    );

    final result = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _PeriodPickerBottomSheet(
        options: options,
        selectedTabIndex: widget.selectedTabIndex,
        initialIndex: initialIndex < 0 ? 0 : initialIndex,
      ),
    );

    if (result != null) {
      widget.onDateSelected(result);
    }
  }

  List<StatisticDailyExpenseData> _aggregateByQuarter(
    List<StatisticDailyExpenseData> data,
  ) {
    if (data.isEmpty) return [];
    final year = data.first.date.year;
    final totals = [0, 0, 0, 0];
    for (final item in data) {
      totals[(item.date.month - 1) ~/ 3] += item.amountMinor;
    }
    return List.generate(
      4,
      (i) => StatisticDailyExpenseData(
        date: DateTime(year, i * 3 + 1, 1),
        amountMinor: totals[i],
      ),
    );
  }

  List<StatisticDailyExpenseData> _buildPlaceholderExpenses(int tabIndex) {
    final now = DateTime.now();
    return switch (tabIndex) {
      0 => List.generate(
          7,
          (i) => StatisticDailyExpenseData(
            date: DateTime(now.year, now.month, now.day)
                .subtract(Duration(days: now.weekday - 1 - i)),
            amountMinor: 0,
          ),
        ),
      2 => List.generate(
          4,
          (i) => StatisticDailyExpenseData(
            date: DateTime(now.year, i * 3 + 1, 1),
            amountMinor: 0,
          ),
        ),
      _ => List.generate(
          12,
          (i) => StatisticDailyExpenseData(
            date: DateTime(now.year, i + 1, 1),
            amountMinor: 0,
          ),
        ),
    };
  }

  List<DateTime> _buildYearOptions() {
    final now = DateTime.now();
    return List.generate(4, (i) => DateTime(now.year - i, 1, 1));
  }

  List<DateTime> _buildMonthOptions() {
    final now = DateTime.now();
    return List.generate(24, (i) => DateTime(now.year, now.month - i, 1));
  }

  List<DateTime> _buildWeekOptions() {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    return List.generate(20, (i) => monday.subtract(Duration(days: 7 * i)));
  }

  Animation<double> _barAnimation(int index) {
    final start = (0.05 * index).clamp(0.0, 0.5);
    final end = (start + 0.55).clamp(0.0, 1.0);
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final takeCount = switch (widget.selectedTabIndex) {
      0 => 7,
      2 => 365,
      _ => 12,
    };
    final rawExpenses = widget.dailyExpenses.take(takeCount).toList();
    final dailyExpenses = switch (widget.selectedTabIndex) {
      2 => rawExpenses.isNotEmpty
          ? _aggregateByQuarter(rawExpenses)
          : _buildPlaceholderExpenses(2),
      _ => rawExpenses.isNotEmpty
          ? rawExpenses
          : _buildPlaceholderExpenses(widget.selectedTabIndex),
    };
    final maxAmount = dailyExpenses.fold<int>(
      0,
      (v, p) => p.amountMinor > v ? p.amountMinor : v,
    );
    final total =
        dailyExpenses.fold<int>(0, (sum, p) => sum + p.amountMinor);
    final periodLabel = context.statisticPeriodLabel(
      selectedTabIndex: widget.selectedTabIndex,
      anchorDate: widget.selectedDate,
    );
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    // HTML chart-card tokens:
    // bg: linear-gradient(mix(accent 8%, white), rgba(white,.94))
    // border: mix(accent 16%, white)  shadow: 0 24px 60px rgba(47,127,51,.10)
    // radius: 28px
    final borderColor = isDark
        ? AppTheme.borderDark
        : AppTheme.primary.withValues(alpha: 0.16);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        gradient: isDark
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.lerp(AppTheme.primary, Colors.white, 0.92)!,
                  Colors.white.withValues(alpha: 0.94),
                ],
              ),
        color: isDark ? AppTheme.surfaceDark : null,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: isDark ? 0.0 : 0.10),
            blurRadius: 60,
            offset: const Offset(0, 24),
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
                      context.l10n.statisticChartSectionTitle,
                      style: context.typo.caption.medium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textGrey,
                        letterSpacing: 0.1,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.formatStatisticCurrency(total),
                      style: context.typo.title.medium.copyWith(
                        fontWeight: FontWeight.w800,
                        color: textColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              _PeriodPill(
                label: periodLabel,
                onTap: () => _showPeriodBottomSheet(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: _BarChart(
              dailyExpenses: dailyExpenses,
              maxAmount: maxAmount,
              animationOf: _barAnimation,
              selectedTabIndex: widget.selectedTabIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodPickerBottomSheet extends StatefulWidget {
  const _PeriodPickerBottomSheet({
    required this.options,
    required this.selectedTabIndex,
    required this.initialIndex,
  });

  final List<DateTime> options;
  final int selectedTabIndex;
  final int initialIndex;

  @override
  State<_PeriodPickerBottomSheet> createState() =>
      _PeriodPickerBottomSheetState();
}

class _PeriodPickerBottomSheetState extends State<_PeriodPickerBottomSheet> {
  late int _selectedIndex;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _scrollController =
        FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final selectorColor = isDark
        ? AppTheme.borderDark.withValues(alpha: 0.5)
        : const Color(0xFFE8EDF2);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: mutedColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 28.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      context.l10n.statisticSelectPeriodTitle,
                      style:
                          context.typo.subtitle.small.copyWith(color: textColor),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: DoneChip(
                      onTap: () => Navigator.of(context)
                          .pop(widget.options[_selectedIndex]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Divider(height: 1, thickness: 1, color: borderColor),
          SizedBox(
            height: 216.h,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 42.h,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: selectorColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                CupertinoPicker(
                  scrollController: _scrollController,
                  itemExtent: 42.h,
                  looping: false,
                  selectionOverlay: const SizedBox.shrink(),
                  onSelectedItemChanged: (i) =>
                      setState(() => _selectedIndex = i),
                  children: widget.options
                      .map(
                        (date) => Center(
                          child: Text(
                            context.statisticPeriodLabel(
                              selectedTabIndex: widget.selectedTabIndex,
                              anchorDate: date,
                            ),
                            style: context.typo.headline.small.copyWith(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.dailyExpenses,
    required this.maxAmount,
    required this.animationOf,
    required this.selectedTabIndex,
  });

  final List<StatisticDailyExpenseData> dailyExpenses;
  final int maxAmount;
  final Animation<double> Function(int index) animationOf;
  final int selectedTabIndex;

  String _dayLabel(StatisticDailyExpenseData point, int index) {
    if (selectedTabIndex == 0) {
      const weekLabels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
      return weekLabels[index % 7];
    }
    if (selectedTabIndex == 2) {
      final quarter = (point.date.month - 1) ~/ 3 + 1;
      return 'Q$quarter';
    }
    return 'T${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(dailyExpenses.length, (i) {
        final point = dailyExpenses[i];
        final isMax = point.amountMinor == maxAmount && maxAmount > 0;
        final isEmpty = point.amountMinor == 0;
        final heightFactor = maxAmount <= 0
            ? 0.03
            : (point.amountMinor / maxAmount).clamp(0.03, 1.0);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  context.formatStatisticCompactCurrency(point.amountMinor),
                  textAlign: TextAlign.center,
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isMax ? AppTheme.primaryDark : AppTheme.textGrey,
                    fontSize: 9.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                AnimatedBuilder(
                  animation: animationOf(i),
                  builder: (context, _) {
                    final factor =
                        (heightFactor * animationOf(i).value).clamp(0.03, 1.0);
                    return SizedBox(
                      height: 120.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: factor,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: isMax
                                    ? [
                                        const Color(0xFF4E9B52),
                                        AppTheme.primaryDark,
                                      ]
                                    : isEmpty
                                        ? [
                                            const Color(0xFFD9E8DA),
                                            const Color(0xFFA7CDA9),
                                          ]
                                        : [
                                            const Color(0xFF5AA05D),
                                            AppTheme.primary,
                                          ],
                              ),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8.r),
                                bottom: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 6.h),
                Text(
                  _dayLabel(point, i),
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isMax ? AppTheme.primaryDark : AppTheme.textGrey,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _PeriodPill extends StatelessWidget {
  const _PeriodPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.76),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: AppTheme.primary.withValues(alpha: 0.16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.typo.caption.big.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryDark,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 12.r,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

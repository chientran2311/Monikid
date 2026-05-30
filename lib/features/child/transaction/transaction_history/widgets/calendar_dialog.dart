import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/calendar_utils.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({
    super.key,
    required this.initialMonth,
    required this.onDateConfirmed,
  });

  final DateTime initialMonth;
  final ValueChanged<DateTime> onDateConfirmed;

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;
  late final List<int> _years;

  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  int get _maxDay => CalendarUtils.daysInMonth(_selectedMonth, _selectedYear);

  @override
  void initState() {
    super.initState();
    _years = CalendarUtils.recentYears();
    _selectedDay = widget.initialMonth.day;
    _selectedMonth = widget.initialMonth.month;
    _selectedYear = widget.initialMonth.year;

    final yearIndex = _years.indexOf(_selectedYear);
    _monthController = FixedExtentScrollController(initialItem: _selectedMonth - 1);
    _yearController = FixedExtentScrollController(
      initialItem: yearIndex >= 0 ? yearIndex : _years.length - 1,
    );
  }

  @override
  void dispose() {
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _onMonthChanged(int i) {
    final newMonth = i + 1;
    final newMaxDay = CalendarUtils.daysInMonth(newMonth, _selectedYear);
    setState(() {
      _selectedMonth = newMonth;
      _selectedDay = _selectedDay.clamp(1, newMaxDay);
    });
  }

  void _onYearChanged(int i) {
    final newYear = _years[i];
    final newMaxDay = CalendarUtils.daysInMonth(_selectedMonth, newYear);
    setState(() {
      _selectedYear = newYear;
      _selectedDay = _selectedDay.clamp(1, newMaxDay);
    });
  }

  void _confirm() {
    widget.onDateConfirmed(DateTime(_selectedYear, _selectedMonth, _selectedDay));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final highlightColor = isDark
        ? AppTheme.borderDark.withValues(alpha: 0.5)
        : AppTheme.primaryLight;

    final monthNames = List.generate(
      12,
      (i) => DateFormat('MMMM', s.localeName).format(DateTime(2024, i + 1)),
    );

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: mutedColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(99.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 56.h,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    s.transactionHistorySelectDateTitle,
                    style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.w700, color: textColor),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: _confirm,
                    child: Text(
                      s.actionDone,
                      style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 240.h,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 40.h,
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Day — key forces full rebuild when maxDay changes
                      Expanded(
                        child: _DayPicker(
                          key: ValueKey('day_$_maxDay'),
                          initialDay: _selectedDay,
                          maxDay: _maxDay,
                          textColor: textColor,
                          onChanged: (d) => setState(() => _selectedDay = d),
                        ),
                      ),
                      // Month
                      Expanded(
                        flex: 2,
                        child: CupertinoPicker(
                          scrollController: _monthController,
                          itemExtent: 40.h,
                          looping: true,
                          selectionOverlay: const SizedBox.shrink(),
                          onSelectedItemChanged: _onMonthChanged,
                          children: monthNames
                              .map(
                                (name) => Center(
                                  child: Text(
                                    name,
                                    style: context.typo.subtitle.medium.copyWith(fontWeight: FontWeight.w500, color: textColor),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      // Year
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: _yearController,
                          itemExtent: 40.h,
                          looping: false,
                          selectionOverlay: const SizedBox.shrink(),
                          onSelectedItemChanged: _onYearChanged,
                          children: _years
                              .map(
                                (year) => Center(
                                  child: Text(
                                    '$year',
                                    style: context.typo.subtitle.medium.copyWith(fontWeight: FontWeight.w500, color: textColor),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

/// Isolated day picker — owns its own [FixedExtentScrollController].
/// Re-keyed by the parent when [maxDay] changes so the controller
/// is cleanly recreated within valid bounds.
class _DayPicker extends StatefulWidget {
  const _DayPicker({
    super.key,
    required this.initialDay,
    required this.maxDay,
    required this.textColor,
    required this.onChanged,
  });

  final int initialDay;
  final int maxDay;
  final Color textColor;
  final ValueChanged<int> onChanged;

  @override
  State<_DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<_DayPicker> {
  late final FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    // initialDay is already clamped by parent before key change
    _controller = FixedExtentScrollController(
      initialItem: (widget.initialDay - 1).clamp(0, widget.maxDay - 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: _controller,
      itemExtent: 40.h,
      looping: false,
      selectionOverlay: const SizedBox.shrink(),
      onSelectedItemChanged: (i) => widget.onChanged(i + 1),
      children: List.generate(
        widget.maxDay,
        (i) => Center(
          child: Text(
            '${i + 1}',
            style: context.typo.subtitle.medium.copyWith(fontWeight: FontWeight.w500, color: widget.textColor),
          ),
        ),
      ),
    );
  }
}

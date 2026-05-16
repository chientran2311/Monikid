import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class CalendarDialogHeader extends StatelessWidget {
  const CalendarDialogHeader({
    super.key,
    required this.borderColor,
    required this.onCancel,
    required this.onDone,
  });

  final Color borderColor;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor, width: 1.w)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Row(
          children: [
            _HeaderAction(label: context.l10n.actionCancel, onPressed: onCancel),
            Expanded(
              child: Text(
                context.l10n.transactionHistorySelectDateTitle,
                textAlign: TextAlign.center,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.textLarge,
                  weight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
            _HeaderAction(label: context.l10n.actionDone, onPressed: onDone),
          ],
        ),
      ),
    );
  }
}

class CalendarMonthNavigator extends StatelessWidget {
  const CalendarMonthNavigator({
    super.key,
    required this.visibleMonth,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime visibleMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat.yMMMM(
      context.l10n.localeName,
    ).format(visibleMonth);
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 14.h, 20.w, 10.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              monthLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.textLarge,
                weight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          _MonthButton(icon: Icons.chevron_left_rounded, onPressed: onPrevious),
          SizedBox(width: 10.w),
          _MonthButton(icon: Icons.chevron_right_rounded, onPressed: onNext),
        ],
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    super.key,
    required this.visibleMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime visibleMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final days = _CalendarDay.buildFor(visibleMonth);
    final weekdays = List<DateTime>.generate(
      7,
      (index) => DateTime(2024, 1, index + 1),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 6.h),
      child: Column(
        children: [
          Row(
            children: weekdays.map((day) {
              final isSunday = day.weekday == DateTime.sunday;
              return Expanded(
                child: Text(
                  DateFormat.E(context.l10n.localeName).format(day),
                  textAlign: TextAlign.center,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.textSmall,
                    weight: FontWeight.w800,
                    color: isSunday ? AppTheme.primary : AppTheme.textGrey,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
          GridView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 44.h,
            ),
            itemBuilder: (context, index) {
              final day = days[index];
              if (day.date == null) {
                return const SizedBox.shrink();
              }

              return _DateCell(
                date: day.date!,
                isSelected: DateUtils.isSameDay(day.date, selectedDate),
                onPressed: () => onDateSelected(day.date!),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primary,
        minimumSize: Size(58.w, 40.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: AppTextStyleFactory.style(
          size: AppFontSizes.textLarge,
          weight: FontWeight.w700,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

class _MonthButton extends StatelessWidget {
  const _MonthButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: AppTheme.primary, size: 28.r),
      constraints: BoxConstraints.tight(Size(36.w, 36.h)),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _DateCell extends StatelessWidget {
  const _DateCell({
    required this.date,
    required this.isSelected,
    required this.onPressed,
  });

  final DateTime date;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final isSunday = date.weekday == DateTime.sunday;
    final color = isSelected
        ? AppTheme.textWhite
        : isSunday
            ? AppTheme.primary
            : textColor;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(44.w, 44.h),
        shape: const CircleBorder(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Center(
        child: Container(
          width: 36.r,
          height: 36.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : null,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${date.day}',
            style: AppTextStyleFactory.style(
              size: AppFontSizes.subtitleMedium,
              weight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarDay {
  const _CalendarDay(this.date);

  final DateTime? date;

  static List<_CalendarDay> buildFor(DateTime visibleMonth) {
    final firstDay = DateTime(visibleMonth.year, visibleMonth.month);
    final lastDay = DateTime(visibleMonth.year, visibleMonth.month + 1, 0);
    final leadingEmptyCount = firstDay.weekday - DateTime.monday;
    final days = <_CalendarDay>[
      for (var index = 0; index < leadingEmptyCount; index++)
        const _CalendarDay(null),
      for (var day = 1; day <= lastDay.day; day++)
        _CalendarDay(DateTime(visibleMonth.year, visibleMonth.month, day)),
    ];
    final trailingEmptyCount = (7 - days.length % 7) % 7;
    return [
      ...days,
      for (var index = 0; index < trailingEmptyCount; index++)
        const _CalendarDay(null),
    ];
  }
}

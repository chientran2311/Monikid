import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_ui_helpers.dart';

class StatisticPeriodFilterSection extends StatelessWidget {
  const StatisticPeriodFilterSection({
    super.key,
    required this.selectedMonthIndex,
    required this.selectedDate,
    required this.onModeChanged,
    required this.onDateSelected,
  });

  final int selectedMonthIndex;
  final DateTime selectedDate;
  final ValueChanged<int> onModeChanged;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 280.w,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceVariant : const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              _ModeButton(
                label: context.l10n.statisticByWeek,
                selected: selectedMonthIndex == 0,
                onTap: () => onModeChanged(0),
              ),
              _ModeButton(
                label: context.l10n.statisticByMonth,
                selected: selectedMonthIndex == 1,
                onTap: () => onModeChanged(1),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        InkWell(
          borderRadius: BorderRadius.circular(999.r),
          onTap: () => _showPeriodBottomSheet(context),
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(color: const Color(0xFFF3F4F6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.statisticPeriodLabel(
                    selectedMonthIndex: selectedMonthIndex,
                    anchorDate: selectedDate,
                  ),
                  style: TextStyle(
                    fontSize: 12.r,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18.r,
                  color: const Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showPeriodBottomSheet(BuildContext context) async {
    final options = selectedMonthIndex == 0
        ? _buildWeekOptions()
        : _buildMonthOptions();

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    context.l10n.statisticSelectPeriodTitle,
                    style: TextStyle(
                      fontSize: 16.r,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: options.length,
                      separatorBuilder: (_, _) => Divider(height: 1.h),
                      itemBuilder: (sheetContext, index) {
                        final option = options[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.h,
                          ),
                          title: Text(
                            context.statisticPeriodLabel(
                              selectedMonthIndex: selectedMonthIndex,
                              anchorDate: option,
                            ),
                            style: TextStyle(
                              fontSize: 14.r,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(sheetContext).pop();
                            onDateSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<DateTime> _buildMonthOptions() {
    final now = DateTime.now();
    return List.generate(24, (index) => DateTime(now.year, now.month - index, 1));
  }

  List<DateTime> _buildWeekOptions() {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    return List.generate(20, (index) => monday.subtract(Duration(days: 7 * index)));
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: selected
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.r,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppTheme.textBlack : AppTheme.textGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

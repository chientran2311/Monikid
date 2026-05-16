import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/calendar_dialog_content.dart';

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
  late DateTime _selectedDate;
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateUtils.dateOnly(widget.initialMonth);
    _visibleMonth = DateTime(widget.initialMonth.year, widget.initialMonth.month);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return SizedBox(
      height: ScreenUtils.screenHeight,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 360.w),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.textBlack.withValues(alpha: 0.18),
                      blurRadius: 30.r,
                      offset: Offset(0, 18.h),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CalendarDialogHeader(
                        borderColor: borderColor,
                        onCancel: () => context.pop(),
                        onDone: _confirmSelection,
                      ),
                      CalendarMonthNavigator(
                        visibleMonth: _visibleMonth,
                        onPrevious: () => _shiftMonth(-1),
                        onNext: () => _shiftMonth(1),
                      ),
                      CalendarGrid(
                        visibleMonth: _visibleMonth,
                        selectedDate: _selectedDate,
                        onDateSelected: (date) {
                          setState(() => _selectedDate = date);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: _confirmSelection,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              foregroundColor: AppTheme.textWhite,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              context.l10n.actionSelect,
                              style: AppTextStyleFactory.style(
                                size: AppFontSizes.buttonMedium,
                                weight: FontWeight.w700,
                                color: AppTheme.textWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmSelection() {
    context.pop();
    widget.onDateConfirmed(_selectedDate);
  }

  void _shiftMonth(int offset) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + offset);
    });
  }
}

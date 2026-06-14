import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

Future<void> showDobPicker({
  required BuildContext context,
  required String currentDob,
  required ValueChanged<String> onDateSelected,
  required bool isDark,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _DobPickerSheet(
      currentDob: currentDob,
      onDateSelected: onDateSelected,
      isDark: isDark,
    ),
  );
}

class _DobPickerSheet extends StatefulWidget {
  const _DobPickerSheet({
    required this.currentDob,
    required this.onDateSelected,
    required this.isDark,
  });

  final String currentDob;
  final ValueChanged<String> onDateSelected;
  final bool isDark;

  @override
  State<_DobPickerSheet> createState() => _DobPickerSheetState();
}

class _DobPickerSheetState extends State<_DobPickerSheet> {
  late DateTime _tempDate;

  static final _formatter = DateFormat("dd 'tháng' MM, yyyy");

  @override
  void initState() {
    super.initState();
    try {
      _tempDate = _formatter.parse(widget.currentDob);
    } catch (_) {
      _tempDate = DateTime(1990);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final textColor = widget.isDark ? AppTheme.textWhite : AppTheme.textBlack;

    return Container(
      height: 320.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppTheme.borderLight,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.profileEditDobPickerTitle,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    widget.onDateSelected(_formatter.format(_tempDate));
                    Navigator.pop(context);
                  },
                  child: Text(
                    s.profileEditDobPickerDone,
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: widget.isDark ? AppTheme.borderDark : AppTheme.borderLight),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _tempDate,
              maximumDate: DateTime.now(),
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
              onDateTimeChanged: (date) => _tempDate = date,
            ),
          ),
        ],
      ),
    );
  }
}

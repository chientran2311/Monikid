import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class MonthPickerBottomSheet extends StatefulWidget {
  final DateTime? currentDate;
  final bool isDark;
  final Function(DateTime) onDateSelected;
  final VoidCallback onCancel;

  const MonthPickerBottomSheet({
    super.key,
    required this.currentDate,
    required this.isDark,
    required this.onDateSelected,
    required this.onCancel,
  });

  @override
  State<MonthPickerBottomSheet> createState() => _MonthPickerBottomSheetState();
}

class _MonthPickerBottomSheetState extends State<MonthPickerBottomSheet> {
  late DateTime tempDate;

  @override
  void initState() {
    super.initState();
    tempDate = widget.currentDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: widget.onCancel,
                  child: Text(
                    'Hủy',
                    style: TextStyle(
                      color: widget.isDark ? Colors.white70 : CupertinoColors.systemGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => widget.onDateSelected(tempDate),
                  child: const Text(
                    'Xong',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: tempDate,
              minimumYear: 2020,
              maximumYear: DateTime.now().year + 1,
              onDateTimeChanged: (DateTime newDate) {
                tempDate = newDate;
              },
            ),
          ),
        ],
      ),
    );
  }
}

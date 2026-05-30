import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

Future<TimeOfDay?> showTimePickerBottomSheet(
  BuildContext context, {
  required int initialHour,
  required int initialMinute,
}) {
  return showModalBottomSheet<TimeOfDay>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _TimePickerBottomSheet(
      initialHour: initialHour,
      initialMinute: initialMinute,
    ),
  );
}

class _TimePickerBottomSheet extends StatefulWidget {
  const _TimePickerBottomSheet({
    required this.initialHour,
    required this.initialMinute,
  });

  final int initialHour;
  final int initialMinute;

  @override
  State<_TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<_TimePickerBottomSheet> {
  late int _hour;
  late int _minute;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialHour;
    _minute = widget.initialMinute;
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final selectorColor =
        isDark ? AppTheme.borderDark.withValues(alpha: 0.5) : const Color(0xFFE8EDF2);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          // Handle bar
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
          // Header: title centered, done button right
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 28.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      s.notificationSettingsTimeLabel,
                      style: context.typo.subtitle.small.copyWith(color: textColor),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(
                        TimeOfDay(hour: _hour, minute: _minute),
                      ),
                      child: Text(
                        s.actionDone,
                        style: context.typo.subtitle.small.copyWith(color: AppTheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Divider(height: 1, thickness: 1, color: borderColor),
          // Wheel picker
          SizedBox(
            height: 216.h,
            child: Stack(
              children: [
                // Selection highlight
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
                // Hour + Minute pickers
                Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: _hourController,
                        itemExtent: 42.h,
                        looping: true,
                        selectionOverlay: const SizedBox.shrink(),
                        onSelectedItemChanged: (i) => setState(() => _hour = i),
                        children: List.generate(
                          24,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: context.typo.headline.small.copyWith(fontWeight: FontWeight.w500, color: textColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Colon separator
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        ':',
                        style: context.typo.title.big.copyWith(fontWeight: FontWeight.w600, color: textColor),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: _minuteController,
                        itemExtent: 42.h,
                        looping: true,
                        selectionOverlay: const SizedBox.shrink(),
                        onSelectedItemChanged: (i) => setState(() => _minute = i),
                        children: List.generate(
                          60,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: context.typo.headline.small.copyWith(fontWeight: FontWeight.w500, color: textColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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

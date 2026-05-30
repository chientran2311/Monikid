import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/app_ios_switch.dart';

class SwitchItem extends StatelessWidget {
  const SwitchItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.textColor,
    required this.borderColor,
    required this.showBorder,
    required this.activeColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color textColor;
  final Color borderColor;
  final bool showBorder;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showBorder
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: borderColor, width: 0.5),
              ),
            )
          : null,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: iconColor, size: 18.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: context.typo.subtitle.small.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            ),
          ),
          AppIosSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }
}

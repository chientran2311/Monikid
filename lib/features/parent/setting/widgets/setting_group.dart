import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    super.key,
    required this.title,
    required this.titleColor,
    required this.children,
    required this.surfaceColor,
    required this.borderColor,
    required this.isDark,
  });

  final String title;
  final Color titleColor;
  final List<Widget> children;
  final Color surfaceColor;
  final Color borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: titleColor,
              letterSpacing: 0.8,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 0.5),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}

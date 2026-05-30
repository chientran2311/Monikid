import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class NotificationTipItem extends StatelessWidget {
  const NotificationTipItem({
    super.key,
    required this.number,
    required this.text,
    required this.textColor,
    required this.isDark,
  });

  final String number;
  final String text;
  final Color textColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22.r,
          height: 22.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? AppTheme.surfaceDark : Colors.white,
            border: Border.all(
              color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: context.typo.label.medium.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryDark,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: context.typo.body.medium.copyWith(color: textColor, height: 1.45),
          ),
        ),
      ],
    );
  }
}

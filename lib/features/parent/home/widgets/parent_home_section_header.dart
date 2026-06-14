import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ParentHomeSectionHeader extends StatelessWidget {
  const ParentHomeSectionHeader({
    required this.title,
    required this.textColor,
    required this.mutedColor,
    this.trailingLabel,
    this.onTrailingTap,
    super.key,
  });

  final String title;
  final String? trailingLabel;
  final Color textColor;
  final Color mutedColor;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -0.02 * 18,
            ),
          ),
        ),
        if (trailingLabel != null)
          GestureDetector(
            onTap: onTrailingTap,
            behavior: HitTestBehavior.opaque,
            child: Text(
              trailingLabel!,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w900,
                color: AppTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

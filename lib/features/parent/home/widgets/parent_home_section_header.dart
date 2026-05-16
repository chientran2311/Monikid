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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: mutedColor,
              letterSpacing: 0.6,
            ),
          ),
        ),
        if (trailingLabel != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(
              trailingLabel!,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

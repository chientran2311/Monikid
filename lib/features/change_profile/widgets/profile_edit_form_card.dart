import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ProfileEditFormCard extends StatelessWidget {
  const ProfileEditFormCard({
    super.key,
    required this.children,
    required this.isDark,
  });

  final List<Widget> children;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8.h),
            blurRadius: 24.r,
            color: AppTheme.primary.withValues(alpha: isDark ? 0.08 : 0.10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

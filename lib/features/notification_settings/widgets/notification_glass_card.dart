import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class NotificationGlassCard extends StatelessWidget {
  const NotificationGlassCard({
    super.key,
    required this.child,
    this.isDark = false,
    this.padding,
  });

  final Widget child;
  final bool isDark;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF143423).withValues(alpha: 0.08),
                  blurRadius: 40,
                  offset: Offset(0, 18.h),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: padding ?? EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.surfaceDark.withValues(alpha: 0.88)
                  : Colors.white.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: isDark
                    ? AppTheme.borderDark
                    : Colors.white.withValues(alpha: 0.72),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

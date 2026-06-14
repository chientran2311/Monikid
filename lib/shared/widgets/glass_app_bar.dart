import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Glass morphism app bar cho các màn push (settings, transactions, etc.)
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    required this.title,
    this.onBackTap,
  });

  final String title;
  final VoidCallback? onBackTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            GlassIconButton(
              onTap: onBackTap ?? () => context.pop(),
              isDark: isDark,
              child: Icon(
                Icons.chevron_left_rounded,
                color: textColor,
                size: 26.r,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: context.typo.subtitle.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: -0.01,
                  ),
                ),
              ),
            ),
            // Spacer for centering (same width as back button)
            SizedBox(width: 44.r),
          ],
        ),
      ),
    );
  }
}

/// Glass morphism icon button with blur effect
class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.isDark,
  });

  final VoidCallback onTap;
  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.76),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                width: 1,
              ),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

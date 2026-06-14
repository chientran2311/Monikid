import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Applies the two-radial-glow background decoration to any screen body.
///
/// Default ([whiteBackground] = false):
///   Renders only the glow overlays; the Scaffold sets the base color
///   (homeParBg1 for light / backgroundDark for dark).
///
/// [whiteBackground] = true:
///   Adds a solid white base layer before the glow overlays.
///   Use for child screens: setting_tab_stu, transaction_history,
///   statistic_stu, home_stu.
class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.whiteBackground = false,
  });

  final Widget child;

  /// When true, a white base fills behind the radial glows.
  /// Scaffold.backgroundColor should still be set to Colors.white (light)
  /// or AppTheme.backgroundDark (dark) for consistent overscroll color.
  final bool whiteBackground;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) return child;
    return Stack(
      children: [
        // White base layer — only when whiteBackground is true
        if (whiteBackground)
          const Positioned.fill(
            child: IgnorePointer(
              child: ColoredBox(color: AppTheme.surfaceLight),
            ),
          ),
        Positioned(
          left: -80.w,
          top: -100.h,
          child: IgnorePointer(child: _radial(360.w, alpha: 0.14)),
        ),
        Positioned(
          right: -90.w,
          top: 160.h,
          child: IgnorePointer(child: _radial(320.w, alpha: 0.09)),
        ),
        Positioned.fill(child: child),
      ],
    );
  }

  Widget _radial(double size, {required double alpha}) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppTheme.primary.withValues(alpha: alpha),
              AppTheme.primary.withValues(alpha: 0),
            ],
          ),
        ),
      );
}

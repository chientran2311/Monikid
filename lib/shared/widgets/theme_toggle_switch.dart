import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// iOS-style pill toggle whose thumb rolls a full turn left <-> right while the
/// track morphs grey <-> green, with the sun <-> moon icon crossfading on top.
class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key, required this.value, this.onChanged});

  /// true = dark.
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      // A single tween drives slide + spin + color so they stay in sync,
      // which is what reads as a rolling ball rather than a sliding dot.
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(end: value ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeInOutCubic,
        builder: (context, t, _) {
          final trackColor =
              Color.lerp(AppTheme.iosSystemGrey, AppTheme.primary, t);
          return Container(
            width: 52.w,
            height: 32.h,
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Align(
              alignment: Alignment(lerpDouble(-1, 1, t)!, 0),
              child: Transform.rotate(
                // Full clockwise turn while moving right; 360deg lands the
                // icon upright at rest.
                angle: t * 2 * math.pi,
                child: Container(
                  width: 26.r,
                  height: 26.r,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      value ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                      key: ValueKey<bool>(value),
                      size: 15.r,
                      color: value ? AppTheme.primary : AppTheme.orangeWarning,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

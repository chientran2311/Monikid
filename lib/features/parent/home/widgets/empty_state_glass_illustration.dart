import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Glass illustration for the no-family empty state.
/// HTML `.glass-illustration`: a blurred circle + center emoji + two floating
/// sparkle chips that bob vertically (staggered).
class EmptyStateGlassIllustration extends HookWidget {
  const EmptyStateGlassIllustration({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // Two float controllers — s1 starts at phase 0, s2 offset by 1s/4s = 0.25.
    final c1 = useAnimationController(duration: const Duration(seconds: 4));
    final c2 = useAnimationController(duration: const Duration(seconds: 4));
    useEffect(() {
      c1.repeat(reverse: true);
      c2.value = 0.25;
      c2.repeat(reverse: true);
      return null;
    }, const []);

    final accent = isDark ? AppTheme.accentVibrant : AppTheme.primary;

    return SizedBox(
      width: 200.r,
      height: 200.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // .glass-circle — shadow on the outer box (ClipOval cannot cast shadow).
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 20.h),
                      blurRadius: 40.r,
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            accent.withValues(alpha: isDark ? 0.25 : 0.2),
                            accent.withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white
                              .withValues(alpha: isDark ? 0.15 : 0.3),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // .glass-icon-main
          Center(
            child: Text('🏠', style: TextStyle(fontSize: 80.sp)),
          ),
          // .floating-sparkle.s1 — top-right, delay 0.
          Positioned(
            top: 10.h,
            right: 10.w,
            child: _Sparkle(emoji: '✨', controller: c1, isDark: isDark),
          ),
          // .floating-sparkle.s2 — bottom-left, delay 1s.
          Positioned(
            bottom: 20.h,
            left: -10.w,
            child: _Sparkle(emoji: '💚', controller: c2, isDark: isDark),
          ),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({
    required this.emoji,
    required this.controller,
    required this.isDark,
  });

  final String emoji;
  final AnimationController controller;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final offset = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    return AnimatedBuilder(
      animation: offset,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, offset.value.h),
        child: child,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: (isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight)
                  .withValues(alpha: isDark ? 0.65 : 0.72),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: (isDark ? AppTheme.accentVibrant : AppTheme.primary)
                    .withValues(alpha: isDark ? 0.18 : 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 8.h),
                  blurRadius: 16.r,
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                ),
              ],
            ),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 20.sp))),
          ),
        ),
      ),
    );
  }
}

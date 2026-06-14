import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class SplashMeshBackground extends HookWidget {
  const SplashMeshBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final blob1Ctrl = useAnimationController(duration: const Duration(seconds: 25));
    final blob2Ctrl = useAnimationController(duration: const Duration(seconds: 18));
    final blob3Ctrl = useAnimationController(duration: const Duration(seconds: 22));

    useEffect(() {
      blob1Ctrl.repeat(reverse: true);
      blob2Ctrl.repeat(reverse: true);
      blob3Ctrl.repeat(reverse: true);
      return null;
    }, const []);

    return AnimatedBuilder(
      animation: Listenable.merge([blob1Ctrl, blob2Ctrl, blob3Ctrl]),
      builder: (context, _) {
        final sw = ScreenUtils.screenWidth;
        final sh = ScreenUtils.screenHeight;

        return Container(
          color: isDark ? AppTheme.backgroundDark : AppTheme.splashBackground,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Blob 1 — top-left, primary green
              _Blob(
                size: 400.w,
                color: AppTheme.primary.withValues(alpha: 0.4),
                left: -100.w + blob1Ctrl.value * 50.w,
                top: -100.h + blob1Ctrl.value * 100.h,
                scale: 1.0 + blob1Ctrl.value * 0.2,
              ),
              // Blob 2 — bottom-right, bright accent
              _Blob(
                size: 350.w,
                color: AppTheme.primaryBright.withValues(alpha: 0.4),
                left: sw - 300.w + blob2Ctrl.value * 50.w,
                top: sh - 300.h + blob2Ctrl.value * 100.h,
                scale: 1.0 + blob2Ctrl.value * 0.2,
              ),
              // Blob 3 — center, pale green
              _Blob(
                size: 300.w,
                color: AppTheme.primaryPale.withValues(alpha: 0.4),
                left: sw * 0.2 + blob3Ctrl.value * 50.w,
                top: sh * 0.3 + blob3Ctrl.value * 100.h,
                scale: 1.0 + blob3Ctrl.value * 0.2,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.size,
    required this.color,
    required this.left,
    required this.top,
    required this.scale,
  });

  final double size;
  final Color color;
  final double left;
  final double top;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}

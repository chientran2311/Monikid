import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class SplashBrandSection extends HookWidget {
  const SplashBrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Float: 4s visual cycle (2s forward + 2s reverse) — drives logo + ghost
    final floatCtrl = useAnimationController(duration: const Duration(seconds: 2));
    // Reveal: one-shot on mount for brand name
    final revealCtrl = useAnimationController(duration: const Duration(milliseconds: 1200));

    useEffect(() {
      floatCtrl.repeat(reverse: true);
      revealCtrl.forward();
      return null;
    }, const []);

    final floatCurve = CurvedAnimation(parent: floatCtrl, curve: Curves.easeInOut);
    final revealCurve = CurvedAnimation(
      parent: revealCtrl,
      curve: const Cubic(0.16, 1, 0.3, 1),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Floating glass logo with ghost glitch
          AnimatedBuilder(
            animation: floatCurve,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, floatCurve.value * -15.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  child!, // glass logo box
                ],
              ),
            ),
            child: _GlassLogoBox(isDark: isDark),
          ),
          SizedBox(height: 24.h),
          // Brand name with blur-reveal animation
          AnimatedBuilder(
            animation: revealCurve,
            builder: (context, child) {
              final blur = (1.0 - revealCurve.value) * 10.0;
              Widget w = Opacity(
                opacity: revealCurve.value,
                child: Transform.translate(
                  offset: Offset(0, (1.0 - revealCurve.value) * 10.h),
                  child: child,
                ),
              );
              if (blur > 0.1) {
                w = ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: w,
                );
              }
              return w;
            },
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [Colors.white, AppTheme.textMuted]
                    : [AppTheme.primaryDark, AppTheme.textDark],
              ).createShader(bounds),
              child: Text(
                'MoniKid',
                style: context.typo.display.big.copyWith(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 42 * -0.06,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassLogoBox extends StatelessWidget {
  const _GlassLogoBox({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 110.w,
          height: 110.w,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.4),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: isDark ? 0.15 : 0.5),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 20.h),
                blurRadius: 40.r,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/app_icon.png',
              width: 80.w,
              height: 80.w,
              cacheWidth: decodePixelsFor(context, 80.w),
            ),
          ),
        ),
      ),
    );
  }
}

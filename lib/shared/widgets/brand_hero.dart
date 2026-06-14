import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Animated brand hero used on auth screens (login, register).
/// Main icon floats (4s). Three floaties diagonal-float (6s, staggered).
/// Pass distinct [floatie1]/[floatie2]/[floatie3] and [tagline] per screen.
class BrandHero extends StatefulWidget {
  const BrandHero({
    super.key,
    required this.tagline,
    required this.floatie1,
    required this.floatie2,
    required this.floatie3,
  });

  final String tagline;
  final String floatie1;
  final String floatie2;
  final String floatie3;

  @override
  State<BrandHero> createState() => _BrandHeroState();
}

class _BrandHeroState extends State<BrandHero> with TickerProviderStateMixin {
  late final AnimationController _mainCtrl;
  late final AnimationController _f1Ctrl;
  late final AnimationController _f2Ctrl;
  late final AnimationController _f3Ctrl;

  @override
  void initState() {
    super.initState();

    _mainCtrl = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    // Phase-offset floaties to match CSS animation-delay stagger
    _f1Ctrl = AnimationController(duration: const Duration(seconds: 6), vsync: this)
      ..value = 0.5 / 6.0
      ..repeat(reverse: true);

    _f2Ctrl = AnimationController(duration: const Duration(seconds: 6), vsync: this)
      ..value = 1.5 / 6.0
      ..repeat(reverse: true);

    _f3Ctrl = AnimationController(duration: const Duration(seconds: 6), vsync: this)
      ..value = 2.5 / 6.0
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _mainCtrl.dispose();
    _f1Ctrl.dispose();
    _f2Ctrl.dispose();
    _f3Ctrl.dispose();
    super.dispose();
  }

  Offset _floatAlt(AnimationController ctrl) {
    final t = CurvedAnimation(parent: ctrl, curve: Curves.easeInOut);
    return Offset(
      Tween<double>(begin: 0, end: 5).evaluate(t),
      Tween<double>(begin: 0, end: -8).evaluate(t),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainY = Tween<double>(begin: 0, end: -10)
        .animate(CurvedAnimation(parent: _mainCtrl, curve: Curves.easeInOut));

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 120.r,
              height: 120.r,
              child: AnimatedBuilder(
                animation: Listenable.merge([_mainCtrl, _f1Ctrl, _f2Ctrl, _f3Ctrl]),
                builder: (_, __) => Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, mainY.value.h),
                      child: _MainIcon(),
                    ),
                    Positioned(
                      top: 0,
                      left: -10.w,
                      child: Transform.translate(
                        offset: _floatAlt(_f1Ctrl),
                        child: _Floatie(size: 40.r, fontSize: 18, label: widget.floatie1),
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      right: -15.w,
                      child: Transform.translate(
                        offset: _floatAlt(_f2Ctrl),
                        child: _Floatie(size: 34.r, fontSize: 16, label: widget.floatie2),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      right: -20.w,
                      child: Transform.translate(
                        offset: _floatAlt(_f3Ctrl),
                        child: _Floatie(size: 28.r, fontSize: 14, label: widget.floatie3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              widget.tagline,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.bodyMedium,
                weight: FontWeight.w800,
                color: AppTheme.primary,
                letterSpacing: 0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.r,
      height: 84.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 20.h),
            blurRadius: 40.r,
            color: AppTheme.primary.withValues(alpha: 0.2),
          ),
        ],
      ),
      child: Image.asset(
        'assets/app_icon.png',
        width: 84.r,
        height: 84.r,
        cacheWidth: decodePixelsFor(context, 84.r),
      ),
    );
  }
}

class _Floatie extends StatelessWidget {
  const _Floatie({
    required this.size,
    required this.fontSize,
    required this.label,
  });

  final double size;
  final double fontSize;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.78),
        border: Border.all(color: AppTheme.borderLight),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8.h),
            blurRadius: 16.r,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Center(
        child: Text(label, style: TextStyle(fontSize: fontSize.r)),
      ),
    );
  }
}

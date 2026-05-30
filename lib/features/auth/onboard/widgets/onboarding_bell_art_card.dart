import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class OnboardingBellArtCard extends StatefulWidget {
  const OnboardingBellArtCard({super.key});

  @override
  State<OnboardingBellArtCard> createState() => _OnboardingBellArtCardState();
}

class _OnboardingBellArtCardState extends State<OnboardingBellArtCard>
    with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _swayCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _swayCtrl = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _swayCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ringBorder = Color.lerp(AppTheme.primary, Colors.white, 0.80)!;
    final innerRingBorder = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;
    final bellBorder = Color.lerp(AppTheme.primary, Colors.white, 0.76)!;

    final pulseScale = Tween<double>(begin: 1.0, end: 1.55).animate(
      CurvedAnimation(
        parent: _pulseCtrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    final pulseOpacity = Tween<double>(begin: 0.45, end: 0.0).animate(
      CurvedAnimation(
        parent: _pulseCtrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    final bellSway = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(parent: _swayCtrl, curve: Curves.easeInOut),
    );

    return Container(
      width: double.infinity,
      height: 214.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.70),
            Colors.white.withValues(alpha: 0.45),
          ],
        ),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: Color.lerp(AppTheme.primary, Colors.white, 0.82)!,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative orbs
          Positioned(
            top: 20.h,
            right: 28.w,
            child: _Orb(size: 92.r, opacity: 0.9),
          ),
          Positioned(
            bottom: 34.h,
            left: 30.w,
            child: _Orb(size: 54.r, opacity: 0.8),
          ),
          Positioned(
            top: 62.h,
            left: 54.w,
            child: _Orb(size: 36.r, opacity: 0.7),
          ),
          // Bell with pulse ring and sway
          AnimatedBuilder(
            animation: Listenable.merge([_pulseCtrl, _swayCtrl]),
            builder: (_, __) {
              return SizedBox(
                width: 168.r,
                height: 148.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pulse ring
                    Transform.scale(
                      scale: pulseScale.value,
                      child: Container(
                        width: 148.r,
                        height: 148.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primary
                              .withValues(alpha: pulseOpacity.value),
                        ),
                      ),
                    ),
                    // Static outer ring
                    Container(
                      width: 148.r,
                      height: 148.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ringBorder),
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.55),
                            Colors.white.withValues(alpha: 0.06),
                          ],
                        ),
                      ),
                    ),
                    // Inner ring (approximates ::before dashed)
                    Container(
                      width: 124.r,
                      height: 124.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: innerRingBorder),
                      ),
                    ),
                    // Innermost ring (approximates ::after dashed)
                    Container(
                      width: 96.r,
                      height: 96.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: innerRingBorder),
                      ),
                    ),
                    // Bell icon with sway
                    RotationTransition(
                      turns: bellSway,
                      child: Container(
                        width: 88.r,
                        height: 88.r,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.lerp(AppTheme.primary, Colors.white, 0.86)!,
                              Colors.white,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(28.r),
                          border: Border.all(color: bellBorder),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 22.h),
                              blurRadius: 40.r,
                              color: AppTheme.primary.withValues(alpha: 0.12),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '🔔',
                            style: TextStyle(fontSize: 40.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Floating mini transaction card
          Positioned(
            right: 0,
            bottom: 10.h,
            child: Container(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 9.h),
              decoration: BoxDecoration(
                color: AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: Color.lerp(AppTheme.primary, Colors.white, 0.82)!,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 14.h),
                    blurRadius: 28.r,
                    color: AppTheme.primary.withValues(alpha: 0.12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.onboardingNotificationMiniAmount,
                    style: AppTextStyleFactory.style(
                      size: AppFontSizes.bodyMedium,
                      weight: FontWeight.w900,
                      color: AppTheme.textBlack,
                      letterSpacing: -0.02,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    l10n.onboardingNotificationMiniMeta,
                    style: AppTextStyleFactory.style(
                      size: AppFontSizes.captionMedium,
                      weight: FontWeight.w400,
                      color: AppTheme.textGrey,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.lerp(AppTheme.primary, Colors.white, 0.86)!,
        ),
      ),
    );
  }
}

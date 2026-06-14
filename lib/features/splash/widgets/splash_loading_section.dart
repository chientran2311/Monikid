import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class SplashLoadingSection extends HookWidget {
  const SplashLoadingSection({
    super.key,
    required this.progress,
    this.onComplete,
  });

  final int progress;
  // Called once after the progress bar finishes animating to 100%.
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final shimmerCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );
    final pulseCtrl = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    useEffect(() {
      shimmerCtrl.repeat();
      pulseCtrl.repeat(reverse: true);
      return null;
    }, const []);

    final progressValue = (progress / 100.0).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 60.h),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status text with pulse
          AnimatedBuilder(
            animation: pulseCtrl,
            builder: (_, __) => Opacity(
              opacity: 0.4 + pulseCtrl.value * 0.4,
              child: Text(
                context.l10n.splashStatusLoading.toUpperCase(),
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 11 * 0.15,
                  color: AppTheme.textBlack,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Progress track
          Container(
            width: 240.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 400),
                  tween: Tween(begin: 0.0, end: progressValue),
                  onEnd: progress == 100 ? onComplete : null,
                  builder: (_, value, __) => AnimatedBuilder(
                    animation: shimmerCtrl,
                    builder: (_, __) => FractionallySizedBox(
                      widthFactor: value,
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          // Gradient fill
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppTheme.primary, AppTheme.primaryBright],
                                ),
                              ),
                            ),
                          ),
                          // Glow shadow via Container shadow
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 15.r,
                                    color: AppTheme.primary.withValues(alpha: 0.4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Shimmer pass
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: (shimmerCtrl.value * 4 - 1) * 60.w,
                            child: Container(
                              width: 60.w,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Color(0x66FFFFFF),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// iOS-26 glass state card for the parent statistic tab — backs the empty,
/// loading and error states. HTML `.empty-state-card`: thick glass card with a
/// blurred gradient circle, a center emoji (or spinner), a muted description and
/// an optional action below.
class ParentStatisticStateCard extends HookWidget {
  const ParentStatisticStateCard({
    super.key,
    required this.isDark,
    required this.message,
    this.emoji = '📊',
    this.showSpinner = false,
    this.action,
  });

  final bool isDark;
  final String message;

  /// Emoji shown inside the glass circle (ignored when [showSpinner] is true).
  final String emoji;

  /// When true, a spinner replaces the emoji (loading state).
  final bool showSpinner;

  /// Optional action rendered below the message (e.g. a retry button).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    // HTML `.surface-glass-thick`: light rgba(255,255,255,.88) / dark rgba(35,45,35,.85).
    final cardColor = (isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight)
        .withValues(alpha: isDark ? 0.85 : 0.88);
    // --muted: green-tinted fg at 60% on light, slate on dark.
    final mutedColor = isDark
        ? AppTheme.textMuted
        : AppTheme.textBlack.withValues(alpha: 0.6);

    // HTML `.empty-state-card { animation: fadeIn 0.8s ease-out }`
    // — opacity 0→1 + translateY 30px→0.
    final fadeCtrl = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    useEffect(() {
      fadeCtrl.forward();
      return null;
    }, const []);
    final fade = CurvedAnimation(parent: fadeCtrl, curve: Curves.easeOut);

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(fade),
        child: ClipRRect(
          // --radius-2xl: 32px
          borderRadius: BorderRadius.circular(32.r),
          child: BackdropFilter(
            // backdrop-filter: blur(24px) saturate(180%)
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(32.r),
                // border: 1.5px rgba(255,255,255,.4) light / .1 dark
                border: Border.all(
                  color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.4),
                  width: 1.5.r,
                ),
                // --shadow: 0 24px 60px rgba(47,127,51,.08)
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 24.h),
                    blurRadius: 60.r,
                    color: AppTheme.primary.withValues(alpha: 0.08),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _GlassIllustration(
                    isDark: isDark,
                    emoji: emoji,
                    showSpinner: showSpinner,
                  ),
                  SizedBox(height: 24.h),
                  // .empty-desc { max-width: 240px; line-height: 1.5 }
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 240.w),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: context.typo.body.medium.copyWith(
                        color: mutedColor,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (action != null) ...[
                    SizedBox(height: 20.h),
                    action!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// HTML `.glass-illustration` (140×140): a blurred gradient circle (inset 10)
/// behind a center emoji (or spinner) with a soft drop-shadow.
class _GlassIllustration extends StatelessWidget {
  const _GlassIllustration({
    required this.isDark,
    required this.emoji,
    this.showSpinner = false,
  });

  final bool isDark;
  final String emoji;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    final accent = isDark ? AppTheme.accentVibrant : AppTheme.primary;

    return SizedBox(
      width: 140.r,
      height: 140.r,
      child: Stack(
        children: [
          // .glass-circle — shadow on the outer box (ClipOval cannot cast it).
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(10.r),
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
                        // linear-gradient(135deg, accent .2/.25, accent .05)
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
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
          // Center content: spinner (loading) or .glass-icon-main emoji.
          Center(
            child: showSpinner
                ? SizedBox(
                    width: 40.r,
                    height: 40.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: accent,
                    ),
                  )
                : Text(
                    emoji,
                    style: TextStyle(
                      fontSize: 56.sp,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 10.h),
                          blurRadius: 20.r,
                          color: AppTheme.primary.withValues(alpha: 0.2),
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

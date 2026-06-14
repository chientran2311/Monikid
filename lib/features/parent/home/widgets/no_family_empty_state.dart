import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/widgets/empty_state_cta_card.dart';
import 'package:monikid/features/parent/home/widgets/empty_state_glass_illustration.dart';
import 'package:monikid/features/parent/home/widgets/empty_state_hint_grid.dart';

/// iOS-26 glass empty state shown on the parent home tab when no family exists.
/// Reuses the create-family action via [onCreateTap]; [isLoading] mirrors
/// `state.isCreatingFamily`.
class NoFamilyEmptyState extends HookWidget {
  const NoFamilyEmptyState({
    super.key,
    required this.isDark,
    required this.isLoading,
    required this.onCreateTap,
  });

  final bool isDark;
  final bool isLoading;
  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    debugPrint('[NoFamilyEmptyState] build() start — isDark=$isDark isLoading=$isLoading');

    final s = context.l10n;
    final titleColor = isDark ? AppTheme.textWhite : AppTheme.homeParFg;
    final mutedColor = isDark
        ? AppTheme.textMuted
        : AppTheme.homeParFg.withValues(alpha: 0.6);

    final heroCtrl = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    useEffect(() {
      debugPrint('[NoFamilyEmptyState] useEffect → heroCtrl.forward()');
      heroCtrl.forward();
      return null;
    }, const []);

    debugPrint('[NoFamilyEmptyState] heroCtrl.value=${heroCtrl.value} building tree...');

    try {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _fade(EmptyStateGlassIllustration(isDark: isDark), 0.0, heroCtrl),
          SizedBox(height: 32.h),
          _fade(
            Text(
              s.homeParNoFamilyTitle,
              textAlign: TextAlign.center,
              style: context.typo.title.big.copyWith(
                fontWeight: FontWeight.w800,
                color: titleColor,
              ),
            ),
            0.15,
            heroCtrl,
          ),
          SizedBox(height: 12.h),
          _fade(
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280.w),
              child: Text(
                s.homeParNoFamilySubtitle,
                textAlign: TextAlign.center,
                style: context.typo.body.big.copyWith(
                  color: mutedColor,
                  height: 1.5,
                ),
              ),
            ),
            0.25,
            heroCtrl,
          ),
          SizedBox(height: 40.h),
          _fade(
            EmptyStateCtaCard(
              isDark: isDark,
              isLoading: isLoading,
              onTap: onCreateTap,
            ),
            0.35,
            heroCtrl,
          ),
          SizedBox(height: 32.h),
          _fade(EmptyStateHintGrid(isDark: isDark), 0.45, heroCtrl),
        ],
      ),
    );
    } catch (e, st) {
      debugPrint('[NoFamilyEmptyState] BUILD ERROR: $e\n$st');
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'NoFamilyEmptyState error:\n$e',
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
      );
    }
  }

  /// HTML `.empty-hero { animation: fadeIn 0.8s ease-out }` — opacity 0→1 +
  /// translateY 30px→0, staggered per block via [startFraction].
  Widget _fade(Widget child, double startFraction, AnimationController ctrl) {
    final end = (startFraction + 0.4).clamp(0.0, 1.0);
    final anim = CurvedAnimation(
      parent: ctrl,
      curve: Interval(startFraction, end, curve: Curves.easeOut),
    );
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
            .animate(anim),
        child: child,
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Glass CTA card for the no-family empty state (HTML `.cta-card`).
/// Reuses the create-family action: [onTap] is wired to `createFamily()` by the
/// caller. Shows a spinner while [isLoading] (`state.isCreatingFamily`).
class EmptyStateCtaCard extends HookWidget {
  const EmptyStateCtaCard({
    super.key,
    required this.isDark,
    required this.isLoading,
    required this.onTap,
  });

  final bool isDark;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pressed = useState(false);

    final cardFill = (isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight)
        .withValues(alpha: isDark ? 0.85 : 0.88);
    final cardBorder = isDark
        ? AppTheme.accentVibrant.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.4);
    final cardShadow = isDark
        ? Colors.black.withValues(alpha: 0.4)
        : AppTheme.primary.withValues(alpha: 0.08);
    final iconBtnBg = isDark ? AppTheme.accentVibrant : AppTheme.primary;
    final iconBtnShadow = iconBtnBg.withValues(alpha: isDark ? 0.4 : 0.3);

    return GestureDetector(
      onTapDown: isLoading ? null : (_) => pressed.value = true,
      onTapUp: isLoading ? null : (_) => pressed.value = false,
      onTapCancel: isLoading ? null : () => pressed.value = false,
      onTap: isLoading ? null : onTap,
      child: AnimatedScale(
        scale: pressed.value ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              decoration: BoxDecoration(
                color: cardFill,
                borderRadius: BorderRadius.circular(32.r),
                border: Border.all(color: cardBorder, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 24.h),
                    blurRadius: 60.r,
                    color: cardShadow,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // .cta-icon-btn
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: iconBtnBg,
                      borderRadius: BorderRadius.circular(22.r),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 12.h),
                          blurRadius: 24.r,
                          color: iconBtnShadow,
                        ),
                      ],
                    ),
                    child: Center(
                      child: isLoading
                          ? SizedBox(
                              width: 24.r,
                              height: 24.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(Icons.add, size: 32.r, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // .cta-label
                  Text(
                    context.l10n.homeParCreateFamilyBtn,
                    style: context.typo.subtitle.medium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppTheme.textWhite : AppTheme.homeParFg,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

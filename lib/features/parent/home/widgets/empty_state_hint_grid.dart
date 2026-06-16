import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Two-chip hint grid for the no-family empty state (HTML `.hint-grid`).
class EmptyStateHintGrid extends StatelessWidget {
  const EmptyStateHintGrid({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    // IntrinsicHeight gives the Row a bounded cross-axis (height) so that
    // CrossAxisAlignment.stretch can size both chips to equal height. Without
    // it the Row sits under an unbounded-height parent (SingleChildScrollView)
    // and stretch throws "BoxConstraints forces an infinite height".
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _HintChip(
              isDark: isDark,
              emoji: '🛡️',
              text: s.homeParNoFamilyHintSafe,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _HintChip(
              isDark: isDark,
              emoji: '📊',
              text: s.homeParNoFamilyHintChart,
            ),
          ),
        ],
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  const _HintChip({
    required this.isDark,
    required this.emoji,
    required this.text,
  });

  final bool isDark;
  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    final fill = (isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight)
        .withValues(alpha: isDark ? 0.65 : 0.72);
    final border = (isDark ? AppTheme.accentVibrant : AppTheme.primary)
        .withValues(alpha: isDark ? 0.18 : 0.12);
    final textColor = isDark ? AppTheme.textWhite : AppTheme.homeParFg;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: TextStyle(fontSize: 20.sp)),
              SizedBox(height: 8.h),
              Text(
                text,
                style: context.typo.body.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Segmented 3-item switch — sliding pill on a neutral track.
/// Mirror of [SwitchTwoItem] but for three segments.
///
/// Usage:
/// ```dart
/// SwitchTabThreeItem(
///   title1: 'Tất cả',
///   title2: 'Thu tiền',
///   title3: 'Chi tiền',
///   selectedIndex: selectedIndex,
///   onChanged: (i) => notifier.setTypeFilter(['all', 'income', 'expense'][i]),
/// )
/// ```
class SwitchTabThreeItem extends StatelessWidget {
  const SwitchTabThreeItem({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.selectedIndex,
    required this.onChanged,
    this.onGlassBackground = false,
  });

  final String title1;
  final String title2;
  final String title3;

  /// 0 = first, 1 = second, 2 = third.
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  /// When true, renders a translucent "glass" track tuned for colored
  /// backgrounds (e.g. parent's green AppBackground). Default keeps the
  /// existing opaque track used on white screens.
  final bool onGlassBackground;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final trackColor = isDark
        ? AppTheme.surfaceVariant
        : onGlassBackground
            ? Colors.white.withValues(alpha: 0.45)
            : AppTheme.controlTrack;
    final pillColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;

    return Container(
      height: 42.h,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(14.r),
        border: onGlassBackground && !isDark
            ? Border.all(color: Colors.white.withValues(alpha: 0.6))
            : null,
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final pillWidth = constraints.maxWidth / 3;
          return Stack(
            children: [
              // Sliding pill
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: selectedIndex * pillWidth,
                top: 0,
                bottom: 0,
                width: pillWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: pillColor,
                    borderRadius: BorderRadius.circular(11.r),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2.h),
                        blurRadius: 8.r,
                        color: Colors.black.withValues(alpha: 0.06),
                      ),
                    ],
                  ),
                ),
              ),
              // Tap targets on top
              Row(
                children: [
                  _SegmentBtn(
                    title: title1,
                    isSelected: selectedIndex == 0,
                    isDark: isDark,
                    onTap: () => onChanged(0),
                  ),
                  _SegmentBtn(
                    title: title2,
                    isSelected: selectedIndex == 1,
                    isDark: isDark,
                    onTap: () => onChanged(1),
                  ),
                  _SegmentBtn(
                    title: title3,
                    isSelected: selectedIndex == 2,
                    isDark: isDark,
                    onTap: () => onChanged(2),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SegmentBtn extends StatelessWidget {
  const _SegmentBtn({
    required this.title,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTextStyleFactory.style(
              size: AppFontSizes.bodyMedium,
              weight: FontWeight.w700,
              color: isSelected
                  ? AppTheme.primary
                  : isDark
                      ? AppTheme.textMuted
                      : AppTheme.textGrey,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Segmented 2-item switch — sliding white pill on a neutral track.
/// Design from monikid-transaction-add-ios.html `.segmented-control`.
///
/// Usage:
/// ```dart
/// SwitchTwoItem(
///   title1: 'Chi tiêu',
///   title2: 'Thu nhập',
///   selectedIndex: selectedIndex,
///   onChanged: (i) => setState(() => selectedIndex = i),
/// )
/// ```
class SwitchTwoItem extends StatelessWidget {
  const SwitchTwoItem({
    super.key,
    required this.title1,
    required this.title2,
    required this.selectedIndex,
    required this.onChanged,
  });

  final String title1;
  final String title2;

  /// 0 = first item active, 1 = second item active.
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: AppTheme.controlTrack,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final pillWidth = constraints.maxWidth / 2;
          return Stack(
            children: [
              // Sliding white pill
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: selectedIndex == 0 ? 0 : pillWidth,
                top: 0,
                bottom: 0,
                width: pillWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceLight,
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
                    onTap: () => onChanged(0),
                  ),
                  _SegmentBtn(
                    title: title2,
                    isSelected: selectedIndex == 1,
                    onTap: () => onChanged(1),
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
    required this.onTap,
  });

  final String title;
  final bool isSelected;
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
              color: isSelected ? AppTheme.primary : AppTheme.textGrey,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}

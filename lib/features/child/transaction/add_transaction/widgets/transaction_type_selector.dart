import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({
    required this.selectedIndex,
    required this.onTypeChanged,
    required this.expenseLabel,
    required this.incomeLabel,
    required this.isDark,
    required this.surfaceColor,
    required this.enabled,
    super.key,
  });

  final int selectedIndex;
  final void Function(int index) onTypeChanged;
  final String expenseLabel;
  final String incomeLabel;
  final bool isDark;
  final Color surfaceColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final trackColor =
        isDark ? AppTheme.surfaceDark : AppTheme.controlTrack;
    final indicatorColor =
        isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLight;

    return Container(
      height: 42.h,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Stack(
        children: [
          // Animated sliding indicator
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: selectedIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(11.r),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.r,
                      color: Colors.black.withValues(alpha: 0.06),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Tab buttons on top
          Row(
            children: [
              _SegmentTab(
                title: expenseLabel,
                index: 0,
                selectedIndex: selectedIndex,
                onTap: enabled ? onTypeChanged : null,
              ),
              _SegmentTab(
                title: incomeLabel,
                index: 1,
                selectedIndex: selectedIndex,
                onTap: enabled ? onTypeChanged : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  final String title;
  final int index;
  final int selectedIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: onTap != null ? () => onTap!(index) : null,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            title,
            style: context.typo.body.medium.copyWith(
              fontWeight: FontWeight.w700,
              color: isSelected ? AppTheme.primary : AppTheme.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}

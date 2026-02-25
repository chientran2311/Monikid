import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class MonthTab extends StatelessWidget {
  final String title;
  final int index;
  final bool isDark;
  final int selectedMonthIndex;
  final ValueChanged<int> onMonthSelected;

  const MonthTab({
    Key? key,
    required this.title,
    required this.index,
    required this.isDark,
    required this.selectedMonthIndex,
    required this.onMonthSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedMonthIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onMonthSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppTheme.surfaceDark : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
            border: isSelected
                ? Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppTheme.primary
                  : (isDark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B)),
            ),
          ),
        ),
      ),
    );
  }
}

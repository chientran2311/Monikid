import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class TypeFilterTab extends StatelessWidget {
  /// 'all' | 'income' | 'expense'
  final String selected;
  final bool isDark;
  final void Function(String) onChanged;

  const TypeFilterTab({
    super.key,
    required this.selected,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _tab(context, 'all', 'Tất cả'),
          _tab(context, 'income', 'Thu tiền'),
          _tab(context, 'expense', 'Chi tiền'),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String value, String label) {
    final isActive = selected == value;

    Color activeColor;
    if (value == 'income') {
      activeColor = const Color(0xFF2563EB);
    } else if (value == 'expense') {
      activeColor = AppTheme.redAlert;
    } else {
      activeColor = AppTheme.primary;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? Colors.white
                  : isDark
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }
}

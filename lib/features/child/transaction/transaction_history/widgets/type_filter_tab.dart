import 'package:flutter/material.dart';
import 'package:monikid/shared/widgets/switchtab_three_item.dart';

/// Converts between the string filter values used by the provider
/// ('all' | 'income' | 'expense') and the integer index expected by
/// [SwitchTabThreeItem].
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

  static const _values = ['all', 'income', 'expense'];

  int get _selectedIndex {
    final i = _values.indexOf(selected);
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchTabThreeItem(
      title1: 'Tất cả',
      title2: 'Thu tiền',
      title3: 'Chi tiền',
      selectedIndex: _selectedIndex,
      onChanged: (i) => onChanged(_values[i]),
    );
  }
}

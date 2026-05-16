import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
    required this.surfaceColor,
    required this.textColor,
    required this.borderColor,
    required this.isDarkMode,
  });

  final String selectedCategory;
  final void Function(String) onSelectCategory;
  final Color surfaceColor;
  final Color textColor;
  final Color borderColor;
  final bool isDarkMode;

  static const _categories = [
    {'id': 'books', 'icon': '📚', 'label': 'Mua sách/vở'},
    {'id': 'snacks', 'icon': '🍜', 'label': 'Ăn vặt'},
    {'id': 'games', 'icon': '🎮', 'label': 'Nạp game'},
    {'id': 'gifts', 'icon': '🎁', 'label': 'Quà tặng'},
    {'id': 'other', 'icon': '📦', 'label': 'Khác'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lý do của con',
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((cat) {
              final isSelected = selectedCategory == cat['id'];
              return GestureDetector(
                onTap: () => onSelectCategory(cat['id']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.primary : borderColor,
                    ),
                    boxShadow: isSelected
                        ? [BoxShadow(color: AppTheme.primary.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(cat['icon']!, style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        cat['label']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : (isDarkMode ? Colors.grey.shade300 : AppTheme.textBlack),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

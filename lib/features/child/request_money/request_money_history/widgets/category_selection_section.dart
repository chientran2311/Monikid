import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class CategorySelectionSection extends StatelessWidget {
  const CategorySelectionSection({
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.isDarkMode,
    required this.surfaceColor,
    required this.textColor,
    super.key,
  });

  final String selectedCategory;
  final void Function(String category) onCategoryChanged;
  final bool isDarkMode;
  final Color surfaceColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lý do của con',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCategoryChip('books', '📚', 'Mua sách/vở'),
              _buildCategoryChip('snacks', '🍜', 'Ăn vặt'),
              _buildCategoryChip('games', '🎮', 'Nạp game'),
              _buildCategoryChip('gifts', '🎁', 'Quà tặng'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String id, String icon, String label) {
    final isSelected = selectedCategory == id;
    return GestureDetector(
      onTap: () => onCategoryChanged(id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary
                : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.grey.shade300 : AppTheme.textBlack),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

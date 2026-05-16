import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RequestReasonSection extends StatelessWidget {
  const RequestReasonSection({
    required this.selectedCategory,
    required this.noteController,
    required this.isDark,
    required this.onCategorySelected,
    super.key,
  });

  final String selectedCategory;
  final TextEditingController noteController;
  final bool isDark;
  final void Function(String categoryId) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'id': 'snacks', 'icon': '🍔', 'label': 'Ăn vặt'},
      {'id': 'books', 'icon': '📚', 'label': 'Mua sách/vở'},
      {'id': 'games', 'icon': '🎮', 'label': 'Nạp game'},
      {'id': 'gifts', 'icon': '🎁', 'label': 'Mua quà'},
      {'id': 'other', 'icon': '📦', 'label': 'Khác'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Con cần tiền để làm gì nhỉ?',
            style: TextStyle(
              color: isDark ? Colors.white : AppTheme.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories.map((cat) {
              final isSelected = selectedCategory == cat['id'];
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cat['icon']!),
                    const SizedBox(width: 8),
                    Text(cat['label']!),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    onCategorySelected(cat['id']!);
                  }
                },
                selectedColor: isDark
                    ? AppTheme.primary.withValues(alpha: 0.2)
                    : Colors.green.shade50,
                backgroundColor: isDark ? AppTheme.surfaceVariant : Colors.white,
                labelStyle: TextStyle(
                  color: isSelected
                      ? AppTheme.primary
                      : (isDark ? Colors.grey.shade400 : AppTheme.textGrey),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: isSelected
                        ? AppTheme.primary
                        : (isDark
                            ? AppTheme.borderDark
                            : AppTheme.borderLight),
                  ),
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
          if (selectedCategory == 'other') ...[
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Nhập lý do cụ thể của con nhé...',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey.shade500 : AppTheme.textGrey,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: isDark ? AppTheme.surfaceVariant : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade200,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade200,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppTheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

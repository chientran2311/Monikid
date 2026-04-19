import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/models/entities/category_model.dart';

class CategoryDialog extends HookConsumerWidget {
  const CategoryDialog({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
    this.showAllOption = true,
    this.categoryType,
  });

  final String? selectedCategory;
  final void Function(CategoryModel?) onCategorySelected;
  final bool showAllOption;
  final String? categoryType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final categoriesAsync = ref.watch(categoryStreamProvider);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                height: 6,
                width: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _dialogTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: categoriesAsync.when(
                data: (categories) {
                  final filteredCategories = filterCategoriesByType(
                    categories,
                    categoryType,
                  );
                  final allCategories = [
                    if (showAllOption)
                      const CategoryModel(
                        id: 'all',
                        label: 'Tất cả',
                        icon: '📝',
                        colorHex: '0xFF9E9E9E',
                        isDefault: true,
                      ),
                    ...filteredCategories,
                  ];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                      itemCount: allCategories.length,
                      itemBuilder: (context, index) {
                        final category = allCategories[index];
                        final isSelected = category.id == 'all'
                            ? selectedCategory == null
                            : selectedCategory == category.label ||
                                  selectedCategory ==
                                      transactionCategoryKeyForCategory(category);

                        Color baseColor = Colors.grey;
                        if (category.colorHex != null) {
                          try {
                            baseColor = Color(int.parse(category.colorHex!));
                          } catch (_) {}
                        }

                        return GestureDetector(
                          onTap: () {
                            onCategorySelected(category.id == 'all' ? null : category);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? baseColor.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? baseColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? baseColor.withOpacity(0.2)
                                        : isDark
                                        ? const Color(0xFF334155)
                                        : baseColor.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          category.icon,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      if (isSelected)
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: baseColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.label,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? textColor
                                        : isDark
                                        ? const Color(0xFFCBD5E1)
                                        : const Color(0xFF475569),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const SizedBox(
                  height: 240,
                  child: CategoryDialogLoadingSkeleton(),
                ),
                error: (error, _) => SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'Lỗi: $error',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Đóng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _dialogTitle {
    if (categoryType == 'income') {
      return 'Chọn danh mục thu';
    }
    if (categoryType == 'expense') {
      return 'Chọn danh mục chi';
    }
    return 'Chọn danh mục';
  }
}

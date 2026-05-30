import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/add_custom_category_sheet.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/category/custom_category_repository.dart';

class CategoryDialog extends HookConsumerWidget {
  const CategoryDialog({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
    this.showAllOption = true,
    this.categoryType,
    this.showAddButton = true,
  });

  final String? selectedCategory;
  final void Function(CategoryModel?) onCategorySelected;
  final bool showAllOption;
  final String? categoryType;
  final bool showAddButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final categoriesAsync = ref.watch(categoryStreamProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    final localSelectedCategory = useState<CategoryModel?>(null);
    final isInitialized = useState<bool>(false);

    String getDialogTitle() {
      if (categoryType == 'income') return s.customCategorySelectTitleIncome;
      if (categoryType == 'expense') return s.customCategorySelectTitleExpense;
      return s.customCategorySelectTitle;
    }

    void confirm() {
      if (localSelectedCategory.value != null) {
        onCategorySelected(
          localSelectedCategory.value!.id == 'all'
              ? null
              : localSelectedCategory.value,
        );
      }
      context.pop();
    }

    return GestureDetector(
      onTap: () => context.pop(),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: screenHeight * 0.62,
                decoration: BoxDecoration(
                  color: sheetColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      // Drag handle
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppTheme.textMuted.withValues(alpha: 0.4)
                                : AppTheme.textGrey.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(99.r),
                          ),
                        ),
                      ),
                      // Header: title centered, "Xong" button right
                      SizedBox(
                        height: 56.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                getDialogTitle(),
                                style: context.typo.subtitle.small.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20.w,
                              child: GestureDetector(
                                onTap: confirm,
                                child: Text(
                                  s.customCategoryConfirmSelection,
                                  style: context.typo.subtitle.small.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        thickness: 0.5,
                        color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                      ),
                      // Category grid
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

                            if (!isInitialized.value) {
                              final initial = allCategories
                                  .cast<CategoryModel?>()
                                  .firstWhere(
                                    (c) {
                                      if (c?.id == 'all') return selectedCategory == null;
                                      return selectedCategory == c?.label ||
                                          selectedCategory ==
                                              transactionCategoryKeyForCategory(c!);
                                    },
                                    orElse: () => null,
                                  );
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                localSelectedCategory.value = initial;
                                isInitialized.value = true;
                              });
                            }

                            return SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 8.h),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                  childAspectRatio: 0.88,
                                ),
                                itemCount: allCategories.length + (showAddButton ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (showAddButton && index == allCategories.length) {
                                    return AddNewCategoryItemWidget(
                                      isDark: isDark,
                                      onTap: () => _showAddCategorySheet(
                                        context,
                                        ref,
                                        categories,
                                        selectedCategory: selectedCategory,
                                        onCategorySelected: onCategorySelected,
                                        showAllOption: showAllOption,
                                        categoryType: categoryType,
                                        showAddButton: showAddButton,
                                      ),
                                    );
                                  }
                                  final category = allCategories[index];
                                  final isSelected =
                                      localSelectedCategory.value?.id == category.id;
                                  return CategoryItemWidget(
                                    category: category,
                                    isSelected: isSelected,
                                    isDark: isDark,
                                    onTap: () => localSelectedCategory.value = category,
                                    onDelete: () =>
                                        _confirmDeleteCategory(context, ref, category),
                                  );
                                },
                              ),
                            );
                          },
                          loading: () => SizedBox(
                            height: 240.h,
                            child: const CategoryDialogLoadingSkeleton(),
                          ),
                          error: (error, _) => SizedBox(
                            height: 200.h,
                            child: Center(
                              child: Text(
                                'Lỗi: $error',
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showAddCategorySheet(
  BuildContext context,
  WidgetRef ref,
  List<CategoryModel> categories, {
  required String? selectedCategory,
  required void Function(CategoryModel?) onCategorySelected,
  required bool showAllOption,
  required String? categoryType,
  required bool showAddButton,
}) async {
  final customCount = categories.where((c) => !c.isDefault).length;
  if (customCount >= 5) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.customCategoryLimitReached)),
    );
    return;
  }

  context.pop();

  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => AddCustomCategorySheet(
      onAdded: (label) async {
        final userId = ref.read(authSessionProvider).user?.uid;
        if (userId == null) return;
        await ref.read(customCategoryRepositoryProvider).addCategory(
          userId: userId,
          label: label,
          type: 'expense',
          icon: '📦',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.customCategoryCreated)),
          );
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (c) => CategoryDialog(
              selectedCategory: selectedCategory,
              onCategorySelected: onCategorySelected,
              showAllOption: showAllOption,
              categoryType: categoryType,
              showAddButton: showAddButton,
            ),
          );
        }
      },
    ),
  );
}

Future<void> _confirmDeleteCategory(
  BuildContext context,
  WidgetRef ref,
  CategoryModel category,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(context.l10n.customCategoryConfirmDelete),
      content: Text(context.l10n.customCategoryConfirmDeleteBody),
      actions: [
        TextButton(
          onPressed: () => ctx.pop(false),
          child: Text(context.l10n.customCategoryCancel),
        ),
        TextButton(
          onPressed: () => ctx.pop(true),
          child: Text(context.l10n.customCategoryDeleted),
        ),
      ],
    ),
  );

  if (confirmed != true) return;

  final userId = ref.read(authSessionProvider).user?.uid;
  if (userId == null) return;

  await ref.read(customCategoryRepositoryProvider).deleteCategory(
    userId: userId,
    categoryId: category.id,
  );

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.customCategoryDeleted)),
    );
  }
}


class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
    required this.isDark,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                      ? AppTheme.primaryLight.withValues(alpha: 0.15)
                      : AppTheme.primaryLight)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppTheme.surfaceDark : Colors.white)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppTheme.primary.withValues(alpha: 0.15),
                              blurRadius: 12.r,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category.icon,
                    style: context.typo.title.big,
                  ),
                ),
                SizedBox(height: 8.h),
                Flexible(
                  child: Text(
                    category.label,
                    style: context.typo.body.small.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!category.isDefault)
          Positioned(
            top: -4,
            right: -4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? AppTheme.surfaceDark : Colors.white,
                    width: 2,
                  ),
                ),
                child: Icon(Icons.close, color: Colors.white, size: 10.r),
              ),
            ),
          ),
      ],
    );
  }
}

class AddNewCategoryItemWidget extends StatelessWidget {
  const AddNewCategoryItemWidget({
    super.key,
    required this.onTap,
    required this.isDark,
  });

  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final labelColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: DashedBorderPainter(
                color: borderColor,
                radius: 16.r,
                strokeWidth: 2,
              ),
              child: SizedBox(
                width: 60.w,
                height: 60.w,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: labelColor,
                    size: 24.r,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              s.customCategoryAddNew,
              style: context.typo.body.small.copyWith(
                fontWeight: FontWeight.w600,
                color: labelColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashWidth;
  final double radius;

  DashedBorderPainter({
    this.color = AppTheme.textGrey,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.dashWidth = 5.0,
    this.radius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path();
    if (radius > 0) {
      path.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius)));
    } else {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    Path dashedPath = Path();
    for (PathMetric measurePath in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < measurePath.length) {
        dashedPath.addPath(
          measurePath.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += gap;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/add_custom_category_sheet.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/category_delete_drop_zone.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/draggable_category_item.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/category/add_custom_category_repository.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';

const _allCategory = CategoryModel(
  id: 'all',
  label: 'Tất cả',
  icon: '📝',
  colorHex: '0xFF9E9E9E',
  isDefault: true,
);

String _getDialogTitle(String? categoryType, AppLocalizations s) {
  if (categoryType == 'income') return s.customCategorySelectTitleIncome;
  if (categoryType == 'expense') return s.customCategorySelectTitleExpense;
  return s.customCategorySelectTitle;
}

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
    final isInitialized = useRef(false);
    final isDragging = useState<bool>(false);

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
                child: Stack(
                  children: [
                    SafeArea(
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
                                _getDialogTitle(categoryType, s),
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
                              if (showAllOption) _allCategory,
                              ...filteredCategories,
                            ];

                            if (!isInitialized.value) {
                              isInitialized.value = true;
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
                              });
                            }

                            return GridView.builder(
                              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 8.h),
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
                                final isCustom =
                                    !category.isDefault && category.id != 'all';
                                if (isCustom) {
                                  return DraggableCategoryItem(
                                    category: category,
                                    isSelected: isSelected,
                                    isDark: isDark,
                                    jiggle: isDragging.value,
                                    onTap: () =>
                                        localSelectedCategory.value = category,
                                    onDragStarted: () => isDragging.value = true,
                                    onDragEnded: () => isDragging.value = false,
                                  );
                                }
                                return CategoryItemWidget(
                                  category: category,
                                  isSelected: isSelected,
                                  isDark: isDark,
                                  onTap: () => localSelectedCategory.value = category,
                                );
                              },
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
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: CategoryDeleteDropZone(
                        visible: isDragging.value,
                        isDark: isDark,
                        onCategoryDropped: (category) =>
                            _confirmDeleteCategory(context, ref, category),
                      ),
                    ),
                  ],
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

  if (!context.mounted) return;

  // Show AddCustomCategorySheet on top of CategoryDialog — no pop/reopen needed.
  // The stream in CategoryDialog updates automatically when Firestore writes.
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => AddCustomCategorySheet(
      initialType: categoryType ?? 'expense',
      onAdded: (label, icon, type) async {
        final userId = ref.read(authSessionProvider).user?.uid;
        if (userId == null) return;
        await ref.read(customCategoryRepositoryProvider).addCategory(
          userId: userId,
          label: label,
          type: type,
          icon: icon,
        );
        if (ctx.mounted) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text(ctx.l10n.customCategoryCreated)),
          );
          ctx.pop();
        }
      },
    ),
  );
}

void _confirmDeleteCategory(
  BuildContext context,
  WidgetRef ref,
  CategoryModel category,
) {
  final s = context.l10n;
  showDialog<void>(
    context: context,
    builder: (_) => ConfirmDialog(
      title: s.customCategoryConfirmDelete,
      subtitle: s.customCategoryConfirmDeleteBody,
      confirmLabel: s.customCategoryDelete,
      cancelLabel: s.customCategoryCancel,
      isDestructive: true,
      icon: Icons.delete_outline,
      onConfirm: () async {
        final userId = ref.read(authSessionProvider).user?.uid;
        if (userId == null) return;
        try {
          await ref.read(customCategoryRepositoryProvider).deleteCategory(
                userId: userId,
                categoryId: category.id,
              );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.customCategoryDeleted)),
            );
          }
        } catch (_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(s.customCategoryDeleteFailed)),
            );
          }
        }
      },
    ),
  );
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 100.w,
        height: 100.w,
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                      ? AppTheme.primaryLight.withValues(alpha: 0.15)
                      : AppTheme.primaryLight)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
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
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppTheme.surfaceDark : Colors.white)
                        : Colors.transparent,
                    shape: BoxShape.circle,
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

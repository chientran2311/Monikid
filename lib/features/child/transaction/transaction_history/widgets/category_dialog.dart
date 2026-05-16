import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
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
    final surfaceColor = isDark ? const Color(0xFF1C1C1E) : AppTheme.backgroundLight;
    final cardColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final categoriesAsync = ref.watch(categoryStreamProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    final localSelectedCategory = useState<CategoryModel?>(null);
    final isInitialized = useState<bool>(false);

    String getDialogTitle() {
      if (categoryType == 'income') {
        return s.customCategorySelectTitleIncome;
      }
      if (categoryType == 'expense') {
        return s.customCategorySelectTitleExpense;
      }
      return s.customCategorySelectTitle;
    }

    return SizedBox(
      height: screenHeight * 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 0),
                height: 5.h,
                width: 36.w,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getDialogTitle(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                  InkWell(
                    onTap: () => context.pop(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppTheme.surfaceDark
                            : const Color(0xFFEEEDF3),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close,
                        size: 16.r,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF6E6E73),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
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
                    final initial = allCategories.cast<CategoryModel?>().firstWhere(
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
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: allCategories.length + (showAddButton ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (showAddButton && index == allCategories.length) {
                          return AddNewCategoryItemWidget(
                            isDark: isDark,
                            onTap: () => _showAddCategorySheet(context, ref, categories),
                          );
                        }

                        final category = allCategories[index];
                        final isSelected = localSelectedCategory.value?.id == category.id;

                        return CategoryItemWidget(
                          category: category,
                          isSelected: isSelected,
                          isDark: isDark,
                          cardColor: cardColor,
                          onTap: () {
                            localSelectedCategory.value = category;
                          },
                          onDelete: () => _confirmDeleteCategory(context, ref, category),
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
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
              decoration: BoxDecoration(
                color: cardColor,
                border: Border(
                  top: BorderSide(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                    width: 0.5,
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (localSelectedCategory.value != null) {
                    onCategorySelected(localSelectedCategory.value!.id == 'all' ? null : localSelectedCategory.value);
                  }
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: Size(double.infinity, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  s.customCategoryConfirmSelection,
                  style: TextStyle(
                    fontSize: 17.sp, 
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

Future<void> _showAddCategorySheet(
  BuildContext context,
  WidgetRef ref,
  List<CategoryModel> categories,
) async {
  final customCount = categories.where((c) => !c.isDefault).length;
  if (customCount >= 5) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.customCategoryLimitReached)),
    );
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _AddCategorySheet(onAdded: (label, type) async {
      final userId = ref.read(authSessionProvider).user?.uid;
      if (userId == null) return;
      await ref
          .read(customCategoryRepositoryProvider)
          .addCategory(userId: userId, label: label, type: type);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.customCategoryCreated)),
        );
      }
    }),
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

class _AddCategorySheet extends StatefulWidget {
  const _AddCategorySheet({required this.onAdded});
  final Future<void> Function(String label, String type) onAdded;

  @override
  State<_AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<_AddCategorySheet> {
  final _labelController = TextEditingController();
  String _type = 'expense';
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _labelController,
            maxLength: 40,
            decoration: InputDecoration(
              hintText: s.customCategoryLabelHint,
              errorText: _error,
            ),
            autofocus: true,
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'expense', label: Text(s.customCategoryTypeExpense)),
              ButtonSegment(value: 'income', label: Text(s.customCategoryTypeIncome)),
            ],
            selected: {_type},
            onSelectionChanged: (v) => setState(() => _type = v.first),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(s.customCategoryConfirm),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final label = _labelController.text.trim();
    if (label.isEmpty) {
      setState(() => _error = 'Required');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    await widget.onAdded(label, _type);
    if (mounted) context.pop();
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
    required this.cardColor,
    required this.isDark,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Color cardColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    Color baseColor = Colors.grey;
    if (category.colorHex != null) {
      try {
        baseColor = Color(int.parse(category.colorHex!));
      } catch (_) {}
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: isSelected ? baseColor.withValues(alpha: 0.06) : cardColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected ? baseColor : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                  decoration: BoxDecoration(
                    color: baseColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                    alignment: Alignment.center,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Text(
                            category.icon,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: -3.h,
                            right: -3.w,
                            child: Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                color: baseColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: baseColor.withValues(alpha: 0.4),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10.r,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Flexible(
                    child: Text(
                      category.label,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? baseColor
                            : isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF3D4A3C),
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
                  border: Border.all(color: cardColor, width: 2),
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
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: isDark ? const Color(0xFF475569) : const Color(0xFFC5C5CA),
            radius: 16.r,
            strokeWidth: 1.5,
          ),
          child: Container(
            padding: EdgeInsets.all(6.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: DashedBorderPainter(
                    color: isDark ? const Color(0xFF475569) : const Color(0xFFC5C5CA),
                    radius: 18.r,
                    strokeWidth: 1.5,
                  ),
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFFAEAEC2),
                      size: 20.r,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Flexible(
                  child: Text(
                    s.customCategoryAdd,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFFAEAEC2),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
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
    this.color = Colors.grey,
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

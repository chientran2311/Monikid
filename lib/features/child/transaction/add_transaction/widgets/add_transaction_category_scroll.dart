import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/models/entities/category_model.dart';

class AddTransactionCategoryScroll extends StatelessWidget {
  const AddTransactionCategoryScroll({
    super.key,
    required this.categories,
    required this.selectedCategoryKey,
    required this.onCategorySelected,
  });

  final List<CategoryModel> categories;
  final String selectedCategoryKey;
  final void Function(CategoryModel) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive =
              transactionCategoryKeyForCategory(category) == selectedCategoryKey;
          return _CategoryChip(
            category: category,
            isActive: isActive,
            onTap: () => onCategorySelected(category),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.category,
    required this.isActive,
    required this.onTap,
  });

  final CategoryModel category;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 60.r,
            height: 60.r,
            transform: Matrix4.translationValues(0, isActive ? -2.h : 0, 0),
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.primaryLight
                  : isDark
                      ? AppTheme.surfaceDark
                      : AppTheme.surfaceLight,
              border: Border.all(
                color: isActive
                    ? AppTheme.primary
                    : isDark
                        ? AppTheme.borderDark
                        : AppTheme.borderLight,
                width: 1.5.r,
              ),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        offset: Offset(0, 8.h),
                        blurRadius: 16.r,
                        color: AppTheme.primary.withValues(alpha: 0.1),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(category.icon, style: TextStyle(fontSize: 26.sp)),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            category.label,
            style: context.typo.caption.big.copyWith(
              color: isActive ? AppTheme.primary : AppTheme.textGrey,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

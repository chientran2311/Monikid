import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/features/parent/transaction_par/widgets/month_picker_bottom_sheet.dart';

class TransactionFilterBar extends ConsumerWidget {
  final bool isDark;

  const TransactionFilterBar({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(transactionHistoryProvider.notifier);

    final selectedDate = ref.watch(
      transactionHistoryProvider.select((v) => v.selectedDate),
    );
    final selectedCategory = ref.watch(
      transactionHistoryProvider.select((v) => v.selectedCategoryKey),
    );
    final transactionTypeFilter = ref.watch(
      transactionHistoryProvider.select((v) => v.transactionTypeFilter),
    );

    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;
    final selectedCategoryModel = findCategoryByTransactionKey(
      categories,
      selectedCategory,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MonthPickerChip(
                selectedDate: selectedDate,
                isDark: isDark,
                onTap: () => _showMonthPicker(context, selectedDate, notifier),
                onClear: () => notifier.getTransByDate(null),
              ),
              _CategoryFilterButton(
                selectedCategory: selectedCategory,
                isDark: isDark,
                onTap: () => _showCategoryDialog(
                  context,
                  selectedCategory,
                  notifier,
                  isDark,
                  transactionTypeFilter,
                ),
              ),
            ],
          ),
        ),
        if (selectedCategory != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                _ActiveCategoryChip(
                  selectedCategoryModel: selectedCategoryModel,
                  selectedCategory: selectedCategory,
                  categories: categories,
                  onClear: () => notifier.getTransByCategory(null),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _showMonthPicker(
    BuildContext context,
    DateTime? currentDate,
    TransactionHistory notifier,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: isDark ? AppTheme.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => MonthPickerBottomSheet(
        currentDate: currentDate,
        isDark: isDark,
        onDateSelected: (date) {
          notifier.getTransByDate(date);
          Navigator.of(ctx).pop();
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _showCategoryDialog(
    BuildContext context,
    String? currentCategory,
    TransactionHistory notifier,
    bool isDark,
    String? transactionTypeFilter,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CategoryDialog(
        selectedCategory: currentCategory,
        categoryType: transactionTypeFilter == 'all' || transactionTypeFilter == null ? null : transactionTypeFilter,
        showAddButton: false,
        onCategorySelected: (category) => notifier.getTransByCategory(
          category != null ? transactionCategoryKeyForCategory(category) : null,
        ),
      ),
    );
  }
}

class _MonthPickerChip extends StatelessWidget {
  final DateTime? selectedDate;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const _MonthPickerChip({
    required this.selectedDate,
    required this.isDark,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.primary.withValues(alpha: 0.2) : const Color(0xFFeaf2eb),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 20,
              color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              selectedDate == null
                  ? 'Chọn ngày'
                  : DateFormat('dd/MM/yyyy').format(selectedDate!),
              style: context.typo.body.medium.copyWith(
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
            ),
            ),
            if (selectedDate != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onClear,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
                ),
              ),
            ] else ...[
              const SizedBox(width: 4),
              Icon(
                Icons.expand_more,
                size: 18,
                color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CategoryFilterButton extends StatelessWidget {
  final String? selectedCategory;
  final bool isDark;
  final VoidCallback onTap;

  const _CategoryFilterButton({
    required this.selectedCategory,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selectedCategory != null
              ? AppTheme.primary.withValues(alpha: 0.15)
              : isDark
                  ? AppTheme.surfaceVariant
                  : AppTheme.surfaceVeryLight,
          borderRadius: BorderRadius.circular(8),
          border: selectedCategory != null
              ? Border.all(color: AppTheme.primary.withValues(alpha: 0.4))
              : null,
        ),
        child: Icon(
          Icons.filter_list,
          size: 20,
          color: selectedCategory != null
              ? AppTheme.primary
              : isDark
                  ? AppTheme.textMuted
                  : AppTheme.textDark,
        ),
      ),
    );
  }
}

class _ActiveCategoryChip extends StatelessWidget {
  final CategoryModel? selectedCategoryModel;
  final String selectedCategory;
  final List<CategoryModel> categories;
  final VoidCallback onClear;

  const _ActiveCategoryChip({
    required this.selectedCategoryModel,
    required this.selectedCategory,
    required this.categories,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClear,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              categories
                  .firstWhere(
                    (c) => c.label == selectedCategoryModel?.label,
                    orElse: () => const CategoryModel(id: '', label: '', icon: '📦'),
                  )
                  .icon,
              style: context.typo.body.small,
            ),
            const SizedBox(width: 4),
            Text(
              selectedCategoryModel?.label ?? selectedCategory,
              style: context.typo.caption.big.copyWith(
              color: AppTheme.textWhite,
              fontWeight: FontWeight.w500,
            ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.close, size: 14, color: AppTheme.textWhite),
          ],
        ),
      ),
    );
  }
}

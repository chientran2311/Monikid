import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/calendar_dialog.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/models/entities/category_model.dart';

class TransactionFilterBar extends ConsumerWidget {
  const TransactionFilterBar({
    required this.isDark,
    super.key,
  });

  final bool isDark;

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
              // Month picker chip
              GestureDetector(
                onTap: () => _showMonthPicker(context, selectedDate, notifier),
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
                            : DateFormat('dd/MM/yyyy').format(selectedDate),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFFeaf2eb) : AppTheme.primary,
                        ),
                      ),
                      if (selectedDate != null) ...[
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => notifier.getTransByDate(null),
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
              ),
              // Filter icon (category)
              GestureDetector(
                onTap: () => _showCategoryDialog(
                  context,
                  selectedCategory,
                  notifier,
                  isDark,
                  transactionTypeFilter,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedCategory != null
                        ? AppTheme.primary.withValues(alpha: 0.15)
                        : isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
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
                        : isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Active category chip
        if (selectedCategory != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => notifier.getTransByCategory(null),
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
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          selectedCategoryModel?.label ?? selectedCategory,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.close, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CalendarDialog(
        initialMonth: currentDate ?? DateTime.now(),
        onDateConfirmed: (date) => notifier.getTransByDate(date),
      ),
    );
  }

  void _showCategoryDialog(
    BuildContext context,
    String? selectedCategory,
    TransactionHistory notifier,
    bool isDark,
    String? transactionTypeFilter,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CategoryDialog(
        selectedCategory: selectedCategory,
        onCategorySelected: (category) {
          final categoryKey = category != null 
              ? transactionCategoryKeyForCategory(category) 
              : null;
          notifier.getTransByCategory(categoryKey);
        },
        categoryType: transactionTypeFilter == 'all' || transactionTypeFilter == null ? null : transactionTypeFilter,
      ),
    );
  }
}

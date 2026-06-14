import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/providers/transaction_filter_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/calendar_dialog.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/category_dialog.dart';

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
      transactionFilterNotifierProvider.select((v) => v.selectedDate),
    );
    final selectedCategory = ref.watch(
      transactionFilterNotifierProvider.select((v) => v.selectedCategoryKey),
    );
    final transactionTypeFilter = ref.watch(
      transactionFilterNotifierProvider.select((v) => v.transactionTypeFilter),
    );

    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;
    final selectedCategoryModel = findCategoryByTransactionKey(
      categories,
      selectedCategory,
    );

    final dateLabel = selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedDate)
        : null;

    final categoryLabel = selectedCategoryModel?.label ?? selectedCategory;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Row(
        children: [
          Expanded(
            child: _FilterButton(
              emoji: '📅',
              label: 'Thời gian',
              activeLabel: dateLabel,
              isDark: isDark,
              onTap: () => _showMonthPicker(context, selectedDate, notifier),
              onClear: selectedDate != null
                  ? () => notifier.getTransByDate(null)
                  : null,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _FilterButton(
              emoji: '🗂',
              label: 'Danh mục',
              activeLabel: categoryLabel,
              isDark: isDark,
              onTap: () => _showCategoryDialog(
                context,
                selectedCategory,
                notifier,
                isDark,
                transactionTypeFilter,
              ),
              onClear: selectedCategory != null
                  ? () => notifier.getTransByCategory(null)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthPicker(
    BuildContext context,
    DateTime? currentDate,
    TransactionHistory notifier,
  ) {
    showModalBottomSheet<void>(
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
    showModalBottomSheet<void>(
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
        categoryType: transactionTypeFilter == 'all' || transactionTypeFilter == null
            ? null
            : transactionTypeFilter,
      ),
    );
  }
}

class _FilterButton extends StatefulWidget {
  const _FilterButton({
    required this.emoji,
    required this.label,
    required this.activeLabel,
    required this.isDark,
    required this.onTap,
    this.onClear,
  });

  final String emoji;
  final String label;
  final String? activeLabel;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.activeLabel != null;
    final displayLabel = widget.activeLabel ?? widget.label;

    final bgColor = widget.isDark
        ? (isActive
            ? AppTheme.primary.withValues(alpha: 0.18)
            : AppTheme.surfaceDark.withValues(alpha: 0.84))
        : Colors.white.withValues(alpha: 0.84);

    final borderColor = widget.isDark
        ? (isActive
            ? AppTheme.primary.withValues(alpha: 0.4)
            : AppTheme.borderDark)
        : AppTheme.primary.withValues(alpha: 0.16);

    final labelColor = widget.isDark
        ? (isActive ? AppTheme.surfaceLightGreen : AppTheme.textWhite)
        : AppTheme.textBlack;

    final mutedColor = widget.isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return GestureDetector(
      onTap: isActive ? null : widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              constraints: BoxConstraints(minHeight: 48.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.06),
                    blurRadius: 28.r,
                    offset: Offset(0, 12.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          widget.emoji,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            displayLabel,
                            style: AppTextStyleFactory.style(
                              size: AppFontSizes.bodyMedium,
                              weight: FontWeight.w800,
                              color: isActive ? AppTheme.primary : labelColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (isActive && widget.onClear != null)
                    GestureDetector(
                      onTap: widget.onClear,
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.close,
                        size: 16.r,
                        color: AppTheme.primary,
                      ),
                    )
                  else
                    Text(
                      '›',
                      style: AppTextStyleFactory.style(
                        size: AppFontSizes.bodyMedium,
                        weight: FontWeight.w800,
                        color: mutedColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

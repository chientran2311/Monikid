import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/dev_tools/dev_tools_state.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class TransactionMockCard extends StatelessWidget {
  const TransactionMockCard({
    super.key,
    required this.status,
    this.message,
    required this.selectedDate,
    required this.transactionType,
    required this.selectedCategoryId,
    required this.onDateChanged,
    required this.onTypeChanged,
    required this.onCategoryChanged,
    required this.onAddTransaction,
  });

  final DevToolsOpStatus status;
  final String? message;
  final DateTime selectedDate;
  final String transactionType;
  final String selectedCategoryId;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onAddTransaction;

  List<CategoryModel> get _filteredCategories =>
      defaultCategories.where((c) => c.type == transactionType).toList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final isLoading = status == DevToolsOpStatus.loading;

    final selectedCategory = _filteredCategories.firstWhere(
      (c) => c.id == selectedCategoryId,
      orElse: () => _filteredCategories.first,
    );

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.receipt_long_outlined, color: AppTheme.primary, size: 20.r),
              ),
              SizedBox(width: 12.w),
              Text(
                'Transaction Mock',
                style: context.typo.subtitle.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Date picker row
          _FieldRow(
            label: 'Ngày',
            isDark: isDark,
            child: GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) onDateChanged(picked);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: context.typo.body.small.copyWith(color: textColor),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.calendar_today_rounded, size: 14.r, color: mutedColor),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Type toggle row
          _FieldRow(
            label: 'Loại',
            isDark: isDark,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypeChip(
                  label: 'Chi tiêu',
                  isSelected: transactionType == 'expense',
                  isDark: isDark,
                  onTap: () => onTypeChanged('expense'),
                ),
                SizedBox(width: 8.w),
                _TypeChip(
                  label: 'Thu nhập',
                  isSelected: transactionType == 'income',
                  isDark: isDark,
                  onTap: () => onTypeChanged('income'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // Category dropdown row
          _FieldRow(
            label: 'Danh mục',
            isDark: isDark,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: borderColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory.id,
                  isDense: true,
                  dropdownColor: isDark ? AppTheme.surfaceDark : Colors.white,
                  style: context.typo.body.small.copyWith(color: textColor),
                  onChanged: (id) {
                    if (id != null) onCategoryChanged(id);
                  },
                  items: _filteredCategories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Text('${c.icon} ${c.label}'),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          PrimaryButton(
            title: 'Thêm Mock Transaction',
            isLoading: isLoading,
            onTap: isLoading ? null : onAddTransaction,
          ),
          if (message != null) ...[
            SizedBox(height: 8.h),
            Text(
              message!,
              style: context.typo.caption.medium.copyWith(
                color: status == DevToolsOpStatus.error
                    ? Colors.redAccent
                    : AppTheme.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.isDark,
    required this.child,
  });

  final String label;
  final bool isDark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    return Row(
      children: [
        SizedBox(
          width: 72.w,
          child: Text(
            label,
            style: context.typo.body.small.copyWith(color: mutedColor),
          ),
        ),
        child,
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary
                : (isDark ? AppTheme.borderDark : AppTheme.borderLight),
          ),
        ),
        child: Text(
          label,
          style: context.typo.body.small.copyWith(
            color: isSelected
                ? Colors.white
                : (isDark ? AppTheme.textMuted : AppTheme.textGrey),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

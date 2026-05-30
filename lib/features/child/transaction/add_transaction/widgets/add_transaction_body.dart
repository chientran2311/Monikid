import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_amount_input.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_category_scroll.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_form_fields.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_type_selector.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/models/entities/category_model.dart';

class AddTransactionBody extends StatelessWidget {
  const AddTransactionBody({
    super.key,
    required this.transactionType,
    required this.onTypeChanged,
    required this.expenseLabel,
    required this.incomeLabel,
    required this.amountController,
    required this.categories,
    required this.selectedCategoryKey,
    required this.onCategoryChipSelected,
    required this.selectedDate,
    required this.noteController,
    required this.evidenceImageBytes,
    required this.evidenceImageFileName,
    required this.hasEvidenceImageSelection,
    required this.onDateTap,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.isDark,
    required this.surfaceColor,
    required this.textColor,
    required this.enabled,
  });

  final int transactionType;
  final void Function(int) onTypeChanged;
  final String expenseLabel;
  final String incomeLabel;
  final TextEditingController amountController;
  final List<CategoryModel> categories;
  final String selectedCategoryKey;
  final void Function(CategoryModel) onCategoryChipSelected;
  final DateTime selectedDate;
  final TextEditingController noteController;
  final List<int>? evidenceImageBytes;
  final String? evidenceImageFileName;
  final bool hasEvidenceImageSelection;
  final VoidCallback onDateTap;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final bool isDark;
  final Color surfaceColor;
  final Color textColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final currentType = transactionType == 0 ? 'expense' : 'income';
    final filteredCategories = filterCategoriesByType(categories, currentType);

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TransactionTypeSelector(
              selectedIndex: transactionType,
              onTypeChanged: onTypeChanged,
              expenseLabel: expenseLabel,
              incomeLabel: incomeLabel,
              isDark: isDark,
              surfaceColor: surfaceColor,
              enabled: enabled,
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AddTransactionAmountInput(
              controller: amountController,
              enabled: enabled,
              textColor: textColor,
            ),
          ),
          SizedBox(height: 32.h),
          // Category section header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              s.transactionCategoryLabel.toUpperCase(),
              style: context.typo.caption.big.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textGrey,
                letterSpacing: 0.65,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Category scroll — no horizontal padding so chips are flush with edges
          AddTransactionCategoryScroll(
            categories: filteredCategories,
            selectedCategoryKey: selectedCategoryKey,
            onCategorySelected: enabled ? onCategoryChipSelected : (_) {},
          ),
          SizedBox(height: 32.h),
          // Details section header
          Padding(
            padding: EdgeInsets.only(left: 24.w, bottom: 12.h),
            child: Text(
              s.transactionDetailsSection.toUpperCase(),
              style: context.typo.caption.big.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textGrey,
                letterSpacing: 0.65,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TransactionFormFields(
              selectedDate: selectedDate,
              noteController: noteController,
              evidenceImageBytes: evidenceImageBytes,
              evidenceImageFileName: evidenceImageFileName,
              hasEvidenceImageSelection: hasEvidenceImageSelection,
              onDateTap: onDateTap,
              onPickImage: onPickImage,
              onRemoveImage: onRemoveImage,
              isDark: isDark,
              surfaceColor: surfaceColor,
              textColor: textColor,
              enabled: enabled,
            ),
          ),
        ],
      ),
    );
  }
}

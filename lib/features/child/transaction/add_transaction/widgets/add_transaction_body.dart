import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_category_scroll.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/transaction_section_label.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/shared/widgets/switch_two_item.dart';
import 'package:monikid/shared/widgets/transaction_amount_section.dart';
import 'package:monikid/shared/widgets/transaction_detail_card.dart';

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
    required this.hasEvidenceImageSelection,
    required this.onDateTap,
    required this.onPickImage,
    required this.onRemoveImage,
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
  final bool hasEvidenceImageSelection;
  final VoidCallback onDateTap;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final currentType = transactionType == 0 ? 'expense' : 'income';
    final filteredCategories = filterCategoriesByType(categories, currentType);
    final previewBytes = evidenceImageBytes != null
        ? Uint8List.fromList(evidenceImageBytes!)
        : null;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TransactionAmountSection(
              controller: amountController,
              enabled: enabled,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SwitchTwoItem(
              title1: expenseLabel,
              title2: incomeLabel,
              selectedIndex: transactionType,
              onChanged: onTypeChanged,
            ),
          ),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                TransactionSectionLabel(text: s.transactionCategoryLabel),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          AddTransactionCategoryScroll(
            categories: filteredCategories,
            selectedCategoryKey: selectedCategoryKey,
            onCategorySelected: enabled ? onCategoryChipSelected : (_) {},
          ),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TransactionSectionLabel(text: s.transactionDetailSectionLabel),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TransactionDetailCard(
              selectedDate: selectedDate,
              noteController: noteController,
              enabled: enabled,
              onSelectDate: onDateTap,
              onPickImage: onPickImage,
              noteHint: s.addTransactionNoteHint,
              previewBytes: previewBytes,
              onRemoveImage: hasEvidenceImageSelection ? onRemoveImage : null,
            ),
          ),
        ],
      ),
    );
  }
}

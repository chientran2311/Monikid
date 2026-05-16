import 'package:flutter/material.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_amount_section.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_form_fields.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_type_selector.dart';

class AddTransactionBody extends StatelessWidget {
  const AddTransactionBody({
    super.key,
    required this.transactionType,
    required this.onTypeChanged,
    required this.expenseLabel,
    required this.incomeLabel,
    required this.amountController,
    required this.selectedCategory,
    required this.selectedEmoji,
    required this.selectedDate,
    required this.noteController,
    required this.evidenceImageBytes,
    required this.evidenceImageFileName,
    required this.hasEvidenceImageSelection,
    required this.onCategoryTap,
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
  final String selectedCategory;
  final String selectedEmoji;
  final DateTime selectedDate;
  final TextEditingController noteController;
  final List<int>? evidenceImageBytes;
  final String? evidenceImageFileName;
  final bool hasEvidenceImageSelection;
  final VoidCallback onCategoryTap;
  final VoidCallback onDateTap;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final bool isDark;
  final Color surfaceColor;
  final Color textColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: 120,
      ),
      child: Column(
        children: [
          TransactionTypeSelector(
            selectedIndex: transactionType,
            onTypeChanged: onTypeChanged,
            expenseLabel: expenseLabel,
            incomeLabel: incomeLabel,
            isDark: isDark,
            surfaceColor: surfaceColor,
            enabled: enabled,
          ),
          const SizedBox(height: 32),
          AddTransactionAmountSection(
            controller: amountController,
            enabled: enabled,
            textColor: textColor,
          ),
          const SizedBox(height: 32),
          TransactionFormFields(
            selectedCategory: selectedCategory,
            selectedEmoji: selectedEmoji,
            selectedDate: selectedDate,
            noteController: noteController,
            evidenceImageBytes: evidenceImageBytes,
            evidenceImageFileName: evidenceImageFileName,
            hasEvidenceImageSelection: hasEvidenceImageSelection,
            onCategoryTap: onCategoryTap,
            onDateTap: onDateTap,
            onPickImage: onPickImage,
            onRemoveImage: onRemoveImage,
            isDark: isDark,
            surfaceColor: surfaceColor,
            textColor: textColor,
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}

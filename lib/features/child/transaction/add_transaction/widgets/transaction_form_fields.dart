import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_note_section.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_form_field.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_evidence_section.dart';

class TransactionFormFields extends StatelessWidget {
  const TransactionFormFields({
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
    super.key,
  });

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
  final VoidCallback? onRemoveImage;
  final bool isDark;
  final Color surfaceColor;
  final Color textColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;

    return Column(
      children: [
        GestureDetector(
          onTap: onCategoryTap,
          child: TransactionFormField(
            label: s.transactionCategoryLabel,
            value: selectedCategory,
            iconOrEmoji: selectedEmoji,
            iconColor: Colors.orange,
            showChevron: true,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: enabled ? onDateTap : null,
          child: TransactionFormField(
            label: s.transactionDateLabel,
            value: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            iconOrEmoji: '📅',
            iconColor: AppTheme.primary,
            showChevron: true,
          ),
        ),
        const SizedBox(height: 16),
        AddTransactionNoteSection(
          controller: noteController,
          enabled: enabled,
          showAiBadge: false,
          isDark: isDark,
          surfaceColor: surfaceColor,
          textColor: textColor,
        ),
        const SizedBox(height: 16),
        TransactionEvidenceSection(
          isDark: isDark,
          surfaceColor: surfaceColor,
          enabled: enabled,
          previewBytes: evidenceImageBytes != null ? Uint8List.fromList(evidenceImageBytes!) : null,
          selectedFileName: evidenceImageFileName,
          onPickImage: onPickImage,
          onRemoveImage: hasEvidenceImageSelection ? onRemoveImage : null,
        ),
      ],
    );
  }
}

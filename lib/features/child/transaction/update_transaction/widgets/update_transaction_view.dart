import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_state.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/action_tile.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/amount_field.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/note_card.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/submit_bar.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/transaction_app_bar.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/transaction_type_selector.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_evidence_section.dart';

class UpdateTransactionView extends StatelessWidget {
  const UpdateTransactionView({
    required this.state,
    required this.amountController,
    required this.noteController,
    required this.isDark,
    required this.onSelectExpense,
    required this.onSelectIncome,
    required this.onSelectCategory,
    required this.onSelectDate,
    required this.onPickEvidenceImage,
    required this.onRemoveEvidenceImage,
    required this.onSubmit,
    super.key,
  });

  final UpdateTransactionState state;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final bool isDark;
  final VoidCallback onSelectExpense;
  final VoidCallback onSelectIncome;
  final VoidCallback onSelectCategory;
  final VoidCallback onSelectDate;
  final VoidCallback onPickEvidenceImage;
  final VoidCallback onRemoveEvidenceImage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final isBusy = state.isLoading || state.isSubmitting;
    final s = context.l10n;

    return PopScope(
      canPop: !isBusy,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: TransactionAppBar(
          isDark: isDark,
          textColor: textColor,
          canPop: !isBusy,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AmountField(controller: amountController, enabled: !isBusy),
                  const SizedBox(height: 24),
                  TransactionTypeSelector(
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    selectedType: state.transactionType,
                    enabled: !isBusy,
                    onSelectExpense: onSelectExpense,
                    onSelectIncome: onSelectIncome,
                  ),
                  const SizedBox(height: 24),
                  ActionTile(
                    iconStr: state.selectedCategoryEmoji,
                    label: s.transactionCategoryLabel,
                    value: state.selectedCategory,
                    iconBgColor:
                        state.transactionType == TransactionType.expense
                        ? Colors.orange.shade100
                        : Colors.green.shade100,
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    enabled: !isBusy,
                    onTap: onSelectCategory,
                  ),
                  const SizedBox(height: 16),
                  ActionTile(
                    iconData: Icons.calendar_today,
                    label: s.transactionDateLabel,
                    value: DateFormat(
                      'dd/MM/yyyy',
                    ).format(state.effectiveSelectedDate),
                    iconBgColor: AppTheme.primary.withValues(alpha: 0.1),
                    iconColor: AppTheme.primary,
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    enabled: !isBusy,
                    onTap: onSelectDate,
                  ),
                  const SizedBox(height: 16),
                  NoteCard(
                    controller: noteController,
                    enabled: !isBusy,
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    textColor: textColor,
                  ),
                  const SizedBox(height: 16),
                  TransactionEvidenceSection(
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    enabled: !isBusy,
                    previewBytes: state.newEvidenceImageBytes,
                    selectedFileName: state.effectiveEvidenceImageFileName,
                    onPickImage: onPickEvidenceImage,
                    onRemoveImage:
                        state.hasNewEvidenceImageSelection ||
                        state.hasExistingEvidenceImage
                        ? onRemoveEvidenceImage
                        : null,
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
            SubmitBar(
              isDark: isDark,
              isSubmitting: state.isSubmitting,
              enabled: !isBusy && state.canSubmit,
              onSubmit: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_category_scroll.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/transaction_section_label.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_state.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/switch_two_item.dart';
import 'package:monikid/shared/widgets/transaction_amount_section.dart';
import 'package:monikid/shared/widgets/transaction_detail_card.dart';
import 'package:monikid/shared/widgets/transaction_submit_action.dart';

class UpdateTransactionView extends StatelessWidget {
  const UpdateTransactionView({
    super.key,
    required this.state,
    required this.amountController,
    required this.noteController,
    required this.isDark,
    required this.onSelectExpense,
    required this.onSelectIncome,
    required this.onCategorySelected,
    required this.onViewAllCategories,
    required this.onSelectDate,
    required this.onPickEvidenceImage,
    required this.onRemoveEvidenceImage,
    required this.onSubmit,
  });

  final UpdateTransactionState state;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final bool isDark;
  final VoidCallback onSelectExpense;
  final VoidCallback onSelectIncome;
  final void Function(CategoryModel) onCategorySelected;
  final VoidCallback onViewAllCategories;
  final VoidCallback onSelectDate;
  final VoidCallback onPickEvidenceImage;
  final VoidCallback onRemoveEvidenceImage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isBusy = state.isLoading || state.isSubmitting;

    return PopScope(
      canPop: !isBusy,
      child: Scaffold(
        backgroundColor: AppTheme.homeParBg1,
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundLight,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: isBusy ? null : () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppTheme.textBlack,
            iconSize: 20,
          ),
          title: Text(
            s.updateTransactionAction,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.titleSmall,
              weight: FontWeight.w700,
              color: AppTheme.textBlack,
            ),
          ),
          centerTitle: true,
        ),
        body: AppBackground(
          child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TransactionAmountSection(
                      controller: amountController,
                      enabled: !isBusy,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SwitchTwoItem(
                      title1: s.transactionExpenseTab,
                      title2: s.transactionIncomeTab,
                      selectedIndex:
                          state.transactionType == TransactionType.expense
                              ? 0
                              : 1,
                      onChanged: (i) =>
                          i == 0 ? onSelectExpense() : onSelectIncome(),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  _CategorySection(
                    state: state,
                    enabled: !isBusy,
                    onCategorySelected: onCategorySelected,
                    onViewAll: onViewAllCategories,
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
                      selectedDate: state.effectiveSelectedDate,
                      noteController: noteController,
                      enabled: !isBusy,
                      onSelectDate: onSelectDate,
                      onPickImage: onPickEvidenceImage,
                      previewBytes: state.newEvidenceImageBytes,
                      hasExistingImage: state.hasExistingEvidenceImage,
                      onRemoveImage:
                          state.hasNewEvidenceImageSelection ||
                              state.hasExistingEvidenceImage
                          ? onRemoveEvidenceImage
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            TransactionSubmitAction(
              label: s.updateTransactionAction,
              isSubmitting: state.isSubmitting,
              enabled: !isBusy && state.canSubmit,
              onSubmit: onSubmit,
            ),
          ],
          ),
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.state,
    required this.enabled,
    required this.onCategorySelected,
    required this.onViewAll,
  });

  final UpdateTransactionState state;
  final bool enabled;
  final void Function(CategoryModel) onCategorySelected;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              TransactionSectionLabel(text: s.transactionCategoryLabel),
              const Spacer(),
              GestureDetector(
                onTap: enabled ? onViewAll : null,
                child: Text(
                  s.transactionCategoryViewAll,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.captionBig,
                    weight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        AddTransactionCategoryScroll(
          categories: state.categories,
          selectedCategoryKey: state.selectedCategoryKey,
          onCategorySelected: enabled ? onCategorySelected : (_) {},
        ),
      ],
    );
  }
}

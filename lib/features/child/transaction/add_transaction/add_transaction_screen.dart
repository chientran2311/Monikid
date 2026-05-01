import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_provider.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_state.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_amount_section.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_note_section.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_form_field.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_type_tab.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_evidence_section.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends HookConsumerWidget {
  const AddTransactionScreen({super.key, this.aiPrefill, this.scannedImage});

  final TransactionAiResult? aiPrefill;
  final TransactionImageSelection? scannedImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionState = ref.watch(addTransactionNotifierProvider);
    final categories =
        ref.watch(categoryStreamProvider).value ?? defaultCategories;
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final isBusy = actionState.isBusy;

    final transactionType = useState(0);
    final amountController = useTextEditingController();
    final noteController = useTextEditingController();
    final selectedDate = useState(DateTime.now());
    final selectedCategoryKey = useState(
      transactionCategoryKeyForCategory(getDefaultCategoryForType('expense')),
    );
    final selectedCategory = useState(getDefaultCategoryForType('expense').label);
    final selectedEmoji = useState(getDefaultCategoryForType('expense').icon);

    final currentType = transactionType.value == 0 ? 'expense' : 'income';

    useEffect(
      () {
        final prefill = aiPrefill;
        if (prefill == null) return null;

        amountController.text = prefill.amountMinor.toString();
        noteController.text = prefill.note;

        final parsedDate = DateTime.tryParse(prefill.transactionDate);
        if (parsedDate != null) {
          selectedDate.value = parsedDate;
        }

        CategoryModel? matched;
        for (final c in categories) {
          if (transactionCategoryKeyForCategory(c) == prefill.categoryKey) {
            matched = c;
            break;
          }
        }
        if (matched != null) {
          selectedCategoryKey.value = transactionCategoryKeyForCategory(matched);
          selectedCategory.value = matched.label;
          selectedEmoji.value = matched.icon;
        }

        return null;
      },
      const [],
    );

    useEffect(
      () {
        final image = scannedImage;
        if (image == null) return null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(addTransactionNotifierProvider.notifier).setEvidenceImage(
            bytes: image.bytes,
            fileName: image.fileName,
            mimeType: image.mimeType,
          );
        });
        return null;
      },
      [scannedImage],
    );

    void syncCategoryForType() {
      final matchedCategory = findCategoryByLabel(
        categories,
        selectedCategory.value,
        type: currentType,
      );
      final fallbackCategory = getDefaultCategoryForType(
        currentType,
        categories: categories,
      );
      final nextCategory = matchedCategory ?? fallbackCategory;

      if (selectedCategory.value != nextCategory.label ||
          selectedEmoji.value != nextCategory.icon ||
          selectedCategoryKey.value !=
              transactionCategoryKeyForCategory(nextCategory)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) {
            return;
          }
          selectedCategoryKey.value = transactionCategoryKeyForCategory(
            nextCategory,
          );
          selectedCategory.value = nextCategory.label;
          selectedEmoji.value = nextCategory.icon;
        });
      }
    }

    Future<void> selectDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked == null || !context.mounted) {
        return;
      }

      selectedDate.value = DateTime(
        picked.year,
        picked.month,
        picked.day,
        selectedDate.value.hour,
        selectedDate.value.minute,
        selectedDate.value.second,
      );
    }

    void handleTransactionTypeChanged(int index) {
      final category = getDefaultCategoryForType(
        index == 0 ? 'expense' : 'income',
        categories: categories,
      );

      transactionType.value = index;
      selectedCategoryKey.value = transactionCategoryKeyForCategory(category);
      selectedCategory.value = category.label;
      selectedEmoji.value = category.icon;
    }

    void showCategoryPicker() {
      if (isBusy) {
        return;
      }

      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => CategoryDialog(
          selectedCategory: selectedCategory.value,
          showAllOption: false,
          categoryType: currentType,
          onCategorySelected: (category) {
            if (category == null) {
              return;
            }

            selectedCategoryKey.value = transactionCategoryKeyForCategory(
              category,
            );
            selectedCategory.value = category.label;
            selectedEmoji.value = category.icon;
          },
        ),
      );
    }

    Future<void> pickEvidenceImage() async {
      if (isBusy) {
        return;
      }

      final imageSelection =
          await showModalBottomSheet<TransactionImageSelection>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => UploadPicDialog(
              imageIntake: ref.read(transactionImageIntakeProvider),
            ),
          );

      if (!context.mounted || imageSelection == null) {
        return;
      }

      ref.read(addTransactionNotifierProvider.notifier).setEvidenceImage(
        bytes: imageSelection.bytes,
        fileName: imageSelection.fileName,
        mimeType: imageSelection.mimeType,
      );
    }

    Future<void> saveTransaction() async {
      if (amountController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(s.validationEnterAmount)));
        return;
      }

      final amountStr = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final amount = double.tryParse(amountStr) ?? 0.0;

      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.validationAmountGreaterThanZero)),
        );
        return;
      }

      final authState = ref.read(authSessionProvider);
      final user = authState.user;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.transactionUserNotAuthenticated)),
        );
        return;
      }

      final now = DateTime.now();
      final transaction = TransactionModel(
        transactionId: const Uuid().v4(),
        userId: user.uid,
        familyId: authState.account?.familyId,
        amountMinor: amount.round(),
        type: currentType,
        categoryKey: selectedCategoryKey.value,
        categoryLabel: selectedCategory.value,
        categoryIcon: selectedEmoji.value,
        note: noteController.text.trim(),
        source: 'manual',
        dateTs: selectedDate.value,
        createdAt: now,
        updatedAt: now,
      );

      await ref
          .read(addTransactionNotifierProvider.notifier)
          .addTransaction(transaction);
    }

    syncCategoryForType();

    ref.listen<AddTransactionState>(addTransactionNotifierProvider, (
      previous,
      next,
    ) {
      if (!context.mounted || previous?.status == next.status) {
        return;
      }

      switch (next.status) {
        case TransactionStatus.success:
          final messenger = ScaffoldMessenger.of(context);
          context.pop();
          messenger.showSnackBar(
            SnackBar(content: Text(s.msgAddTransactionSuccess)),
          );
          return;
        case TransactionStatus.error:
          if (next.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
          }
          return;
        case TransactionStatus.initial:
        case TransactionStatus.loading:
        case TransactionStatus.ready:
        case TransactionStatus.submitting:
          return;
      }
    });

    return PopScope(
      canPop: !isBusy,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
            onPressed: isBusy ? null : () => context.pop(),
            child: Text(
              s.actionCancel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF64748B),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            s.homeStudentAddTransaction,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: 120,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark ? surfaceColor : const Color(0xFFeaf0ea),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        TransactionTypeTab(
                          title: s.transactionExpenseType,
                          index: 0,
                          selectedIndex: transactionType.value,
                          onTabSelected: isBusy
                              ? (_) {}
                              : handleTransactionTypeChanged,
                        ),
                        TransactionTypeTab(
                          title: s.transactionIncomeType,
                          index: 1,
                          selectedIndex: transactionType.value,
                          onTabSelected: isBusy
                              ? (_) {}
                              : handleTransactionTypeChanged,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  AddTransactionAmountSection(
                    controller: amountController,
                    enabled: !isBusy,
                    textColor: textColor,
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: showCategoryPicker,
                    child: TransactionFormField(
                      label: s.transactionCategoryLabel,
                      value: selectedCategory.value,
                      iconOrEmoji: selectedEmoji.value,
                      iconColor: Colors.orange,
                      showChevron: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: isBusy ? null : selectDate,
                    child: TransactionFormField(
                      label: s.transactionDateLabel,
                      value:
                          '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}',
                      iconOrEmoji: '📅',
                      iconColor: AppTheme.primary,
                      showChevron: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AddTransactionNoteSection(
                    controller: noteController,
                    enabled: !isBusy,
                    showAiBadge: false,
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    textColor: textColor,
                  ),
                  const SizedBox(height: 16),
                  TransactionEvidenceSection(
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    enabled: !isBusy,
                    previewBytes: actionState.evidenceImageBytes,
                    selectedFileName: actionState.evidenceImageFileName,
                    onPickImage: pickEvidenceImage,
                    onRemoveImage: actionState.hasEvidenceImageSelection
                        ? () => ref
                              .read(addTransactionNotifierProvider.notifier)
                              .clearEvidenceImage()
                        : null,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [bgColor.withValues(alpha: 0.0), bgColor, bgColor],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: isBusy ? null : saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    shadowColor: AppTheme.primary.withValues(alpha: 0.4),
                  ),
                  child: actionState.isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              s.transactionSaveAction,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            if (actionState.isBusy)
              TransactionEditorLoadingOverlay(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

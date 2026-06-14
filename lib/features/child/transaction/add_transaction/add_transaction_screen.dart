import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_provider.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_state.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_body.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/add_transaction_state_handler.dart';
import 'package:monikid/features/child/transaction/add_transaction/widgets/transaction_save_helper.dart';
import 'package:monikid/shared/widgets/transaction_submit_action.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/calendar_dialog.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';

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

    void selectCategory(CategoryModel category) {
      if (isBusy) return;
      selectedCategoryKey.value = transactionCategoryKeyForCategory(category);
      selectedCategory.value = category.label;
      selectedEmoji.value = category.icon;
    }

    Future<void> saveTransaction() async {
      await saveTransactionData(
        context: context,
        ref: ref,
        amountController: amountController,
        currentType: currentType,
        selectedCategoryKey: selectedCategoryKey.value,
        selectedCategory: selectedCategory.value,
        selectedEmoji: selectedEmoji.value,
        noteController: noteController,
        selectedDate: selectedDate.value,
      );
    }

    syncCategoryForType();

    ref.listen<AddTransactionState>(
      addTransactionNotifierProvider,
      (previous, next) => handleAddTransactionStateChange(context, previous, next),
    );

    return PopScope(
      canPop: !isBusy,
      child: Scaffold(
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
        appBar: GlassAppBar(title: s.homeStudentAddTransaction),
        body: AppBackground(
          child: Stack(
            children: [
            AddTransactionBody(
              transactionType: transactionType.value,
              onTypeChanged: (int index) {
                final category = getDefaultCategoryForType(
                  index == 0 ? 'expense' : 'income',
                  categories: categories,
                );
                transactionType.value = index;
                selectedCategoryKey.value = transactionCategoryKeyForCategory(category);
                selectedCategory.value = category.label;
                selectedEmoji.value = category.icon;
              },
              expenseLabel: s.transactionExpenseType,
              incomeLabel: s.transactionIncomeType,
              amountController: amountController,
              categories: categories,
              selectedCategoryKey: selectedCategoryKey.value,
              onCategoryChipSelected: selectCategory,
              selectedDate: selectedDate.value,
              noteController: noteController,
              evidenceImageBytes: actionState.evidenceImageBytes,
              hasEvidenceImageSelection: actionState.hasEvidenceImageSelection,
              onDateTap: () {
                if (!context.mounted) return;
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => CalendarDialog(
                    initialMonth: selectedDate.value,
                    onDateConfirmed: (picked) {
                      selectedDate.value = DateTime(
                        picked.year,
                        picked.month,
                        picked.day,
                        selectedDate.value.hour,
                        selectedDate.value.minute,
                        selectedDate.value.second,
                      );
                    },
                  ),
                );
              },
              onPickImage: () async {
                if (isBusy) return;
                final imageSelection = await showModalBottomSheet<TransactionImageSelection>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => UploadPicDialog(
                    imageIntake: ref.read(transactionImageIntakeProvider),
                  ),
                );
                if (!context.mounted || imageSelection == null) return;
                ref.read(addTransactionNotifierProvider.notifier).setEvidenceImage(
                  bytes: imageSelection.bytes,
                  fileName: imageSelection.fileName,
                  mimeType: imageSelection.mimeType,
                  filePath: imageSelection.filePath,
                );
              },
              onRemoveImage: () => ref
                  .read(addTransactionNotifierProvider.notifier)
                  .clearEvidenceImage(),
              enabled: !isBusy,
            ),
            TransactionSubmitAction(
              label: s.transactionSaveAction,
              isSubmitting: actionState.isBusy,
              enabled: !isBusy,
              onSubmit: saveTransaction,
            ),
          ],
          ),
        ),
      ),
    );
  }
}

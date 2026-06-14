import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_provider.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_state.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/loading_transaction_scaffold.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/missing_transaction_scaffold.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/update_transaction_view.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';

class UpdateTransactionScreen extends HookConsumerWidget {
  const UpdateTransactionScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountController = useTextEditingController();
    final noteController = useTextEditingController();
    final isSyncingControllers = useRef(false);

    void onAmountChanged() {
      if (isSyncingControllers.value) {
        return;
      }

      ref
          .read(updateTransactionNotifierProvider.notifier)
          .updateAmount(amountController.text);
    }

    void onNoteChanged() {
      if (isSyncingControllers.value) {
        return;
      }

      ref
          .read(updateTransactionNotifierProvider.notifier)
          .updateNote(noteController.text);
    }

    void syncControllers(UpdateTransactionState state) {
      isSyncingControllers.value = true;

      if (amountController.text != state.amountText) {
        amountController.value = TextEditingValue(
          text: state.amountText,
          selection: TextSelection.collapsed(offset: state.amountText.length),
        );
      }

      if (noteController.text != state.note) {
        noteController.value = TextEditingValue(
          text: state.note,
          selection: TextSelection.collapsed(offset: state.note.length),
        );
      }

      isSyncingControllers.value = false;
    }

    useEffect(() {
      amountController.addListener(onAmountChanged);
      noteController.addListener(onNoteChanged);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(updateTransactionNotifierProvider.notifier)
            .initialize(transactionId);
      });
      return () {
        amountController.removeListener(onAmountChanged);
        noteController.removeListener(onNoteChanged);
      };
    }, [amountController, noteController, ref, transactionId]);

    ref.listen<UpdateTransactionState>(updateTransactionNotifierProvider, (
      previous,
      next,
    ) {
      final hasNewTransaction =
          previous?.originalTransaction != next.originalTransaction;
      if (hasNewTransaction && next.originalTransaction != null) {
        syncControllers(next);
      }

      if (!context.mounted || previous?.status == next.status) {
        return;
      }

      switch (next.status) {
        case TransactionStatus.success:
          context.showSuccessSnackBar(s.msgUpdateSuccess);
          context.pop();
          return;
        case TransactionStatus.error:
          if (next.errorMessage != null) {
            context.showErrorSnackBar(next.errorMessage!);
          }
          return;
        case TransactionStatus.initial:
        case TransactionStatus.loading:
        case TransactionStatus.ready:
        case TransactionStatus.submitting:
          break;
      }
    });

    final state = ref.watch(updateTransactionNotifierProvider);
    final notifier = ref.read(updateTransactionNotifierProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Future<void> selectDate(DateTime selectedDate) async {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: AppTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        notifier.updateDate(picked);
      }
    }

    Future<void> pickEvidenceImage() async {
      final currentState = ref.read(updateTransactionNotifierProvider);
      if (currentState.isSubmitting || currentState.isLoading) {
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

      notifier.setNewEvidenceImage(
        bytes: imageSelection.bytes,
        fileName: imageSelection.fileName,
        mimeType: imageSelection.mimeType,
        filePath: imageSelection.filePath,
      );
    }

    void showCategoryDialog() {
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return CategoryDialog(
            selectedCategory: state.selectedCategory,
            categoryType: state.currentType,
            showAllOption: false,
            onCategorySelected: (category) {
              if (category != null) {
                notifier.updateCategory(category);
              }
            },
          );
        },
      );
    }

    if (!state.hasTransaction && state.status == TransactionStatus.error) {
      return MissingTransactionScaffold(
        isDark: isDark,
        errorMessage: state.errorMessage,
      );
    }

    return switch (state.status) {
      TransactionStatus.initial ||
      TransactionStatus.loading => LoadingTransactionScaffold(isDark: isDark),
      TransactionStatus.ready ||
      TransactionStatus.submitting ||
      TransactionStatus.error ||
      TransactionStatus.success => UpdateTransactionView(
        state: state,
        amountController: amountController,
        noteController: noteController,
        isDark: isDark,
        onSelectExpense: () =>
            notifier.updateTransactionType(TransactionType.expense),
        onSelectIncome: () =>
            notifier.updateTransactionType(TransactionType.income),
        onCategorySelected: notifier.updateCategory,
        onViewAllCategories: showCategoryDialog,
        onSelectDate: () => selectDate(state.effectiveSelectedDate),
        onPickEvidenceImage: pickEvidenceImage,
        onRemoveEvidenceImage: () {
          if (state.hasNewEvidenceImageSelection) {
            notifier.clearPendingEvidenceImageSelection();
            return;
          }
          notifier.removeEvidenceImage();
        },
        onSubmit: notifier.submit,
      ),
    };
  }
}

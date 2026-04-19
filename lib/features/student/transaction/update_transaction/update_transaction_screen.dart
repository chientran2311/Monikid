import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/features/student/transaction/update_transaction/update_transaction_provider.dart';
import 'package:monikid/features/student/transaction/update_transaction/update_transaction_state.dart';
import 'package:monikid/features/student/transaction/update_transaction/widgets/action_tile.dart';
import 'package:monikid/features/student/transaction/update_transaction/widgets/amount_field.dart';
import 'package:monikid/features/student/transaction/update_transaction/widgets/note_card.dart';
import 'package:monikid/features/student/transaction/update_transaction/widgets/submit_bar.dart';
import 'package:monikid/features/student/transaction/update_transaction/widgets/transaction_app_bar.dart';
import 'package:monikid/features/student/transaction/update_transaction/widgets/transaction_type_selector.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_loading_skeleton.dart';

class UpdateTransactionScreen extends ConsumerStatefulWidget {
  const UpdateTransactionScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  ConsumerState<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState
    extends ConsumerState<UpdateTransactionScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  bool _isSyncingControllers = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    _amountController.addListener(_onAmountChanged);
    _noteController.addListener(_onNoteChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(updateTransactionNotifierProvider.notifier)
          .initialize(widget.transactionId);
    });
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _noteController.removeListener(_onNoteChanged);
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    if (_isSyncingControllers) {
      return;
    }

    ref.read(updateTransactionNotifierProvider.notifier).updateAmount(
          _amountController.text,
        );
  }

  void _onNoteChanged() {
    if (_isSyncingControllers) {
      return;
    }

    ref.read(updateTransactionNotifierProvider.notifier).updateNote(
          _noteController.text,
        );
  }

  void _syncControllers(UpdateTransactionState state) {
    _isSyncingControllers = true;

    if (_amountController.text != state.amountText) {
      _amountController.value = TextEditingValue(
        text: state.amountText,
        selection: TextSelection.collapsed(offset: state.amountText.length),
      );
    }

    if (_noteController.text != state.note) {
      _noteController.value = TextEditingValue(
        text: state.note,
        selection: TextSelection.collapsed(offset: state.note.length),
      );
    }

    _isSyncingControllers = false;
  }

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(
            colorScheme: const ColorScheme.light(primary: AppTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(updateTransactionNotifierProvider.notifier).updateDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UpdateTransactionState>(updateTransactionNotifierProvider, (
      previous,
      next,
    ) {
      final hasNewTransaction =
          previous?.originalTransaction != next.originalTransaction;
      if (hasNewTransaction && next.originalTransaction != null) {
        _syncControllers(next);
      }

      if (!context.mounted || previous?.status == next.status) {
        return;
      }

      switch (next.status) {
        case TransactionStatus.success:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.msgUpdateSuccess)));
          context.pop();
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
          break;
      }
    });

    final state = ref.watch(updateTransactionNotifierProvider);
    final notifier = ref.read(updateTransactionNotifierProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!state.hasTransaction && state.status == TransactionStatus.error) {
      return _MissingTransactionScaffold(
        isDark: isDark,
        errorMessage: state.errorMessage,
      );
    }

    return switch (state.status) {
      TransactionStatus.initial || TransactionStatus.loading => _LoadingScaffold(
          isDark: isDark,
        ),
      TransactionStatus.ready ||
      TransactionStatus.submitting ||
      TransactionStatus.error ||
      TransactionStatus.success => _UpdateTransactionView(
          state: state,
          amountController: _amountController,
          noteController: _noteController,
          isDark: isDark,
          onSelectExpense: () =>
              notifier.updateTransactionType(TransactionType.expense),
          onSelectIncome: () =>
              notifier.updateTransactionType(TransactionType.income),
          onSelectCategory: () => _showCategoryDialog(context, state, notifier),
          onSelectDate: () => _selectDate(context, state.effectiveSelectedDate),
          onSubmit: notifier.submit,
        ),
    };
  }

  void _showCategoryDialog(
    BuildContext context,
    UpdateTransactionState state,
    UpdateTransactionNotifier notifier,
  ) {
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
}

class _MissingTransactionScaffold extends StatelessWidget {
  const _MissingTransactionScaffold({
    required this.isDark,
    required this.errorMessage,
  });

  final bool isDark;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: TransactionAppBar(
        isDark: isDark,
        textColor: textColor,
        canPop: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            errorMessage ?? s.transactionLoadError,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: TransactionAppBar(
        isDark: isDark,
        textColor: textColor,
        canPop: false,
      ),
      body: const TransactionEditorLoadingSkeleton(),
    );
  }
}

class _UpdateTransactionView extends StatelessWidget {
  const _UpdateTransactionView({
    required this.state,
    required this.amountController,
    required this.noteController,
    required this.isDark,
    required this.onSelectExpense,
    required this.onSelectIncome,
    required this.onSelectCategory,
    required this.onSelectDate,
    required this.onSubmit,
  });

  final UpdateTransactionState state;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final bool isDark;
  final VoidCallback onSelectExpense;
  final VoidCallback onSelectIncome;
  final VoidCallback onSelectCategory;
  final VoidCallback onSelectDate;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final isBusy = state.isLoading || state.isSubmitting;

    return Scaffold(
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
                AmountField(
                  controller: amountController,
                  enabled: !isBusy,
                ),
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
                  iconBgColor: state.transactionType == TransactionType.expense
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
                ActionTile(
                  iconData: Icons.account_balance_wallet,
                  label: s.updateTransactionWalletLabel,
                  value: s.updateTransactionCashWalletValue,
                  iconBgColor: Colors.blue.shade100,
                  iconColor: Colors.blue.shade700,
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                  enabled: false,
                  trailingIcon: Icons.expand_more,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SubmitBar(
              isDark: isDark,
              isSubmitting: state.isSubmitting,
              enabled: !isBusy,
              onSubmit: onSubmit,
            ),
          ),
          if (state.isSubmitting) TransactionEditorLoadingOverlay(isDark: isDark),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/student/transaction/add_transaction/add_transaction_provider.dart';
import 'package:monikid/features/student/transaction/add_transaction/add_transaction_state.dart';
import 'package:monikid/features/student/transaction/add_transaction/widgets/add_transaction_amount_section.dart';
import 'package:monikid/features/student/transaction/add_transaction/widgets/add_transaction_note_section.dart';
import 'package:monikid/features/student/transaction/add_transaction/widgets/transaction_form_field.dart';
import 'package:monikid/features/student/transaction/add_transaction/widgets/transaction_type_tab.dart';
import 'package:monikid/features/student/transaction/providers/category_provider.dart';
import 'package:monikid/features/student/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  int _transactionType = 0;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategoryKey =
      transactionCategoryKeyForCategory(getDefaultCategoryForType('expense'));
  String _selectedCategory = getDefaultCategoryForType('expense').label;
  String _selectedEmoji = getDefaultCategoryForType('expense').icon;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String get _currentType => _transactionType == 0 ? 'expense' : 'income';

  void _syncCategoryForType(List<CategoryModel> categories) {
    final matchedCategory = findCategoryByLabel(
      categories,
      _selectedCategory,
      type: _currentType,
    );
    final fallbackCategory = getDefaultCategoryForType(
      _currentType,
      categories: categories,
    );

    final nextCategory = matchedCategory ?? fallbackCategory;
    if (_selectedCategory != nextCategory.label ||
        _selectedEmoji != nextCategory.icon) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _selectedCategoryKey = transactionCategoryKeyForCategory(nextCategory);
          _selectedCategory = nextCategory.label;
          _selectedEmoji = nextCategory.icon;
        });
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && mounted) {
      setState(() {
        _selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDate.hour,
          _selectedDate.minute,
          _selectedDate.second,
        );
      });
    }
  }

  void _handleTransactionTypeChanged(
    int index,
    List<CategoryModel> categories,
  ) {
    final category = getDefaultCategoryForType(
      index == 0 ? 'expense' : 'income',
      categories: categories,
    );

    setState(() {
      _transactionType = index;
      _selectedCategoryKey = transactionCategoryKeyForCategory(category);
      _selectedCategory = category.label;
      _selectedEmoji = category.icon;
    });
  }

  void _showCategoryDialog(bool isLoading) {
    if (isLoading) {
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CategoryDialog(
        selectedCategory: _selectedCategory,
        showAllOption: false,
        categoryType: _currentType,
        onCategorySelected: (category) {
          if (category != null) {
            setState(() {
              _selectedCategoryKey = transactionCategoryKeyForCategory(category);
              _selectedCategory = category.label;
              _selectedEmoji = category.icon;
            });
          }
        },
      ),
    );
  }

  Future<void> _saveTransaction() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(s.validationEnterAmount)));
      return;
    }

    final amountStr = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
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
      type: _currentType,
      categoryKey: _selectedCategoryKey,
      categoryLabel: _selectedCategory,
      categoryIcon: _selectedEmoji,
      note: _noteController.text.trim(),
      source: 'manual',
      dateTs: _selectedDate,
      createdAt: now,
      updatedAt: now,
    );

    await ref
        .read(addTransactionNotifierProvider.notifier)
        .addTransaction(transaction);
  }

  @override
  Widget build(BuildContext context) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(next.errorMessage!)),
            );
          }
          return;
        case TransactionStatus.initial:
        case TransactionStatus.loading:
        case TransactionStatus.ready:
        case TransactionStatus.submitting:
          break;
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final actionState = ref.watch(addTransactionNotifierProvider);
    final isLoading = actionState.isLoading;
    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;

    _syncCategoryForType(categories);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leadingWidth: 80,
        leading: TextButton(
          onPressed: isLoading ? null : () => context.pop(),
          child: Text(
            s.actionCancel,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
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
                        selectedIndex: _transactionType,
                        onTabSelected: isLoading
                            ? (_) {}
                            : (index) =>
                                _handleTransactionTypeChanged(index, categories),
                      ),
                      TransactionTypeTab(
                        title: s.transactionIncomeType,
                        index: 1,
                        selectedIndex: _transactionType,
                        onTabSelected: isLoading
                            ? (_) {}
                            : (index) =>
                                _handleTransactionTypeChanged(index, categories),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                AddTransactionAmountSection(
                  controller: _amountController,
                  enabled: !isLoading,
                  textColor: textColor,
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => _showCategoryDialog(isLoading),
                  child: TransactionFormField(
                    label: s.transactionCategoryLabel,
                    value: _selectedCategory,
                    iconOrEmoji: _selectedEmoji,
                    iconColor: Colors.orange,
                    showChevron: true,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: isLoading ? null : () => _selectDate(context),
                  child: TransactionFormField(
                    label: s.transactionDateLabel,
                    value:
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    iconOrEmoji: '📅',
                    iconColor: AppTheme.primary,
                    showChevron: true,
                  ),
                ),
                const SizedBox(height: 16),
                AddTransactionNoteSection(
                  controller: _noteController,
                  enabled: !isLoading,
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                  textColor: textColor,
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
                onPressed: isLoading ? null : _saveTransaction,
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
                child: isLoading
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
          if (isLoading) TransactionEditorLoadingOverlay(isDark: isDark),
        ],
      ),
    );
  }
}

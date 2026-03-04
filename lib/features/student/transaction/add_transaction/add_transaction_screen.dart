import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/student/transaction/add_transaction/add_transaction_provider.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:uuid/uuid.dart';
import '../transaction_history/widgets/category_dialog.dart';
import 'widgets/transaction_type_tab.dart';
import 'widgets/transaction_form_field.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  // 0: Tiền chi, 1: Tiền thu
  int _transactionType = 0;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Dummy category for now
  String _selectedCategory = "Ăn uống";
  String _selectedEmoji = "🍔";
  DateTime _selectedDate = DateTime.now();

  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveTransaction() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập số tiền')));
      return;
    }

    final amountStr = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = double.tryParse(amountStr) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Số tiền phải lớn hơn 0')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = ref.read(authProvider).user;
      if (user == null) throw Exception("User not authenticated");

      final type = _transactionType == 0 ? 'expense' : 'income';
      final uuid = const Uuid().v4();

      final newTx = TransactionModel(
        transactionId: uuid,
        userId: user.uid,
        amount: amount,
        type: type,
        category: _selectedCategory,
        categoryEmoji: _selectedEmoji,
        note: _noteController.text.trim(),
        source: 'manual',
        date: _selectedDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref
          .read(addTransactionNotifierProvider.notifier)
          .addTransaction(newTx);

      if (mounted) {
        setState(() => _isLoading = false);
        context.pop(); // Return to previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm giao dịch thành công!')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Text(
            "Hủy",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Thêm Giao dịch",
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
                // Segmented Control
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? surfaceColor
                        : const Color(0xFFeaf0ea), // input-bg
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      TransactionTypeTab(
                        title: "Tiền Chi",
                        index: 0,
                        selectedIndex: _transactionType,
                        onTabSelected: (index) {
                          setState(() {
                            _transactionType = index;
                            _selectedCategory = "Ăn uống";
                            _selectedEmoji = "🍔";
                          });
                        },
                      ),
                      TransactionTypeTab(
                        title: "Tiền Thu",
                        index: 1,
                        selectedIndex: _transactionType,
                        onTabSelected: (index) {
                          setState(() {
                            _transactionType = index;
                            _selectedCategory = "Tiền tiêu vặt";
                            _selectedEmoji = "💰";
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Amount Input
                Column(
                  children: [
                    const Text(
                      "Số tiền",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        IntrinsicWidth(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                            decoration: const InputDecoration(
                              hintText: "0",
                              hintStyle: TextStyle(color: Color(0xFFCBD5E1)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "đ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) => CategoryDialog(
                        selectedCategory: _selectedCategory,
                        showAllOption: false,
                        onCategorySelected: (category) {
                          if (category != null) {
                            setState(() {
                              _selectedCategory = category.label;
                              _selectedEmoji = category.icon;
                            });
                          }
                        },
                      ),
                    );
                  },
                  child: TransactionFormField(
                    label: "Danh mục",
                    value: _selectedCategory,
                    iconOrEmoji: _selectedEmoji,
                    iconColor: Colors.orange, // fake color match tailwind
                    showChevron: true,
                  ),
                ),
                const SizedBox(height: 16),

                TransactionFormField(
                  label: "Ngày",
                  value:
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  iconOrEmoji: "📅",
                  iconColor: AppTheme.primary,
                  showChevron: true,
                ),
                const SizedBox(height: 16),

                // Note with AI Hint
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ghi chú",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFFCBD5E1)
                                : const Color(0xFF334155),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                size: 14,
                                color: AppTheme.primary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "AI Tự động",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFF1F5F9),
                        ),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 3,
                        style: TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          hintText: "Nhập ghi chú, AI sẽ tự động phân loại...",
                          hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Fixed Button
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
                  colors: [bgColor.withOpacity(0.0), bgColor, bgColor],
                ),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: AppTheme.primary.withOpacity(0.4),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 24),
                          SizedBox(width: 8),
                          Text(
                            "Lưu giao dịch",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

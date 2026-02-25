import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/features/student/transaction/update_transaction/update_transaction_provider.dart';

class UpdateTransactionScreen extends ConsumerStatefulWidget {
  final TransactionModel transaction;
  const UpdateTransactionScreen({Key? key, required this.transaction})
    : super(key: key);

  @override
  ConsumerState<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState
    extends ConsumerState<UpdateTransactionScreen> {
  late int _transactionType; // 0: Tiền chi, 1: Tiền thu
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late DateTime _selectedDate;
  late String _selectedCategory;
  late String _selectedCategoryEmoji;
  bool _isLoading = false;

  final List<Map<String, String>> expenseCategories = [
    {'name': 'Ăn uống', 'emoji': '🍜'},
    {'name': 'Mua sắm', 'emoji': '🛍️'},
    {'name': 'Di chuyển', 'emoji': '🚌'},
    {'name': 'Giải trí', 'emoji': '🎮'},
    {'name': 'Học tập', 'emoji': '📚'},
    {'name': 'Sức khỏe', 'emoji': '💊'},
    {'name': 'Quà tặng', 'emoji': '🎁'},
    {'name': 'Khác', 'emoji': '✨'},
  ];

  final List<Map<String, String>> incomeCategories = [
    {'name': 'Tiền tiêu vặt', 'emoji': '💵'},
    {'name': 'Thưởng', 'emoji': '🏆'},
    {'name': 'Lì xì', 'emoji': '🧧'},
    {'name': 'Bán kẹo/đồ', 'emoji': '🍡'},
    {'name': 'Khác', 'emoji': '✨'},
  ];

  @override
  void initState() {
    super.initState();
    final tx = widget.transaction;
    _transactionType = tx.type == 'income' ? 1 : 0;
    _amountController = TextEditingController(
      text: tx.amount.toInt().toString(),
    );
    _noteController = TextEditingController(text: tx.note ?? "");
    _selectedDate = tx.date;
    _selectedCategory = tx.category;
    _selectedCategoryEmoji =
        tx.categoryEmoji ?? (tx.type == 'income' ? '💰' : '💸');
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: AppTheme.primary)),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCategoryPicker(BuildContext context, bool isDark) {
    final categories = _transactionType == 0
        ? expenseCategories
        : incomeCategories;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppTheme.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Chọn danh mục",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: categories.map((cat) {
                  return GestureDetector(
                    onTap: () async {
                      if (cat['name'] == 'Khác') {
                        // User can add a custom category
                        context.pop();
                        await _showCustomCategoryDialog(context, isDark);
                      } else {
                        setState(() {
                          _selectedCategory = cat['name']!;
                          _selectedCategoryEmoji = cat['emoji']!;
                        });
                        context.pop();
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              cat['emoji']!,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['name']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFFCBD5E1)
                                : const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showCustomCategoryDialog(
    BuildContext context,
    bool isDark,
  ) async {
    final nameController = TextEditingController();
    final emojiController = TextEditingController(text: '✨');

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppTheme.surfaceDark : Colors.white,
          title: Text(
            "Danh mục tuỳ chỉnh",
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emojiController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: const InputDecoration(labelText: "Emoji (1 ký tự)"),
                maxLength: 2,
              ),
              TextField(
                controller: nameController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: const InputDecoration(labelText: "Tên danh mục"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    _selectedCategory = nameController.text.trim();
                    _selectedCategoryEmoji = emojiController.text.isNotEmpty
                        ? emojiController.text
                        : '✨';
                  });
                }
                context.pop();
              },
              child: const Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateTransaction() async {
    final amountText = _amountController.text.replaceAll('.', '').trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập số tiền')));
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Số tiền không hợp lệ')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedTx = widget.transaction.copyWith(
        amount: amount,
        type: _transactionType == 0 ? 'expense' : 'income',
        category: _selectedCategory,
        categoryEmoji: _selectedCategoryEmoji,
        date: _selectedDate,
        note: _noteController.text.trim(),
        updatedAt: DateTime.now(),
      );

      await ref
          .read(updateTransactionNotifierProvider.notifier)
          .updateTransaction(updatedTx);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cập nhật thành công')));

        // Go back twice to return to history screen (since detail screen might be outdated now)
        context.pop(); // pop update
        context.pop(); // pop detail
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
        backgroundColor: isDark
            ? AppTheme.backgroundDark.withOpacity(0.95)
            : AppTheme.backgroundLight.withOpacity(0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Chỉnh sửa Giao dịch",
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amount Input
                const Text(
                  "Số tiền",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle: const TextStyle(color: Color(0xFFCBD5E1)),
                    suffixText: "₫",
                    suffixStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94A3B8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.primary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primary, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Segmented Control
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildTypeTab("Tiền chi", 0, isDark),
                      _buildTypeTab("Tiền thu", 1, isDark),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Category Selector
                GestureDetector(
                  onTap: () => _showCategoryPicker(context, isDark),
                  child: _buildActionRow(
                    iconStr: _selectedCategoryEmoji,
                    label: "Danh mục",
                    value: _selectedCategory,
                    iconBgColor: _transactionType == 0
                        ? Colors.orange.shade100
                        : Colors.green.shade100,
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Date Selector
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: _buildActionRow(
                    iconData: Icons.calendar_today,
                    label: "Ngày",
                    value: DateFormat('dd/MM/yyyy').format(_selectedDate),
                    iconBgColor: AppTheme.primary.withOpacity(0.1),
                    iconColor: AppTheme.primary,
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Note Input
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                        ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_note,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ghi chú",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            TextField(
                              controller: _noteController,
                              maxLines: 2,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Thêm ghi chú...",
                                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Wallet Selector (Static for now)
                _buildActionRow(
                  iconData: Icons.account_balance_wallet,
                  label: "Ví nguồn",
                  value: "Tiền mặt",
                  iconBgColor: Colors.blue.shade100,
                  iconColor: Colors.blue.shade700,
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                  trailingIcon: Icons.expand_more,
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // Bottom Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? AppTheme.backgroundDark.withOpacity(0.9)
                    : AppTheme.backgroundLight.withOpacity(0.9),
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updateTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1e5222),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 24),
                          SizedBox(width: 8),
                          Text(
                            "Cập nhật giao dịch",
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

  Widget _buildTypeTab(String title, int index, bool isDark) {
    final isSelected = _transactionType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _transactionType = index;
            // Reset category if switching types
            _selectedCategory = 'Khác';
            _selectedCategoryEmoji = '✨';
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (index == 0 ? AppTheme.redAlert : Colors.green)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.white
                  : (isDark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow({
    String? iconStr,
    IconData? iconData,
    Color? iconBgColor,
    Color? iconColor,
    required String label,
    required String value,
    required bool isDark,
    required Color surfaceColor,
    IconData trailingIcon = Icons.chevron_right,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: iconStr != null
                  ? Text(iconStr, style: const TextStyle(fontSize: 24))
                  : Icon(iconData, color: iconColor),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
          Icon(trailingIcon, color: const Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

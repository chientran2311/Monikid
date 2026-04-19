import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/request_money/add_new_request/add_request_money_provider.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';

class AddRequestMoneyScreen extends ConsumerStatefulWidget {
  const AddRequestMoneyScreen({super.key});

  @override
  ConsumerState<AddRequestMoneyScreen> createState() => _AddRequestMoneyScreenState();
}

class _AddRequestMoneyScreenState extends ConsumerState<AddRequestMoneyScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '50000');
    // Pre-seed state with default 50000 via post-frame or let the state handle its default 0.0
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addRequestMoneyProvider.notifier).updateAmount(50000.0);
    });

    _noteController = TextEditingController();

    _amountController.addListener(() {
      final text = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (text.isNotEmpty) {
        ref.read(addRequestMoneyProvider.notifier).updateAmount(double.parse(text));
      } else {
        ref.read(addRequestMoneyProvider.notifier).updateAmount(0.0);
      }
    });

    _noteController.addListener(() {
      ref.read(addRequestMoneyProvider.notifier).updateNote(_noteController.text);
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _addAmount(double addAmount) {
    if (_amountController.text.isEmpty) {
      _amountController.text = addAmount.toInt().toString();
    } else {
      final current = int.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      _amountController.text = (current + addAmount.toInt()).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addRequestMoneyProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    ref.listen(addRequestMoneyProvider, (previous, next) {
      if (next.errorMessage != null && previous?.errorMessage != next.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
      if (next.isSuccess && !(previous?.isSuccess ?? false)) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessDialog(
            message: 'Đã gửi yêu cầu thành công',
            onPressed: () {
              context.pop(); // Close dialog
              context.pop(); // Go back
            },
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor.withValues(alpha: 0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : AppTheme.textBlack),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Xin tiền tiêu vặt', // Assuming this is standard
          style: TextStyle(
            color: isDarkMode ? Colors.white : AppTheme.textBlack,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Space for bottom button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAmountSection(isDarkMode),
                _buildReasonSection(state.category, isDarkMode),
                _buildRecipientSection(state.recipients, isDarkMode),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : () {
                    ref.read(addRequestMoneyProvider.notifier).submitRequest();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    shadowColor: AppTheme.primary.withValues(alpha: 0.3),
                  ),
                  child: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Gửi Yêu Cầu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
         color: isDarkMode ? AppTheme.surfaceVariant : Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Số tiền con cần',
            style: TextStyle(
              color: isDarkMode ? Colors.grey.shade400 : AppTheme.textGrey,
              fontSize: 14,
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
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'đ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAmountChip(10000, '+10.000đ'),
                const SizedBox(width: 8),
                _buildAmountChip(20000, '+20.000đ'),
                const SizedBox(width: 8),
                _buildAmountSelectChip(50000, '+50.000đ'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAmountChip(double amount, String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () => _addAmount(amount),
      backgroundColor: Colors.transparent,
      side: BorderSide(color: Colors.grey.shade300),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.textGrey,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget _buildAmountSelectChip(double amount, String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () => _addAmount(amount),
      backgroundColor: Colors.green.shade50,
      side: const BorderSide(color: AppTheme.primary),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget _buildReasonSection(String selectedCategory, bool isDarkMode) {
    final categories = [
      {'id': 'snacks', 'icon': '🍔', 'label': 'Ăn vặt'},
      {'id': 'books', 'icon': '📚', 'label': 'Mua sách/vở'},
      {'id': 'games', 'icon': '🎮', 'label': 'Nạp game'},
      {'id': 'gifts', 'icon': '🎁', 'label': 'Mua quà'},
      {'id': 'other', 'icon': '📦', 'label': 'Khác'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Con cần tiền để làm gì nhỉ?',
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppTheme.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories.map((cat) {
              final isSelected = selectedCategory == cat['id'];
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cat['icon']!),
                    const SizedBox(width: 8),
                    Text(cat['label']!),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(addRequestMoneyProvider.notifier).updateCategory(cat['id']!);
                  }
                },
                selectedColor: isDarkMode ? AppTheme.primary.withValues(alpha: 0.2) : Colors.green.shade50,
                 backgroundColor: isDarkMode ? AppTheme.surfaceVariant : Colors.white,
                labelStyle: TextStyle(
                  color: isSelected
                      ? AppTheme.primary
                      : (isDarkMode ? Colors.grey.shade400 : AppTheme.textGrey),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                     color: isSelected ? AppTheme.primary : (isDarkMode ? AppTheme.borderDark : AppTheme.borderLight),
                  ),
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
          if (selectedCategory == 'other') ...[
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Nhập lý do cụ thể của con nhé...',
                hintStyle: TextStyle(color: isDarkMode ? Colors.grey.shade500 : AppTheme.textGrey, fontSize: 14),
                filled: true,
                 fillColor: isDarkMode ? AppTheme.surfaceVariant : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppTheme.primary, width: 2),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildRecipientSection(List<String> recipients, bool isDarkMode) {
    // Dummy structure mimicking the HTML UI
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAvatar('dad', 'Bố', 'https://lh3.googleusercontent.com/aida-public/AB6AXuADAs9JI_e4qPPm1HtjxzdGhjerJeZjW74Krn0v964K6zvUzlmgn4yFcu16o9BWbragxeIXR6RW4HRmrWG_BZpnflAPD_CFzcBBLto4FykvTIGvaF1nKdsw5nyIs2dN6cbVTe8E5__KgH6Xe-VGMHNXEMg-SqzmAARnqbE50l20OJijYf8RkQIkZmMqNXvT-J_Q88c7I6P8KEH_jqFaIdaf3_Awj8D3xeMkxZq7G_zIBT1gS_1qF4Su0xTgOrUTDPapE5diRAW1lEk', recipients, isDarkMode),
              const SizedBox(width: 8),
              _buildAvatar('mom', 'Mẹ', 'https://lh3.googleusercontent.com/aida-public/AB6AXuDlLLNa77xAMLLEc9wLpw2FxDLDT-mu6GvbqQb1DIynyZlhV57Er7TpPEaPqs3Orsv01tgHWS7_MLTou4g-j3C4BZdECMKC0R__8TPBUjjnhAc6u5nqpE4z136Btx_4hv4sgxSOtLlbRyp9GYPpb_1o_Yr6KhQTdYqqIpHzVSB4nIfoazR45B0zvX8s5e5ZDQM3fxbvj9zfBZxM7IWi_eEdjYewWVIatKNp82WrpLMhRMlIU3CxrkgfWOhP5ct7-mxSbzx_gh1G-vo', recipients, isDarkMode),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Yêu cầu sẽ được gửi tới Bố và Mẹ.\nChờ một chút xíu để được duyệt nhé!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey.shade400 : AppTheme.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String id, String name, String url, List<String> recipients, bool isDarkMode) {
    final isSelected = recipients.contains(id);
    return GestureDetector(
      onTap: () {
        ref.read(addRequestMoneyProvider.notifier).toggleRecipient(id);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppTheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 24,
               backgroundColor: isDarkMode ? AppTheme.surfaceVariant : Colors.white,
              backgroundImage: NetworkImage(url),
            ),
          ),
          if (isSelected)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? AppTheme.backgroundDark : Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

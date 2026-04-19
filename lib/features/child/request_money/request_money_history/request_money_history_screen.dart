import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/request_money/request_money_history/request_money_history_provider.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';
import 'package:monikid/app/app.dart';

class RequestMoneyHistoryScreen extends HookConsumerWidget {
  final RequestMoneyModel request;

  const RequestMoneyHistoryScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(requestMoneyHistoryProvider(request));
    final notifier = ref.read(requestMoneyHistoryProvider(request).notifier);

    // Initial values
    final amountController = useTextEditingController(text: request.amount.toInt().toString());
    final noteController = useTextEditingController(text: request.note ?? '');

    useEffect(() {
      amountController.addListener(() {
        final text = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (text.isNotEmpty) {
          notifier.updateAmount(double.parse(text));
        }
      });
      noteController.addListener(() {
        notifier.updateNote(noteController.text);
      });
      return null;
    }, [amountController, noteController]);

    // Handle side effects (Errors, Success)
    ref.listen(requestMoneyHistoryProvider(request), (previous, next) {
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
            message: s.msgUpdateSuccess,
            onPressed: () {
              context.pop();
              context.pop();
            },
          ),
        );
      }
    });

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDarkMode ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDarkMode ? Colors.white : AppTheme.textBlack;

    void addAmount(double addAmount) {
      if (amountController.text.isEmpty) {
        amountController.text = addAmount.toInt().toString();
      } else {
        final current = int.tryParse(amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        amountController.text = (current + addAmount.toInt()).toString();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: textColor),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Text(
                          'Chỉnh sửa yêu cầu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balancing space for the back button
                    ],
                  ),
                ),
                
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Amount Input Section (shadowed white box)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Số tiền yêu cầu',
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
                                      controller: amountController,
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
                            ],
                          ),
                        ),
                        
                        // Quick Select Chips
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildAmountChip(10000, '+10.000đ', () => addAmount(10000)),
                              const SizedBox(width: 8),
                              _buildAmountChip(20000, '+20.000đ', () => addAmount(20000)),
                              const SizedBox(width: 8),
                              _buildAmountPrimaryChip(50000, '+50.000đ', () => addAmount(50000)),
                            ],
                          ),
                        ),

                        // Category Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lý do của con',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildCategoryChip('books', '📚', 'Mua sách/vở', state.request?.category ?? '', isDarkMode, surfaceColor, notifier),
                                  _buildCategoryChip('snacks', '🍜', 'Ăn vặt', state.request?.category ?? '', isDarkMode, surfaceColor, notifier),
                                  _buildCategoryChip('games', '🎮', 'Nạp game', state.request?.category ?? '', isDarkMode, surfaceColor, notifier),
                                  _buildCategoryChip('gifts', '🎁', 'Quà tặng', state.request?.category ?? '', isDarkMode, surfaceColor, notifier),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Note Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ghi chú thêm',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: noteController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'Con cần mua gì?',
                                  hintStyle: TextStyle(
                                    color: isDarkMode ? Colors.grey.shade500 : AppTheme.textGrey,
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: surfaceColor,
                                  contentPadding: const EdgeInsets.all(16),
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
                            ],
                          ),
                        ),

                        // Recipients Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Người nhận yêu cầu',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _buildRecipientAvatar(
                                      'dad',
                                      'Bố',
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBCVUQGb4a6a4wUg9_b2rR9j6YPnOHJTin0okECJlEgHqrI27ZPAwsZqtac-_FjDjEQgQmeOtPMqJGWg5pmLXpjOygc8bb4ISaj3WD8YD3QK_ACZ_SjpEsvOxWrIxf3YQc5sr9dsYpTlEpYyDHHnKuOdtDuph6tBzjD-8WpRjMsrXghkgRCfsITem39Xu85TfZ6N__bF2o2JF4TVLsJvWFynbnGOdrRfpShJbITOZgO1lQadx41nUVAwC0d0dVHo30XtLVynPrXa8Y',
                                      state.request?.recipients ?? [],
                                      isDarkMode,
                                      surfaceColor,
                                      notifier),
                                  const SizedBox(width: 16),
                                  _buildRecipientAvatar(
                                      'mom',
                                      'Mẹ',
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBqFRSCpT4xBMH8bcmeI61Q3k9Ip0NRyIicmQ06kqdLoJRlTzsz5pKoBXEbS0o5UOvWNNzXfWdOAcBhx9jeWvgDNTvsi7M87OBuUN_Mtbsf4Jab2Yv6GTxfJ5Nv5tKo5HqG3I79dq6U0l1pO5jaHbSLyIlO8I1bjamFyRCjtvWcMALHEqciy7YScRJyxnb2HSH-Z5BIk1o5eV9qYAX-f0gyOOcXuciR2OEw4iorlgY2jC5l03mpwNYSiLsqPi8rRI3AAIAbowMeAR4',
                                      state.request?.recipients ?? [],
                                      isDarkMode,
                                      surfaceColor,
                                      notifier),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Action Buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.isSaving || state.isDeleting ? null : () => notifier.submitUpdate(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                          shadowColor: AppTheme.primary.withValues(alpha: 0.3),
                        ),
                        child: state.isSaving
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send, color: Colors.white, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Cập nhật yêu cầu',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: TextButton(
                        onPressed: state.isSaving || state.isDeleting ? null : () => notifier.deleteRequest(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: state.isDeleting
                            ? const CircularProgressIndicator(color: Colors.red)
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_outline, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Xóa yêu cầu',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountChip(double amount, String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.transparent,
      side: BorderSide(color: Colors.grey.shade400),
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

  Widget _buildAmountPrimaryChip(double amount, String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
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

  Widget _buildCategoryChip(String id, String icon, String label, String selectedId, bool isDarkMode, Color surfaceColor, dynamic notifier) {
    final isSelected = selectedId == id;
    return GestureDetector(
      onTap: () => notifier.updateCategory(id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primary : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
            width: 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: AppTheme.primary.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : (isDarkMode ? Colors.grey.shade300 : AppTheme.textBlack),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientAvatar(String id, String label, String avatarUrl, List<String> recipients, bool isDarkMode, Color backgroundColor, dynamic notifier) {
    final isSelected = recipients.contains(id);
    return GestureDetector(
      onTap: () => notifier.toggleRecipient(id),
      child: Column(
        children: [
          Stack(
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
                  radius: 28,
                  backgroundColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
                  backgroundImage: NetworkImage(avatarUrl),
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
                        color: backgroundColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.grey.shade300 : AppTheme.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}

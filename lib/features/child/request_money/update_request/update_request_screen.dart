import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/request_money/update_request/update_request_provider.dart';
import 'package:monikid/features/child/request_money/update_request/update_request_state.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';

class UpdateRequestScreen extends HookConsumerWidget {
  final RequestMoneyModel request;

  const UpdateRequestScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(updateRequestProvider(request));
    final notifier = ref.read(updateRequestProvider(request).notifier);

    // Local UI state — managed by hooks
    final amountController = useTextEditingController(text: request.amount.toInt().toString());
    final noteController = useTextEditingController(text: request.note ?? '');
    final selectedCategory = useState(request.category);
    final selectedRecipients = useState<List<String>>(List.from(request.recipients));

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDarkMode ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDarkMode ? Colors.white : AppTheme.textBlack;
    final subTextColor = isDarkMode ? Colors.grey.shade400 : AppTheme.textGrey;
    final borderColor = isDarkMode ? Colors.grey.shade700 : const Color(0xFFE2E8F0);

    // Side effects: handle state changes
    ref.listen<UpdateRequestState>(updateRequestProvider(request), (previous, next) {
      if (next == previous) return;
      if (next.isSuccess) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessDialog(
            message: s.msgUpdateSuccess,
            onPressed: () {
              context.pop();
              context.pop();
            },
          ),
        );
      } else if (next.isDeleted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => SuccessDialog(
            message: 'Đã xóa yêu cầu thành công',
            onPressed: () {
              context.pop();
              context.pop();
            },
          ),
        );
      } else if (next.isError && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
    });

    void addAmount(double add) {
      final current = int.tryParse(amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      amountController.text = (current + add.toInt()).toString();
    }

    void toggleRecipient(String id) {
      final list = List<String>.from(selectedRecipients.value);
      if (list.contains(id)) {
        list.remove(id);
      } else {
        list.add(id);
      }
      selectedRecipients.value = list;
    }

    void onSubmitUpdate() {
      final rawText = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final amount = double.tryParse(rawText) ?? 0.0;
      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.validationAmountGreaterThanZero), backgroundColor: AppTheme.redAlert),
        );
        return;
      }
      final updated = request.copyWith(
        amount: amount,
        category: selectedCategory.value,
        note: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
        recipients: selectedRecipients.value,
      );
      notifier.submitUpdate(updated);
    }

    void onDelete() {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Xóa yêu cầu'),
          content: const Text('Bạn có chắc chắn muốn xóa yêu cầu này không?'),
          actions: [
            TextButton(
              onPressed: () => dialogContext.pop(),
              child: Text(s.actionCancel),
            ),
            TextButton(
              onPressed: () {
                dialogContext.pop();
                notifier.deleteRequest();
              },
              style: TextButton.styleFrom(foregroundColor: AppTheme.redAlert),
              child: Text(s.actionConfirm),
            ),
          ],
        ),
      );
    }

    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ── Top App Bar ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: textColor),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Text(
                          s.editRequestTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // ── Scrollable Body ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Amount Input Section
                        _AmountSection(
                          amountController: amountController,
                          surfaceColor: surfaceColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                          onAddAmount: addAmount,
                        ),

                        const SizedBox(height: 16),

                        // Category Section
                        _CategorySection(
                          selectedCategory: selectedCategory.value,
                          onSelectCategory: (id) => selectedCategory.value = id,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                        ),

                        const SizedBox(height: 4),

                        // Note Section
                        _NoteSection(
                          noteController: noteController,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                        ),

                        const SizedBox(height: 4),

                        // Recipients Section
                        _RecipientsSection(
                          selectedRecipients: selectedRecipients.value,
                          textColor: textColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                          onToggle: toggleRecipient,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Pinned Action Buttons ────────────────────────────────────
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : onSubmitUpdate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 4,
                          shadowColor: AppTheme.primary.withValues(alpha: 0.3),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    s.actionUpdateRequest,
                                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: isLoading ? null : onDelete,
                        icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.redAlert),
                        label: Text(
                          s.actionDeleteRequest,
                          style: const TextStyle(color: AppTheme.redAlert, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.transparent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// Subwidgets
// ─────────────────────────────────────────────────────────────────────────────

class _AmountSection extends StatelessWidget {
  const _AmountSection({
    required this.amountController,
    required this.surfaceColor,
    required this.subTextColor,
    required this.borderColor,
    required this.isDarkMode,
    required this.onAddAmount,
  });

  final TextEditingController amountController;
  final Color surfaceColor;
  final Color subTextColor;
  final Color borderColor;
  final bool isDarkMode;
  final void Function(double) onAddAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
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
        children: [
          Text(
            'Số tiền yêu cầu',
            style: TextStyle(color: subTextColor, fontSize: 14),
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
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _amountChip('+10.000đ', false, () => onAddAmount(10000)),
                const SizedBox(width: 8),
                _amountChip('+20.000đ', false, () => onAddAmount(20000)),
                const SizedBox(width: 8),
                _amountChip('+50.000đ', true, () => onAddAmount(50000)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountChip(String label, bool isPrimary, VoidCallback onTap) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: isPrimary ? Colors.green.shade50 : Colors.transparent,
      side: BorderSide(color: isPrimary ? AppTheme.primary : borderColor),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isPrimary ? AppTheme.primary : (isDarkMode ? Colors.grey.shade400 : AppTheme.textGrey),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.selectedCategory,
    required this.onSelectCategory,
    required this.surfaceColor,
    required this.textColor,
    required this.borderColor,
    required this.isDarkMode,
  });

  final String selectedCategory;
  final void Function(String) onSelectCategory;
  final Color surfaceColor;
  final Color textColor;
  final Color borderColor;
  final bool isDarkMode;

  static const _categories = [
    {'id': 'books', 'icon': '📚', 'label': 'Mua sách/vở'},
    {'id': 'snacks', 'icon': '🍜', 'label': 'Ăn vặt'},
    {'id': 'games', 'icon': '🎮', 'label': 'Nạp game'},
    {'id': 'gifts', 'icon': '🎁', 'label': 'Quà tặng'},
    {'id': 'other', 'icon': '📦', 'label': 'Khác'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lý do của con',
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((cat) {
              final isSelected = selectedCategory == cat['id'];
              return GestureDetector(
                onTap: () => onSelectCategory(cat['id']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.primary : borderColor,
                    ),
                    boxShadow: isSelected
                        ? [BoxShadow(color: AppTheme.primary.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(cat['icon']!, style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        cat['label']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : (isDarkMode ? Colors.grey.shade300 : AppTheme.textBlack),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _NoteSection extends StatelessWidget {
  const _NoteSection({
    required this.noteController,
    required this.surfaceColor,
    required this.textColor,
    required this.subTextColor,
    required this.borderColor,
    required this.isDarkMode,
  });

  final TextEditingController noteController;
  final Color surfaceColor;
  final Color textColor;
  final Color subTextColor;
  final Color borderColor;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ghi chú thêm',
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Con cần mua gì?',
              hintStyle: TextStyle(color: subTextColor, fontSize: 14),
              filled: true,
              fillColor: surfaceColor,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.primary, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipientsSection extends StatelessWidget {
  const _RecipientsSection({
    required this.selectedRecipients,
    required this.textColor,
    required this.borderColor,
    required this.isDarkMode,
    required this.onToggle,
  });

  final List<String> selectedRecipients;
  final Color textColor;
  final Color borderColor;
  final bool isDarkMode;
  final void Function(String) onToggle;

  static const _recipients = [
    {
      'id': 'dad',
      'label': 'Bố',
      'url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBCVUQGb4a6a4wUg9_b2rR9j6YPnOHJTin0okECJlEgHqrI27ZPAwsZqtac-_FjDjEQgQmeOtPMqJGWg5pmLXpjOygc8bb4ISaj3WD8YD3QK_ACZ_SjpEsvOxWrIxf3YQc5sr9dsYpTlEpYyDHHnKuOdtDuph6tBzjD-8WpRjMsrXghkgRCfsITem39Xu85TfZ6N__bF2o2JF4TVLsJvWFynbnGOdrRfpShJbITOZgO1lQadx41nUVAwC0d0dVHo30XtLVynPrXa8Y',
    },
    {
      'id': 'mom',
      'label': 'Mẹ',
      'url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBqFRSCpT4xBMH8bcmeI61Q3k9Ip0NRyIicmQ06kqdLoJRlTzsz5pKoBXEbS0o5UOvWNNzXfWdOAcBhx9jeWvgDNTvsi7M87OBuUN_Mtbsf4Jab2Yv6GTxfJ5Nv5tKo5HqG3I79dq6U0l1pO5jaHbSLyIlO8I1bjamFyRCjtvWcMALHEqciy7YScRJyxnb2HSH-Z5BIk1o5eV9qYAX-f0gyOOcXuciR2OEw4iorlgY2jC5l03mpwNYSiLsqPi8rRI3AAIAbowMeAR4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Người nhận yêu cầu',
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: _recipients.map((r) {
              final isSelected = selectedRecipients.contains(r['id']);
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () => onToggle(r['id']!),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppTheme.primary : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(r['url']!),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode ? AppTheme.backgroundDark : Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(Icons.check, color: Colors.white, size: 10),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        r['label']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

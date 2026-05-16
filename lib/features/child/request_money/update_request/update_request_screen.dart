import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/request_money/update_request/update_request_provider.dart';
import 'package:monikid/features/child/request_money/update_request/update_request_state.dart';
import 'package:monikid/features/child/request_money/update_request/widgets/amount_section.dart';
import 'package:monikid/features/child/request_money/update_request/widgets/category_section.dart';
import 'package:monikid/features/child/request_money/update_request/widgets/note_section.dart';
import 'package:monikid/features/child/request_money/update_request/widgets/recipients_section.dart';
import 'package:monikid/features/child/request_money/update_request/widgets/request_action_bar.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';

class UpdateRequestScreen extends HookConsumerWidget {
  final RequestMoneyModel request;

  const UpdateRequestScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final state = ref.watch(updateRequestProvider(request));
    final notifier = ref.read(updateRequestProvider(request).notifier);

    // Local UI state — managed by hooks
    final amountController = useTextEditingController(text: request.amount.toInt().toString());
    final noteController = useTextEditingController(text: request.note ?? '');
    final selectedCategory = useState(request.category);
    final selectedRecipients = useState<List<String>>(List.from(request.recipients));

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDarkMode ? AppTheme.surfaceVariant : AppTheme.surfaceLight;
    final textColor = isDarkMode ? AppTheme.textWhite : AppTheme.textBlack;
    final subTextColor = isDarkMode ? AppTheme.iconLight : AppTheme.textGrey;
    final borderColor = isDarkMode ? AppTheme.borderDark : AppTheme.borderLight;

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
                        AmountSection(
                          amountController: amountController,
                          surfaceColor: surfaceColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                          onAddAmount: addAmount,
                        ),

                        const SizedBox(height: 16),

                        // Category Section
                        CategorySection(
                          selectedCategory: selectedCategory.value,
                          onSelectCategory: (id) => selectedCategory.value = id,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                        ),

                        const SizedBox(height: 4),

                        // Note Section
                        NoteSection(
                          noteController: noteController,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                          subTextColor: subTextColor,
                          borderColor: borderColor,
                          isDarkMode: isDarkMode,
                        ),

                        const SizedBox(height: 4),

                        // Recipients Section
                        RecipientsSection(
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
              child: RequestActionBar(
                isLoading: isLoading,
                onSubmitUpdate: onSubmitUpdate,
                onDelete: onDelete,
                backgroundColor: backgroundColor,
                updateLabel: s.actionUpdateRequest,
                deleteLabel: s.actionDeleteRequest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

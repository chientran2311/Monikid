import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/request_money/request_money_history/request_money_history_provider.dart';
import 'package:monikid/features/child/request_money/request_money_history/widgets/amount_input_section.dart';
import 'package:monikid/features/child/request_money/request_money_history/widgets/category_selection_section.dart';
import 'package:monikid/features/child/request_money/request_money_history/widgets/note_input_section.dart';
import 'package:monikid/features/child/request_money/request_money_history/widgets/quick_amount_chips.dart';
import 'package:monikid/features/child/request_money/request_money_history/widgets/recipients_section.dart';
import 'package:monikid/features/child/request_money/request_money_history/widgets/request_action_buttons.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';
import 'package:monikid/app/app.dart';

class RequestMoneyHistoryScreen extends HookConsumerWidget {
  final RequestMoneyModel request;

  const RequestMoneyHistoryScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final state = ref.watch(requestMoneyHistoryProvider(request));
    final notifier = ref.read(requestMoneyHistoryProvider(request).notifier);

    // Initial values
    final amountController = useTextEditingController(
      text: request.amount.toInt().toString(),
    );
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
      if (next.errorMessage != null &&
          previous?.errorMessage != next.errorMessage) {
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
    final backgroundColor =
        isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDarkMode ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDarkMode ? Colors.white : AppTheme.textBlack;

    void addAmount(double addAmount) {
      if (amountController.text.isEmpty) {
        amountController.text = addAmount.toInt().toString();
      } else {
        final current = int.tryParse(
                amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
            0;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      const SizedBox(
                          width: 48), // Balancing space for the back button
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
                        AmountInputSection(
                          amountController: amountController,
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                        ),
                        QuickAmountChips(onAddAmount: addAmount),
                        CategorySelectionSection(
                          selectedCategory: state.request?.category ?? '',
                          onCategoryChanged: notifier.updateCategory,
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                        ),
                        NoteInputSection(
                          noteController: noteController,
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                        ),
                        RecipientsSection(
                          recipients: state.request?.recipients ?? [],
                          onRecipientToggled: notifier.toggleRecipient,
                          isDarkMode: isDarkMode,
                          surfaceColor: surfaceColor,
                          textColor: textColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Action Buttons
            RequestActionButtons(
              onUpdate: notifier.submitUpdate,
              onDelete: notifier.deleteRequest,
              isSaving: state.isSaving,
              isDeleting: state.isDeleting,
              backgroundColor: backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/request_money/add_new_request/add_request_money_provider.dart';
import 'package:monikid/features/child/request_money/add_new_request/widgets/request_amount_section.dart';
import 'package:monikid/features/child/request_money/add_new_request/widgets/request_reason_section.dart';
import 'package:monikid/features/child/request_money/add_new_request/widgets/request_recipient_section.dart';
import 'package:monikid/features/child/request_money/add_new_request/widgets/request_submit_button.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';

class AddRequestMoneyScreen extends HookConsumerWidget {
  const AddRequestMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final amountController = useTextEditingController(text: '50000');
    final noteController = useTextEditingController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(addRequestMoneyProvider.notifier).updateAmount(50000.0);
      });

      void onAmountChanged() {
        final text = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (text.isNotEmpty) {
          ref
              .read(addRequestMoneyProvider.notifier)
              .updateAmount(double.parse(text));
        } else {
          ref.read(addRequestMoneyProvider.notifier).updateAmount(0.0);
        }
      }

      void onNoteChanged() {
        ref
            .read(addRequestMoneyProvider.notifier)
            .updateNote(noteController.text);
      }

      amountController.addListener(onAmountChanged);
      noteController.addListener(onNoteChanged);

      return () {
        amountController.removeListener(onAmountChanged);
        noteController.removeListener(onNoteChanged);
      };
    }, [amountController, noteController]);

    void addAmount(double addValue) {
      if (amountController.text.isEmpty) {
        amountController.text = addValue.toInt().toString();
      } else {
        final current = int.tryParse(
                amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
            0;
        amountController.text = (current + addValue.toInt()).toString();
      }
    }

    final state = ref.watch(addRequestMoneyProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    ref.listen(addRequestMoneyProvider, (previous, next) {
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
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : AppTheme.textBlack,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Xin tiền tiêu vặt',
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
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RequestAmountSection(
                  amountController: amountController,
                  isDark: isDarkMode,
                  onAddAmount: addAmount,
                ),
                RequestReasonSection(
                  selectedCategory: state.category,
                  noteController: noteController,
                  isDark: isDarkMode,
                  onCategorySelected: (categoryId) {
                    ref
                        .read(addRequestMoneyProvider.notifier)
                        .updateCategory(categoryId);
                  },
                ),
                RequestRecipientSection(
                  recipients: state.recipients,
                  isDark: isDarkMode,
                  onToggleRecipient: (id) {
                    ref
                        .read(addRequestMoneyProvider.notifier)
                        .toggleRecipient(id);
                  },
                ),
              ],
            ),
          ),
          RequestSubmitButton(
            isLoading: state.isLoading,
            backgroundColor: backgroundColor,
            onSubmit: () {
              ref.read(addRequestMoneyProvider.notifier).submitRequest();
            },
          ),
        ],
      ),
    );
  }
}

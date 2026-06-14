import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/dev_tools/dev_tools_provider.dart';
import 'package:monikid/features/dev_tools/widgets/faq_mock_card.dart';
import 'package:monikid/features/dev_tools/widgets/transaction_mock_card.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class DevToolsScreen extends ConsumerWidget {
  const DevToolsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(devToolsNotifierProvider);
    final notifier = ref.read(devToolsNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
      appBar: const GlassAppBar(title: 'Dev Tools'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            FaqMockCard(
              status: state.faqStatus,
              message: state.faqMessage,
              onSeed: notifier.seedMockFaq,
            ),
            SizedBox(height: 16.h),
            TransactionMockCard(
              status: state.txStatus,
              message: state.txMessage,
              selectedDate: state.selectedDate ?? DateTime.now(),
              transactionType: state.transactionType,
              selectedCategoryId: state.selectedCategoryId,
              onDateChanged: notifier.updateDate,
              onTypeChanged: notifier.updateTransactionType,
              onCategoryChanged: notifier.updateCategory,
              onAddTransaction: notifier.addMockTransaction,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

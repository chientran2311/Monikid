import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:uuid/uuid.dart';

/// Validates and saves a transaction
Future<void> saveTransactionData({
  required BuildContext context,
  required WidgetRef ref,
  required TextEditingController amountController,
  required String currentType,
  required String selectedCategoryKey,
  required String selectedCategory,
  required String selectedEmoji,
  required TextEditingController noteController,
  required DateTime selectedDate,
}) async {
  final s = context.l10n;

  // Validate amount not empty
  if (amountController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s.validationEnterAmount)),
    );
    return;
  }

  // Parse and validate amount
  final amountStr = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
  final amount = double.tryParse(amountStr) ?? 0.0;

  if (amount <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s.validationAmountGreaterThanZero)),
    );
    return;
  }

  // Validate user authentication
  final authState = ref.read(authSessionProvider);
  final user = authState.user;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s.transactionUserNotAuthenticated)),
    );
    return;
  }

  // Create transaction model
  final now = DateTime.now();
  final transaction = TransactionModel(
    transactionId: const Uuid().v4(),
    userId: user.uid,
    familyId: authState.account?.familyId,
    amountMinor: amount.round(),
    type: currentType,
    categoryKey: selectedCategoryKey,
    categoryLabel: selectedCategory,
    categoryIcon: selectedEmoji,
    note: noteController.text.trim(),
    source: 'manual',
    dateTs: selectedDate,
    createdAt: now,
    updatedAt: now,
  );

  // Save transaction
  await ref
      .read(addTransactionNotifierProvider.notifier)
      .addTransaction(transaction);
}

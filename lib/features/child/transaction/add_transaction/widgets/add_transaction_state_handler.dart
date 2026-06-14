import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_state.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/core/utils/build_context_x.dart';

/// Handles state changes for add transaction workflow
void handleAddTransactionStateChange(
  BuildContext context,
  AddTransactionState? previous,
  AddTransactionState next,
) {
  if (!context.mounted || previous?.status == next.status) {
    return;
  }

  switch (next.status) {
    case TransactionStatus.success:
      final s = context.l10n;
      context.pop();
      context.showSuccessSnackBar(s.msgAddTransactionSuccess);
      return;
    case TransactionStatus.error:
      if (next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
      }
      return;
    case TransactionStatus.initial:
    case TransactionStatus.loading:
    case TransactionStatus.ready:
    case TransactionStatus.submitting:
      return;
  }
}

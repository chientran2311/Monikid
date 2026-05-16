import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/transaction_app_bar.dart';

class MissingTransactionScaffold extends StatelessWidget {
  const MissingTransactionScaffold({
    required this.isDark,
    required this.errorMessage,
    super.key,
  });

  final bool isDark;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final s = context.l10n;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: TransactionAppBar(
        isDark: isDark,
        textColor: textColor,
        canPop: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            errorMessage ?? s.transactionLoadError,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

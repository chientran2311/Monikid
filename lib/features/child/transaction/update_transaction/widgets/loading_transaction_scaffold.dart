import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/update_transaction/widgets/transaction_app_bar.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';

class LoadingTransactionScaffold extends StatelessWidget {
  const LoadingTransactionScaffold({
    required this.isDark,
    super.key,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: TransactionAppBar(
        isDark: isDark,
        textColor: textColor,
        canPop: false,
      ),
      body: const TransactionEditorLoadingSkeleton(),
    );
  }
}

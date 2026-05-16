import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class ErrorTransactionState extends StatelessWidget {
  final String errorMessage;
  final bool isDark;

  const ErrorTransactionState({
    super.key,
    required this.errorMessage,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppTheme.redAlert),
          const SizedBox(height: 12),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? AppTheme.textWhite.withValues(alpha: 0.7) : AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

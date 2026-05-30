import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class EmptyTransactionState extends StatelessWidget {
  final bool isDark;

  const EmptyTransactionState({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 56,
            color: isDark ? Colors.white24 : Colors.black12,
          ),
          const SizedBox(height: 12),
          Text(
            'Không có giao dịch nào.',
            textAlign: TextAlign.center,
            style: context.typo.body.medium.copyWith(
              color: isDark ? AppTheme.textWhite.withValues(alpha: 0.54) : AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

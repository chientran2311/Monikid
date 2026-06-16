import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class TransactionItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String amount;
  final bool isIncome;
  final Color bgColor;
  final bool isDark;
  final VoidCallback? onTap;

  const TransactionItem({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    required this.bgColor,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLightGrey;
    final amountColor = isIncome ? AppTheme.primary : AppTheme.redAlert;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: context.typo.title.medium,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.typo.subtitle.small.copyWith(
                        color: isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: context.typo.caption.big.copyWith(
                        color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              amount,
              style: context.typo.subtitle.small.copyWith(color: amountColor),
            ),
          ],
        ),
      ),
    );
  }
}

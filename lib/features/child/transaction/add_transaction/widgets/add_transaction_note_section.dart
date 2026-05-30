import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class AddTransactionNoteSection extends StatelessWidget {
  const AddTransactionNoteSection({
    super.key,
    required this.controller,
    required this.enabled,
    required this.showAiBadge,
    required this.isDark,
    required this.surfaceColor,
    required this.textColor,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool showAiBadge;
  final bool isDark;
  final Color surfaceColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              s.transactionNoteLabel,
              style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w500, color: isDark
                    ? AppTheme.iconLight
                    : AppTheme.borderDark),
            ),
            if (showAiBadge)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      s.transactionAiAutoLabel,
                      style: context.typo.caption.big.copyWith(fontWeight: FontWeight.w500, color: AppTheme.primary),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? AppTheme.borderDark
                  : const Color(0xFFF1F5F9),
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            maxLines: 3,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: s.addTransactionNoteHint,
              hintStyle: const TextStyle(color: AppTheme.textMuted),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}

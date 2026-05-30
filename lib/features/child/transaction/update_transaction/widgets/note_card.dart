import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.controller,
    required this.enabled,
    required this.isDark,
    required this.surfaceColor,
    required this.textColor,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool isDark;
  final Color surfaceColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.surfaceVariant
                  : const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit_note,
              color: AppTheme.textGrey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.transactionNoteLabel,
                  style: context.typo.caption.big.copyWith(fontWeight: FontWeight.w500, color: AppTheme.textGrey),
                ),
                TextField(
                  controller: controller,
                  enabled: enabled,
                  maxLines: 2,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: s.updateTransactionNoteHint,
                    hintStyle: const TextStyle(color: AppTheme.textMuted),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

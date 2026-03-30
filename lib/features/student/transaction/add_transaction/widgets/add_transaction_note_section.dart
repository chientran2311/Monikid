import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class AddTransactionNoteSection extends StatelessWidget {
  const AddTransactionNoteSection({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ghi chú',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF334155),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 14,
                    color: AppTheme.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'AI Tự động',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primary,
                    ),
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
                  ? const Color(0xFF334155)
                  : const Color(0xFFF1F5F9),
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
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
            decoration: const InputDecoration(
              hintText: 'Nhập ghi chú, AI sẽ tự động phân loại...',
              hintStyle: TextStyle(color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}

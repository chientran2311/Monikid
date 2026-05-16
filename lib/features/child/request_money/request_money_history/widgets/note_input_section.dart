import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class NoteInputSection extends StatelessWidget {
  const NoteInputSection({
    required this.noteController,
    required this.isDarkMode,
    required this.surfaceColor,
    required this.textColor,
    super.key,
  });

  final TextEditingController noteController;
  final bool isDarkMode;
  final Color surfaceColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ghi chú thêm',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Con cần mua gì?',
              hintStyle: TextStyle(
                color: isDarkMode ? Colors.grey.shade500 : AppTheme.textGrey,
                fontSize: 14,
              ),
              filled: true,
              fillColor: surfaceColor,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppTheme.primary, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

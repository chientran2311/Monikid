import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';

class SubmitBar extends StatelessWidget {
  const SubmitBar({
    super.key,
    required this.isDark,
    required this.isSubmitting,
    required this.enabled,
    required this.onSubmit,
  });

  final bool isDark;
  final bool isSubmitting;
  final bool enabled;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.backgroundDark.withValues(alpha: 0.9)
            : AppTheme.backgroundLight.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
            color: isDark
                ? const Color(0xFF1E293B)
                : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: enabled ? onSubmit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1e5222),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
        ),
        child: isSubmitting
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    s.updateTransactionAction,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

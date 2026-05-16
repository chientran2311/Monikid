import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class TransactionSubmitButton extends StatelessWidget {
  const TransactionSubmitButton({
    required this.onPressed,
    required this.label,
    required this.enabled,
    required this.backgroundColor,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final bool enabled;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withValues(alpha: 0.0),
              backgroundColor,
              backgroundColor,
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: AppTheme.primary.withValues(alpha: 0.4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

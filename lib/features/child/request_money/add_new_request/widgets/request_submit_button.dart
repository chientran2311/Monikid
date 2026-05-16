import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RequestSubmitButton extends StatelessWidget {
  const RequestSubmitButton({
    required this.isLoading,
    required this.backgroundColor,
    required this.onSubmit,
    super.key,
  });

  final bool isLoading;
  final Color backgroundColor;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: AppTheme.primary.withValues(alpha: 0.3),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Gửi Yêu Cầu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

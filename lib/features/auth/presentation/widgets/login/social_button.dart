import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart ';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMD,
          vertical: AppTheme.spacingMD,
        ),
        side: BorderSide(color: AppTheme.gray300),
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadiusMD,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: AppTheme.textPrimaryLight),
          const SizedBox(width: AppTheme.spacingSM),
          Text(
            text,
            style: AppTheme.titleMedium.copyWith(
              color: AppTheme.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
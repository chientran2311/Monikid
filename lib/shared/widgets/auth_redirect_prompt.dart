import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class AuthRedirectPrompt extends StatelessWidget {
  const AuthRedirectPrompt({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.typo.text.medium.copyWith(
          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
        ),
        children: [
          TextSpan(text: promptText),
          TextSpan(
            text: actionText,
            style: context.typo.subtitle.small.copyWith(color: AppTheme.primary),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

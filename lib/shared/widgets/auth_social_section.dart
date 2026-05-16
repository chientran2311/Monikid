import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/shared/widgets/social_button.dart';

class AuthSocialSection extends StatelessWidget {
  const AuthSocialSection({
    super.key,
    this.label = 'Hoặc tiếp tục với',
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  final String label;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                label,
                style: context.typo.text.medium.copyWith(
                  color: isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: SocialButton(
                text: 'Google',
                icon: const Icon(
                  Icons.g_mobiledata,
                  size: 24,
                  color: Color(0xFFDB4437),
                ),
                onPressed: onGooglePressed,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SocialButton(
                text: 'Apple',
                icon: Icon(
                  Icons.apple,
                  size: 24,
                  color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                ),
                onPressed: onApplePressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

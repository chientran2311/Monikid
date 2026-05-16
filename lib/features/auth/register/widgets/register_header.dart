import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Tạo tài khoản',
          style: context.typo.bigTitle.medium.copyWith(
            letterSpacing: -0.5,
            color: isDark ? AppTheme.primaryLight : AppTheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tham gia MoniKid để quản lý tài chính gia đình.',
          textAlign: TextAlign.center,
          style: context.typo.text.medium.copyWith(
            color:
                isDark ? AppTheme.textMuted : AppTheme.textGrey,
          ),
        ),
      ],
    );
  }
}

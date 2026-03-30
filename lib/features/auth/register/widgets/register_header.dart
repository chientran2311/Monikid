import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

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
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: isDark ? AppTheme.primaryLight : AppTheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tham gia MoniKid để quản lý tài chính gia đình.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            color:
                isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}

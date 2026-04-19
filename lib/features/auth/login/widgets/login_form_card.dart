import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/shared/widgets/auth_card.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.errorMessage,
    required this.onLogin,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final String? errorMessage;
  final Future<void> Function() onLogin;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomInputWidget(
            label: 'Email',
            placeholder: 'nguyenvana@example.com',
            prefixIcon: Icons.mail_outline,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          CustomInputWidget(
            label: 'Mật khẩu',
            placeholder: '••••••••',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: passwordController,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.push(AppRoutes.forgotPassword),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Quên mật khẩu?',
                style: context.typo.subtitle.small.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: context.typo.text.medium.copyWith(
                  color: AppTheme.redAlert,
                ),
              ),
            ),
          PrimaryButton(
            text: 'Đăng nhập',
            isLoading: isLoading,
            onPressed: onLogin,
          ),
        ],
      ),
    );
  }
}

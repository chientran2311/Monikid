import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/login/login_provider.dart';
import 'package:monikid/features/auth/login/widgets/login_form_card.dart';
import 'package:monikid/features/auth/login/widgets/login_header.dart';
import 'package:monikid/shared/widgets/auth_redirect_prompt.dart';
import 'package:monikid/shared/widgets/auth_social_section.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    ref.read(loginProvider.notifier).clearError();
    await ref.read(loginProvider.notifier).signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 64,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginHeader(),
                    LoginFormCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isLoading: loginState.isLoading,
                      errorMessage: loginState.errorMessage,
                      onLogin: _handleLogin,
                    ),
                    const SizedBox(height: 32),
                    AuthSocialSection(
                      onGooglePressed: () {},
                      onApplePressed: () {},
                    ),
                    const SizedBox(height: 32),
                    AuthRedirectPrompt(
                      promptText: 'Chưa có tài khoản? ',
                      actionText: 'Đăng ký',
                      onTap: () => context.push(AppRoutes.register),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

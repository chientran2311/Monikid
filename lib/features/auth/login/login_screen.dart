import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/login/login_provider.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/social_button.dart';
import 'package:monikid/shared/widgets/auth_card.dart';
import 'package:monikid/features/auth/login/widgets/login_header.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
    // Clear any old error and delegate to loginProvider
    ref.read(loginProvider.notifier).clearError();
    await ref
        .read(loginProvider.notifier)
        .signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.backgroundDark
          : AppTheme.backgroundLight,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 64,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginHeader(),

                    // --- SECTION 2: AUTH FORM ---
                    AuthCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Form Inputs
                          CustomInputWidget(
                            label: "Email",
                            placeholder: "nguyenvana@example.com",
                            prefixIcon: Icons.mail_outline,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          CustomInputWidget(
                            label: "Mật khẩu",
                            placeholder: "••••••••",
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 8),
                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  context.push(AppRoutes.forgotPassword),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Quên mật khẩu?",
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Error Message Display
                          if (loginState.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                loginState.errorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppTheme.redAlert,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                          // Login Button
                          PrimaryButton(
                            text: "Đăng nhập",
                            isLoading: loginState.isLoading,
                            onPressed: _handleLogin,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // --- SECTION 3: SOCIAL LOGIN & FOOTER ---
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
                            "Hoặc tiếp tục với",
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF64748B),
                              fontSize: 14,
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
                            text: "Google",
                            icon: const Icon(
                              Icons.g_mobiledata,
                              size: 24,
                              color: Color(0xFFDB4437),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SocialButton(
                            text: "Apple",
                            icon: Icon(
                              Icons.apple,
                              size: 24,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Chưa có tài khoản? ",
                          style: TextStyle(
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.register),
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
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

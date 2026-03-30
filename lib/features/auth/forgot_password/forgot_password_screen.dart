import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_provider.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';

import 'widgets/illustration_section.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    await ref.read(forgotPasswordProvider.notifier).submit(
          _emailController.text.trim(),
        );

    if (!mounted) return;

    final forgotPasswordState = ref.read(forgotPasswordProvider);
    if (forgotPasswordState.isSuccess) {
      final email = _emailController.text.trim();
      SuccessDialog.show(
        context,
        title: 'Email đã được gửi!',
        message:
            'Chúng tôi đã gửi link đặt lại mật khẩu đến\n$email\n\nVui lòng kiểm tra hộp thư rồi nhấn vào link để đổi mật khẩu.',
        buttonText: 'Quay về Đăng nhập',
        icon: Icons.mark_email_read_rounded,
        onPressed: () {
          Navigator.of(context).pop();
          context.go(AppRoutes.login);
        },
      );
      return;
    }

    if (forgotPasswordState.errorMessage != null) {
      AppSnackBar.error(context, forgotPasswordState.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 48),
                      child: Text(
                        'Quên mật khẩu?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const IllustrationSection(),
                    const SizedBox(height: 32),
                    Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Đừng lo lắng! Hãy nhập email đã đăng ký, chúng tôi sẽ gửi mã xác thực để bạn đặt lại mật khẩu.',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        height: 1.5,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomInputWidget(
                      label: 'Email',
                      placeholder: 'Nhập email của bạn',
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Gửi mã xác thực',
                      icon: Icons.send_rounded,
                      onPressed: _handleResetPassword,
                      isLoading: forgotPasswordState.isLoading,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: GestureDetector(
                onTap: () => context.go(AppRoutes.login),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: AppTheme.primary,
                    ),
                     SizedBox(width: 8),
                     Text(
                      'Quay lại Đăng nhập',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

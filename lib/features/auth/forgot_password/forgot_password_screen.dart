import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/validators.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/features/auth/domain/params/auth_param.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';
import 'widgets/illustration_section.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    final email = _emailController.text.trim();

    // Validate
    final emailError = Validators.email(email);
    if (emailError != null) {
      AppSnackBar.warning(context, emailError);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authProvider.notifier)
          .resetUserPassword(ResetPasswordParam(email: email));
      if (mounted) {
        setState(() => _isLoading = false);
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
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        final authState = ref.read(authProvider);
        AppSnackBar.error(context, authState.errorMessage ?? 'Có lỗi xảy ra');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.backgroundDark
          : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header Navigation (matching HTML p-4 pb-2 justify-between)
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
                      padding: const EdgeInsets.only(
                        right: 48.0,
                      ), // center balancing
                      child: Text(
                        'Quên mật khẩu?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18, // text-lg
                          fontWeight: FontWeight.w700, // font-bold
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

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16), // pt-4
                    // Illustration Container
                    const IllustrationSection(),
                    const SizedBox(height: 32),

                    // Content text
                    Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 28, // text-3xl approx
                        fontWeight: FontWeight.w800, // font-bold
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
                            : const Color(0xFF475569), // text-slate-600
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Form Section
                    CustomInputWidget(
                      label: 'Email',
                      placeholder: 'Nhập email của bạn',
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 24),

                    // Primary Action Button
                    PrimaryButton(
                      text: 'Gửi mã xác thực',
                      icon: Icons.send_rounded,
                      onPressed: _handleResetPassword,
                      isLoading: _isLoading,
                    ),
                  ],
                ),
              ),
            ),

            // Footer - Back to Login
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: GestureDetector(
                onTap: () => context.go(AppRoutes.login),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
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

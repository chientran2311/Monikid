import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';
import 'widgets/password_strength_indicator.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdatePasswordScreen> createState() =>
      _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Listen để rebuild PasswordStrengthIndicator khi password thay đổi
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleUpdatePassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validation
    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() => _errorMessage = 'Vui lòng nhập đầy đủ thông tin');
      return;
    }

    if (password.length < 6) {
      setState(() => _errorMessage = 'Mật khẩu phải có ít nhất 6 ký tự');
      return;
    }

    if (password != confirmPassword) {
      setState(() => _errorMessage = 'Mật khẩu xác nhận không khớp');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    // TODO: Phase B — Gọi authProvider.updatePassword(password)
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        // Show success dialog
        SuccessDialog.show(
          context,
          title: 'Thành công!',
          message:
              'Mật khẩu của bạn đã được thay đổi. Bây giờ bạn có thể đăng nhập bằng mật khẩu mới.',
          buttonText: 'Đăng nhập ngay',
          onPressed: () {
            Navigator.of(context).pop(); // Đóng dialog
            context.go(AppRoutes.login); // Về trang login
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      'Đặt lại mật khẩu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance spacer
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Icon section
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Blur glow
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                          // Icon circle
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock_reset_rounded,
                              color: AppTheme.primary,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'Mật khẩu mới',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      'Vui lòng nhập mật khẩu mới của bạn. Hãy chắc chắn rằng mật khẩu này đủ mạnh để bảo vệ tài chính của bạn.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // New Password
                    CustomInputWidget(
                      label: 'Mật khẩu mới',
                      placeholder: '••••••••',
                      prefixIcon: Icons.key_rounded,
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 16),

                    // Password Strength Indicator
                    PasswordStrengthIndicator(
                      password: _passwordController.text,
                    ),
                    const SizedBox(height: 24),

                    // Confirm Password
                    CustomInputWidget(
                      label: 'Xác nhận mật khẩu mới',
                      placeholder: '••••••••',
                      prefixIcon: Icons.verified_user_outlined,
                      isPassword: true,
                      controller: _confirmPasswordController,
                    ),

                    // Error message
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: AppTheme.redAlert,
                            fontSize: 13,
                          ),
                        ),
                      ),

                    const SizedBox(height: 40),

                    // Update Button
                    PrimaryButton(
                      text: 'Cập nhật mật khẩu',
                      icon: Icons.check_circle_outline,
                      onPressed: _handleUpdatePassword,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 24),

                    // Support link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF94A3B8),
                          ),
                          children: [
                            const TextSpan(text: 'Bạn gặp sự cố? '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: Navigate to support
                                },
                                child: const Text(
                                  'Liên hệ hỗ trợ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
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

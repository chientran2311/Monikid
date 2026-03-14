import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/App/app.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/features/auth/domain/params/auth_param.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/social_button.dart';
import 'package:monikid/shared/widgets/auth_card.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'parent';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(s.validationEmptyFields),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    try {
      await ref
          .read(authProvider.notifier)
          .registerUser(
            SignUpParam(
              email: email,
              password: password,
              fullName: fullName,
              phone: phone,
              role: _selectedRole,
            ),
          );
      // Router handles redirection natively
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.registerFailed(e.toString())),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
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
                  minHeight: constraints.maxHeight - 64, // Subtract padding
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- SECTION 1: HEADER & TITLE ---
                    // Heading instead of large illustration for Register
                    const SizedBox(height: 16),
                    Text(
                      "Tạo tài khoản",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 32, // text-3xl
                        fontWeight: FontWeight.w800, // font-extrabold
                        letterSpacing: -0.5,
                        color: isDark
                            ? AppTheme.primaryLight
                            : AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8), // mt-2
                    Text(
                      "Tham gia MoniKid để quản lý tài chính gia đình.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B), // text-slate-500
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- SECTION 2: AUTH FORM ---
                    AuthCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Role Selector Toggle
                          Container(
                            padding: const EdgeInsets.all(4), // p-1
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppTheme.backgroundDark
                                  : AppTheme.backgroundLight,
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // rounded-lg
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => _selectedRole = 'parent',
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ), // py-2
                                      decoration: BoxDecoration(
                                        color: _selectedRole == 'parent'
                                            ? (isDark
                                                  ? const Color(0xFF334155)
                                                  : Colors.white)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ), // rounded-md
                                        boxShadow: _selectedRole == 'parent'
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 4,
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.family_restroom,
                                            size: 16,
                                            color: _selectedRole == 'parent'
                                                ? AppTheme.primary
                                                : (isDark
                                                      ? const Color(0xFF94A3B8)
                                                      : const Color(
                                                          0xFF64748B,
                                                        )),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Phụ huynh",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w600, // font-semibold
                                              color: _selectedRole == 'parent'
                                                  ? (isDark
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFF0F172A,
                                                          ))
                                                  : (isDark
                                                        ? const Color(
                                                            0xFF94A3B8,
                                                          )
                                                        : const Color(
                                                            0xFF64748B,
                                                          )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => _selectedRole = 'student',
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ), // py-2
                                      decoration: BoxDecoration(
                                        color: _selectedRole == 'student'
                                            ? (isDark
                                                  ? const Color(0xFF334155)
                                                  : Colors.white)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ), // rounded-md
                                        boxShadow: _selectedRole == 'student'
                                            ? [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 4,
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.school,
                                            size: 16,
                                            color: _selectedRole == 'student'
                                                ? AppTheme.primary
                                                : (isDark
                                                      ? const Color(0xFF94A3B8)
                                                      : const Color(
                                                          0xFF64748B,
                                                        )),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Học sinh",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w600, // font-semibold
                                              color: _selectedRole == 'student'
                                                  ? (isDark
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFF0F172A,
                                                          ))
                                                  : (isDark
                                                        ? const Color(
                                                            0xFF94A3B8,
                                                          )
                                                        : const Color(
                                                            0xFF64748B,
                                                          )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24), // space-y-6 equivalent
                          // Form Inputs
                          CustomInputWidget(
                            label: "Họ và tên",
                            placeholder: "Nguyễn Văn A",
                            prefixIcon: Icons.person_outline,
                            controller: _fullNameController,
                          ),
                          const SizedBox(height: 20),
                          CustomInputWidget(
                            label: "Email",
                            placeholder: "nguyenvana@example.com",
                            prefixIcon: Icons.mail_outline,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          CustomInputWidget(
                            label: "Số điện thoại (Tùy chọn)",
                            placeholder: "090xxxxxxx",
                            prefixIcon: Icons.phone_android,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          CustomInputWidget(
                            label: "Mật khẩu",
                            placeholder: "••••••••",
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 32),

                          // Error Message Display
                          if (authState.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                authState.errorMessage!,
                                style: const TextStyle(
                                  color: AppTheme.redAlert,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                          // Register Button
                          PrimaryButton(
                            text: "Đăng ký",
                            isLoading: authState.isLoading,
                            onPressed: _handleSignUp,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32), // mt-8
                    // --- SECTION 3: SOCIAL LOGIN & FOOTER ---
                    // Divider
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

                    // Social Buttons Row
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

                    // Log In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Đã có tài khoản? ",
                          style: TextStyle(
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.login),
                          child: Text(
                            "Đăng nhập",
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

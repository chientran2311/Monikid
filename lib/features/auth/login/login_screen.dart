import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/social_button.dart';
import 'package:monikid/shared/widgets/auth_card.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'parent'; // Default role based on HTML

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập email và mật khẩu'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    try {
      await ref
          .read(authProvider.notifier)
          .signIn(email: email, password: password);
      // Let the router handle redirection based on auth state & role
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng nhập thất bại: ${e.toString()}'),
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
                    // --- SECTION 1: HEADER & ILLUSTRATION ---
                    // Abstract Illustration
                    Container(
                      width: 128, // w-32
                      height: 128, // h-32
                      margin: const EdgeInsets.only(bottom: 32), // mb-8
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(
                          40,
                        ), // rounded-[40px]
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ), // border-white border-4
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05), // shadow-md
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 64, // w-16
                            height: 64, // h-16
                            decoration: const BoxDecoration(
                              color: Color(0xFFF97316), // bg-orange-500
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Positioned(
                            bottom: -16, // -bottom-4
                            child: Icon(
                              Icons.yard_rounded, // potted_plant equivalent
                              size: 80, // text-[80px]
                              color: AppTheme.primary,
                            ),
                          ),
                          // Sparkles
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Icon(
                              Icons.star_rounded,
                              color: const Color(0xFFFDE047),
                              size: 16,
                            ), // text-yellow-300 text-sm
                          ),
                          Positioned(
                            top: 32,
                            left: 16,
                            child: Icon(
                              Icons.star_rounded,
                              color: const Color(0xFF93C5FD),
                              size: 24,
                            ), // text-blue-300 text-xl
                          ),
                        ],
                      ),
                    ),

                    // Title & Tagline
                    Text(
                      "MoniKid",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 36, // text-4xl
                        fontWeight: FontWeight.w800, // font-extrabold
                        letterSpacing: -0.5,
                        color: isDark
                            ? AppTheme.primaryLight
                            : AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8), // mt-2
                    Text(
                      "Quản lý tài chính an toàn cho gia đình bạn.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(
                                0xFF64748B,
                              ), // text-slate-500 / slate-400
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
                          const SizedBox(height: 8), // mt-2
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
                                  fontWeight: FontWeight.w600, // font-semibold
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24), // mt-6
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

                          // Login Button
                          PrimaryButton(
                            text: "Đăng nhập",
                            isLoading: authState.isLoading,
                            onPressed: _handleLogin,
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
                        ), // border-slate-200
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ), // px-4
                          child: Text(
                            "Hoặc tiếp tục với",
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF64748B), // text-slate-500
                              fontSize: 14, // text-sm
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
                    const SizedBox(height: 24), // mt-6
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
                            ), // Fake Google icon
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16), // gap-4
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
                    const SizedBox(height: 32), // mt-8
                    // Sign Up Link
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
                              fontWeight: FontWeight.w600, // font-semibold
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

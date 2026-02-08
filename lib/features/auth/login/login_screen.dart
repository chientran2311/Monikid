import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/features/auth/login/widget/social_button.dart';

// --- PHẦN 2: CÁC WIDGET TÙY CHỈNH (CUSTOM WIDGETS) ---

// --- PHẦN 3: MÀN HÌNH CHÍNH (MAIN SCREEN) ---

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
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter email and password'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    try {
      await ref.read(authProvider.notifier).signIn(
        email: email,
        password: password,
      );
      // Router sẽ tự redirect về home khi auth state thay đổi
      // Không cần gọi context.go() ở đây
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        // LayoutBuilder + SingleChildScrollView + ConstrainedBox
        // Giúp dùng được Expanded/Spacer ngay cả khi có ScrollView
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints
                      .maxHeight, // Chiều cao tối thiểu bằng màn hình
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        // --- SECTION 1: LOGO & HEADER ---
                        // Dùng Expanded hoặc Spacer để đẩy nội dung ra
                        const Spacer(flex: 1),
                        Center(
                          child: Column(
                            children: [
                              // Logo Container
                              Container(
                                // TỐI ƯU RESPONSIVE:
                                // Logo sẽ chiếm khoảng 10% chiều cao màn hình,
                                // nhưng không nhỏ hơn 60px và không to quá 100px.
                                width: (size.height * 0.1).clamp(60.0, 100.0),
                                height: (size.height * 0.1).clamp(60.0, 100.0),
                                decoration: BoxDecoration(
                                  color: AppTheme.inputBackground,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryGreen.withOpacity(
                                        0.1,
                                      ),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                // Icon cũng scale theo kích thước container
                                child: Icon(
                                  Icons.verified_user_outlined,
                                  color: AppTheme.primaryGreen,
                                  size: (size.height * 0.05).clamp(
                                    30.0,
                                    50.0,
                                  ), // Icon scale theo
                                ),
                              ),

                              // Khoảng cách cũng nên responsive một chút
                              SizedBox(height: size.height * 0.02),

                              const Text(
                                "MoniKid",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textWhite,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              const Text(
                                "Safe financial management for your family.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textGrey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),

                        // --- SECTION 2: INPUTS & ACTIONS ---
                        Column(
                          children: [
                            // Row 1: Email Input
                            CustomInputWidget(
                              label: "Email",
                              placeholder: "Enter your email",
                              prefixIcon: Icons.email_outlined,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),

                            // Row 2: Password Input
                            CustomInputWidget(
                              label: "Password",
                              placeholder: "Enter your password",
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              controller: _passwordController,
                            ),

                            // Row 3: Forgot Password (Align Right)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Row 4: Primary Button
                            authState.isLoading
                                ? const CircularProgressIndicator(
                                    color: AppTheme.primaryGreen,
                                  )
                                : PrimaryButton(
                                    text: "Log In",
                                    onPressed: _handleLogin,
                                  ),
                                  
                            // Error message
                            if (authState.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  authState.errorMessage!,
                                  style: const TextStyle(
                                    color: AppTheme.redAlert,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const Spacer(flex: 1),

                        // --- SECTION 3: FOOTER ---
                        Column(
                          children: [
                            // Row 1: Divider Text
                            const Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white24)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Or continue with",
                                    style: TextStyle(
                                      color: AppTheme.textGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.white24)),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Row 2: Social Buttons
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Ở đây mình dùng Icon thay cho Asset ảnh để demo nhanh
                                // Bạn có thể thay Icon bằng Image.asset
                                SocialButton(
                                  icon: Icons.g_mobiledata,
                                  iconColor: Colors.red,
                                ),
                                SizedBox(width: 20),
                                SocialButton(
                                  icon: Icons.apple,
                                  iconColor: Colors.white,
                                ),
                                SizedBox(width: 20),
                                SocialButton(
                                  icon: Icons.face,
                                  iconColor: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Row 3: Sign Up Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: AppTheme.textGrey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push(AppRoutes.register);
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: AppTheme.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Padding bottom an toàn
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

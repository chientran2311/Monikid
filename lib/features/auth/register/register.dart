import 'package:flutter/gestures.dart'; // Dùng cho TapGestureRecognizer ở phần Terms
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/custom_input.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Biến trạng thái để ẩn/hiện password
  bool _isPasswordVisible = false;

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
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    try {
      await ref.read(authProvider.notifier).signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: 'parent', // Default role
      );
      // Router sẽ tự redirect về home khi auth state thay đổi
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop(); // Quay lại màn hình trước
          },
        ),
      ),
      // Sử dụng SingleChildScrollView để cuộn được khi bàn phím hiện lên
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECTION 1: HEADER ---
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.inputBackground,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: const Icon(Icons.verified_user_outlined, color: AppTheme.primaryGreen, size: 32),
                ),
              ),
              const SizedBox(height: 24),
              
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join MoniKid to manage your family's finances safely and securely.",
                style: TextStyle(color: AppTheme.textGrey, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 32),

              // --- SECTION 2: FORM ---
              
              // 1. Full Name
              CustomInputWidget(
                label: "FULL NAME",
                placeholder: "e.g. Sarah Smith",
                prefixIcon: Icons.person_outline,
                controller: _fullNameController,
              ),
              const SizedBox(height: 20),

              // 2. Email
              CustomInputWidget(
                label: "EMAIL ADDRESS",
                placeholder: "sarah@example.com",
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // 3. Phone Number (Cấu trúc đặc biệt: Row)
              const Text(
                "PHONE NUMBER",
                style: TextStyle(
                  color: AppTheme.textWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 12, // Label nhỏ in hoa
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Căn trên để khớp height
                children: [
                  // Input Phone (Chiếm phần lớn)
                  Expanded(
                    child: Container(
                      height: 55, // Set chiều cao cố định để khớp nút Verify
                      decoration: BoxDecoration(
                        color: AppTheme.inputBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.black87),
                        decoration: const InputDecoration(
                          hintText: "(555) 000-0000",
                          hintStyle: TextStyle(color: AppTheme.textGrey, fontSize: 14),
                          prefixIcon: Icon(Icons.phone_android, color: AppTheme.textGrey, size: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Verify Button
                  Container(
                    height: 55,
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primaryGreen),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: () { print("Verify SMS"); },
                      child: const Text(
                        "Verify",
                        style: TextStyle(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Helper Text
             const Padding(
                padding: EdgeInsets.only(top: 8.0, left: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 12, color: AppTheme.textGrey),
                    SizedBox(width: 4),
                    Text(
                      "Verification code will be sent via SMS",
                      style: TextStyle(color: AppTheme.textGrey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 4. Password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PASSWORD",
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.inputBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Create a strong password",
                        hintStyle: const TextStyle(color: AppTheme.textGrey, fontSize: 14),
                        prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.textGrey, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppTheme.textGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- SECTION 3: FOOTER ACTION ---
              // Error message
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
              authState.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryGreen,
                      ),
                    )
                  : PrimaryButton(
                      text: "Sign Up",
                      onPressed: _handleSignUp,
                    ),
              
              const SizedBox(height: 20),

              // Already have account
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: AppTheme.textGrey, fontSize: 14),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Log In",
                        style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {
                           context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Terms and Privacy (Small text at bottom)
              Center(
                child: Text(
                  "By tapping Sign Up, you agree to our Terms and Privacy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textGrey.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 30), // Padding đáy an toàn
            ],
          ),
        ),
      ),
    );
  }
}
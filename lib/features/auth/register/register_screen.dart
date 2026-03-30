import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/auth/register/register_provider.dart';
import 'package:monikid/features/auth/register/widgets/register_form_card.dart';
import 'package:monikid/features/auth/register/widgets/register_header.dart';
import 'package:monikid/shared/widgets/auth_redirect_prompt.dart';
import 'package:monikid/shared/widgets/auth_social_section.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

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
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ các trường bắt buộc.'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    await ref.read(registerProvider.notifier).signUp(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
      role: _selectedRole,
    );
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 64,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RegisterHeader(),
                    const SizedBox(height: 32),
                    RegisterFormCard(
                      selectedRole: _selectedRole,
                      onRoleChanged: (role) {
                        setState(() => _selectedRole = role);
                      },
                      fullNameController: _fullNameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      passwordController: _passwordController,
                      isLoading: registerState.isLoading,
                      errorMessage: registerState.errorMessage,
                      onSubmit: _handleSignUp,
                    ),
                    const SizedBox(height: 32),
                    AuthSocialSection(
                      onGooglePressed: () {},
                      onApplePressed: () {},
                    ),
                    const SizedBox(height: 32),
                    AuthRedirectPrompt(
                      promptText: 'Đã có tài khoản? ',
                      actionText: 'Đăng nhập',
                      onTap: () => context.go(AppRoutes.login),
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

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/auth_card.dart';
import 'package:monikid/shared/widgets/auth_role_selector.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class RegisterFormCard extends StatelessWidget {
  const RegisterFormCard({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.isLoading,
    required this.errorMessage,
    required this.onSubmit,
  });

  final String selectedRole;
  final ValueChanged<String> onRoleChanged;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isLoading;
  final String? errorMessage;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthRoleSelector(
            selectedRole: selectedRole,
            onRoleChanged: onRoleChanged,
          ),
          const SizedBox(height: 24),
          CustomInputWidget(
            label: 'Họ và tên',
            placeholder: 'Nguyễn Văn A',
            prefixIcon: Icons.person_outline,
            controller: fullNameController,
          ),
          const SizedBox(height: 20),
          CustomInputWidget(
            label: 'Email',
            placeholder: 'nguyenvana@example.com',
            prefixIcon: Icons.mail_outline,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          CustomInputWidget(
            label: 'Số điện thoại (Tùy chọn)',
            placeholder: '090xxxxxxx',
            prefixIcon: Icons.phone_android,
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          CustomInputWidget(
            label: 'Mật khẩu',
            placeholder: '••••••••',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: passwordController,
          ),
          const SizedBox(height: 32),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.redAlert,
                  fontSize: 14,
                ),
              ),
            ),
          PrimaryButton(
            text: 'Đăng ký',
            isLoading: isLoading,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

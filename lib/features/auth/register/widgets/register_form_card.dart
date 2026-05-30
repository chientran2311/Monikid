import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:monikid/app/router.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/auth_input_field.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/switch_two_item.dart';

class RegisterFormCard extends StatelessWidget {
  const RegisterFormCard({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.title,
    required this.subtitle,
    required this.emailLabel,
    required this.emailPlaceholder,
    required this.usernameLabel,
    required this.usernamePlaceholder,
    required this.phoneLabel,
    required this.phonePlaceholder,
    required this.passwordLabel,
    required this.passwordPlaceholder,
    required this.confirmPasswordLabel,
    required this.confirmPasswordPlaceholder,
    required this.submitButtonText,
    required this.haveAccountText,
    required this.signInText,
    required this.selectedRoleIndex,
    required this.onRoleChanged,
    required this.roleParentText,
    required this.roleStudentText,
    this.errorMessage,
    this.emailErrorText,
    this.usernameErrorText,
    this.phoneErrorText,
    this.passwordErrorText,
    this.confirmPasswordErrorText,
    this.onSubmit,
    this.onEmailChanged,
    this.onUsernameChanged,
    this.onPhoneChanged,
    this.onPasswordChanged,
    this.onConfirmPasswordChanged,
  });

  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final String? errorMessage;
  final String? emailErrorText;
  final String? usernameErrorText;
  final String? phoneErrorText;
  final String? passwordErrorText;
  final String? confirmPasswordErrorText;
  final Future<void> Function()? onSubmit;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onUsernameChanged;
  final ValueChanged<String>? onPhoneChanged;
  final ValueChanged<String>? onPasswordChanged;
  final ValueChanged<String>? onConfirmPasswordChanged;

  final String title;
  final String subtitle;
  final String emailLabel;
  final String emailPlaceholder;
  final String usernameLabel;
  final String usernamePlaceholder;
  final String phoneLabel;
  final String phonePlaceholder;
  final String passwordLabel;
  final String passwordPlaceholder;
  final String confirmPasswordLabel;
  final String confirmPasswordPlaceholder;
  final String submitButtonText;
  final String haveAccountText;
  final String signInText;
  final int selectedRoleIndex;
  final ValueChanged<int> onRoleChanged;
  final String roleParentText;
  final String roleStudentText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: AppTheme.borderLight),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 24.h),
                blurRadius: 60.r,
                color: AppTheme.primary.withValues(alpha: 0.12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _CardHeader(title: title, subtitle: subtitle),
              SizedBox(height: 14.h),
              SwitchTwoItem(
                title1: roleParentText,
                title2: roleStudentText,
                selectedIndex: selectedRoleIndex,
                onChanged: onRoleChanged,
              ),
              SizedBox(height: 14.h),
              _FieldLabel(text: emailLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: emailController,
                prefixIcon: Icons.mail_outline_rounded,
                placeholder: emailPlaceholder,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: onEmailChanged,
                errorText: emailErrorText,
              ),
              SizedBox(height: 11.h),
              _FieldLabel(text: usernameLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: usernameController,
                prefixIcon: Icons.person_outline_rounded,
                placeholder: usernamePlaceholder,
                textInputAction: TextInputAction.next,
                onChanged: onUsernameChanged,
                errorText: usernameErrorText,
              ),
              SizedBox(height: 11.h),
              _FieldLabel(text: phoneLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: phoneController,
                prefixIcon: Icons.phone_outlined,
                placeholder: phonePlaceholder,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onChanged: onPhoneChanged,
                errorText: phoneErrorText,
              ),
              SizedBox(height: 11.h),
              _FieldLabel(text: passwordLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                placeholder: passwordPlaceholder,
                showPasswordToggle: true,
                textInputAction: TextInputAction.next,
                onChanged: onPasswordChanged,
                errorText: passwordErrorText,
              ),
              SizedBox(height: 11.h),
              _FieldLabel(text: confirmPasswordLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: confirmPasswordController,
                prefixIcon: Icons.lock_person_outlined,
                placeholder: confirmPasswordPlaceholder,
                showPasswordToggle: true,
                textInputAction: TextInputAction.done,
                onSubmitted: onSubmit != null ? (_) => onSubmit!() : null,
                onChanged: onConfirmPasswordChanged,
                errorText: confirmPasswordErrorText,
              ),
              if (errorMessage != null) ...[
                SizedBox(height: 8.h),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.captionBig,
                    weight: FontWeight.w600,
                    color: AppTheme.redAlert,
                  ),
                ),
              ],
              SizedBox(height: 12.h),
              PrimaryButton(
                title: submitButtonText,
                isLoading: isLoading,
                onTap: isLoading ? null : onSubmit,
                height: 54.h,
              ),
              SizedBox(height: 10.h),
              _SwitchLine(
                promptText: haveAccountText,
                actionText: signInText,
                onTap: () => context.go(AppRoutes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.headlineSmall,
                  weight: FontWeight.w700,
                  color: AppTheme.textBlack,
                  letterSpacing: -0.03,
                  height: 1.05,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                subtitle,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.captionBig,
                  weight: FontWeight.w400,
                  color: AppTheme.textGrey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppTheme.borderLight),
          ),
          child: Center(
            child: Text(
              '✦',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.titleSmall,
                weight: FontWeight.w900,
                color: AppTheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyleFactory.style(
        size: AppFontSizes.bodySmall,
        weight: FontWeight.w800,
        color: AppTheme.textBlack,
        letterSpacing: -0.01,
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: AppTextStyleFactory.style(
            size: AppFontSizes.bodySmall,
            weight: FontWeight.w400,
            color: AppTheme.textGrey,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              actionText,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.bodySmall,
                weight: FontWeight.w900,
                color: AppTheme.primary,
                letterSpacing: -0.01,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

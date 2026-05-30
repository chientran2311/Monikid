import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:monikid/app/router.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/auth_input_field.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.title,
    required this.subtitle,
    required this.accountLabel,
    required this.emailPlaceholder,
    required this.passwordLabel,
    required this.passwordPlaceholder,
    required this.forgotPasswordText,
    required this.loginButtonText,
    required this.registerButtonText,
    this.errorMessage,
    this.emailErrorText,
    this.passwordErrorText,
    this.onLogin,
    this.onEmailChanged,
    this.onPasswordChanged,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final String? errorMessage;
  final String? emailErrorText;
  final String? passwordErrorText;
  final Future<void> Function()? onLogin;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onPasswordChanged;

  final String title;
  final String subtitle;
  final String accountLabel;
  final String emailPlaceholder;
  final String passwordLabel;
  final String passwordPlaceholder;
  final String forgotPasswordText;
  final String loginButtonText;
  final String registerButtonText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
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
              _FieldLabel(text: accountLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: emailController,
                prefixIcon: Icons.person_outline_rounded,
                placeholder: emailPlaceholder,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: onEmailChanged,
                errorText: emailErrorText,
              ),
              SizedBox(height: 12.h),
              _FieldLabel(text: passwordLabel),
              SizedBox(height: 7.h),
              AuthInputField(
                controller: passwordController,
                prefixIcon: Icons.lock_outline_rounded,
                placeholder: passwordPlaceholder,
                showPasswordToggle: true,
                textInputAction: TextInputAction.done,
                onSubmitted: onLogin != null ? (_) => onLogin!() : null,
                onChanged: onPasswordChanged,
                errorText: passwordErrorText,
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.forgotPassword),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      forgotPasswordText,
                      style: AppTextStyleFactory.style(
                        size: AppFontSizes.bodySmall,
                        weight: FontWeight.w800,
                        color: AppTheme.primary,
                        letterSpacing: -0.01,
                      ),
                    ),
                  ),
                ),
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
              SizedBox(height: 8.h),
              PrimaryButton(
                title: loginButtonText,
                isLoading: isLoading,
                onTap: isLoading ? null : onLogin,
                height: 54.h,
              ),
              SizedBox(height: 8.h),
              PrimaryButton.secondary(
                title: registerButtonText,
                onTap: () => context.push(AppRoutes.register),
                height: 54.h,
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
            child: Text('🔐', style: TextStyle(fontSize: 18.r)),
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

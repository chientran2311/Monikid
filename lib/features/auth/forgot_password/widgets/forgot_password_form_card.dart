import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/auth_input_field.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class ForgotPasswordFormCard extends StatelessWidget {
  const ForgotPasswordFormCard({
    super.key,
    required this.emailController,
    required this.emailErrorText,
    required this.isLoading,
    required this.onSubmit,
    required this.onEmailChanged,
  });

  final TextEditingController emailController;
  final String? emailErrorText;
  final bool isLoading;
  final VoidCallback onSubmit;
  final void Function(String) onEmailChanged;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            border: Border.all(
              color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
            ),
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.12),
                blurRadius: 60.r,
                offset: Offset(0, 22.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CardHead(),
              SizedBox(height: 14.h),
              AuthInputField(
                controller: emailController,
                prefixIcon: Icons.mail_outline_rounded,
                placeholder: s.forgotPasswordEmailPlaceholder,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                errorText: emailErrorText,
                onChanged: onEmailChanged,
                onSubmitted: (_) => onSubmit(),
              ),
              SizedBox(height: 12.h),
              const _HintBox(),
              SizedBox(height: 12.h),
             PrimaryButton(
                title: s.forgotPasswordSubmitBtn,
                onTap: onSubmit,
                isLoading: isLoading,
              ),
              SizedBox(height: 10.h),
              const _BackLine(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHead extends StatelessWidget {
  const _CardHead();

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.forgotPasswordTitle,
                style: context.typo.headline.small.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.03,
                  color: AppTheme.textBlack,
                  height: 1.05,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                s.forgotPasswordDescription,
                maxLines: 3,
                style: context.typo.caption.big.copyWith(
                  color: Color.lerp(AppTheme.textBlack, Colors.white, 0.45),
                  height: 1.45,
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
            color: Color.lerp(Colors.white, AppTheme.primary, 0.16),
            border: Border.all(
              color: Color.lerp(Colors.white, AppTheme.primary, 0.22)!,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: const Center(
            child: Text('✉️', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}

class _HintBox extends StatelessWidget {
  const _HintBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color.lerp(Colors.white, AppTheme.primary, 0.10),
        border: Border.all(
          color: Color.lerp(Colors.white, AppTheme.primary, 0.22)!,
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(
        context.l10n.forgotPasswordEmailHint,
        style: context.typo.caption.big.copyWith(
          color: Color.lerp(AppTheme.textBlack, Colors.white, 0.45),
          height: 1.45,
        ),
      ),
    );
  }
}

class _BackLine extends StatelessWidget {
  const _BackLine();

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s.forgotPasswordRememberPassword,
          style: context.typo.body.small.copyWith(
            color: Color.lerp(AppTheme.textBlack, Colors.white, 0.45),
          ),
        ),
        GestureDetector(
          onTap: () => context.go(AppRoutes.login),
          child: Text(
            ' ${s.forgotPasswordLoginAction}',
            style: context.typo.body.small.copyWith(
              color: AppTheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

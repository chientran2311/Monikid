import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_provider.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/success_dialog.dart';

import 'widgets/illustration_section.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final emailController = useTextEditingController();
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final subtitleColor = isDark ? AppTheme.iconLight : AppTheme.textGrey;

    Future<void> handleResetPassword() async {
      await ref.read(forgotPasswordProvider.notifier).submit(
            emailController.text.trim(),
          );

      if (!context.mounted) {
        return;
      }

      final nextState = ref.read(forgotPasswordProvider);
      if (nextState.isSuccess) {
        final email = emailController.text.trim();
        SuccessDialog.show(
          context,
          title: 'Email đã được gửi!',
          message:
              'Chúng tôi đã gửi link đặt lại mật khẩu đến\n$email\n\nVui lòng kiểm tra hộp thư rồi nhấn vào link để đổi mật khẩu.',
          buttonText: 'Quay về Đăng nhập',
          icon: Icons.mark_email_read_rounded,
          onPressed: () {
            context.pop();
            context.go(AppRoutes.login);
          },
        );
        return;
      }

      if (nextState.errorMessage != null) {
        AppSnackBar.error(context, nextState.errorMessage!);
      }
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: titleColor,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 48),
                      child: Text(
                        'Quên mật khẩu?',
                        textAlign: TextAlign.center,
                        style: context.typo.title.small.copyWith(
                          color: titleColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const IllustrationSection(),
                    const SizedBox(height: 32),
                    Text(
                      'Quên mật khẩu?',
                      style: context.typo.bigTitle.small.copyWith(
                        color: titleColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Đừng lo lắng! Hãy nhập email đã đăng ký, chúng tôi sẽ gửi mã xác thực để bạn đặt lại mật khẩu.',
                      style: context.typo.text.large.copyWith(
                        height: 1.5,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomInputWidget(
                      label: 'Email',
                      placeholder: 'Nhập email của bạn',
                      prefixIcon: Icons.mail_outline,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Gửi mã xác thực',
                      icon: Icons.send_rounded,
                      onPressed: handleResetPassword,
                      isLoading: forgotPasswordState.isLoading,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: GestureDetector(
                onTap: () => context.go(AppRoutes.login),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Quay lại Đăng nhập',
                      style: context.typo.subtitle.small.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_provider.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';
import 'package:monikid/shared/widgets/brand_row.dart';
import 'package:monikid/shared/widgets/dialogs/success_dialog_popup.dart';

import 'widgets/forgot_password_form_card.dart';
import 'widgets/illustration_section.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final state = ref.watch(forgotPasswordProvider);
    final notifier = ref.read(forgotPasswordProvider.notifier);

    Future<void> handleSubmit() async {
      await notifier.submit(emailController.text.trim());
      if (!context.mounted) return;

      final nextState = ref.read(forgotPasswordProvider);
      if (nextState.isDone) {
        showDialog<void>(
          context: context,
          barrierColor: const Color(0x2E0D1D0F),
          builder: (dialogContext) => SuccessDialogPopup(
            title: context.l10n.forgotPasswordEmailSentTitle,
            message: context.l10n.forgotPasswordEmailSentMessage(
              emailController.text.trim(),
            ),
            buttonText: context.l10n.forgotPasswordEmailSentBtn,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.go(AppRoutes.login);
            },
          ),
        );
        return;
      }
      if (nextState.errorMessage != null) {
        AppSnackBar.error(context, nextState.errorMessage!);
      }
    }

    final emailErrorText = state.emailError.message(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(Colors.white, AppTheme.primary, 0.12)!,
              Color.lerp(Colors.white, AppTheme.primary, 0.09)!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8.h),
              const BrandRow(),
              SizedBox(height: 18.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 24.h),
                  child: Column(
                    children: [
                      const IllustrationSection(),
                      SizedBox(height: 16.h),
                      ForgotPasswordFormCard(
                        emailController: emailController,
                        emailErrorText: emailErrorText,
                        isLoading: state.isLoading,
                        onSubmit: handleSubmit,
                        onEmailChanged: notifier.validateEmail,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

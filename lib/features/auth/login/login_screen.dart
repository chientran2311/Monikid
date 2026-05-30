import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/login/login_provider.dart';
import 'package:monikid/features/auth/login/widgets/login_form_card.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/auth_session/auth_session_state.dart';
import 'package:monikid/shared/widgets/brand_hero.dart';
import 'package:monikid/shared/widgets/brand_row.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final loginNotifier = ref.read(loginProvider.notifier);
    final loginState = ref.watch(loginProvider);
    final s = context.l10n;

    useEffect(() {
      return () {
        // Only reset if not authenticated (avoid race condition on successful login)
        if (!ref.read(authSessionProvider).isAuthenticated) {
          loginNotifier.reset();
        }
      };
    }, const []);

    ref.listen<AuthSessionState>(authSessionProvider, (previous, next) {
      final wasAuthenticated = previous?.isAuthenticated ?? false;
      if (!wasAuthenticated && next.isAuthenticated && loginState.isLoading) {
        loginNotifier.reset();
      }
    });

    Future<void> handleLogin() async {
      await loginNotifier.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
    }

    final canSubmit = !loginState.hasFieldErrors &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(AppTheme.backgroundLight, AppTheme.primaryLight, 0.15)!,
              Color.lerp(AppTheme.backgroundLight, AppTheme.primaryLight, 0.40)!,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - 40.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BrandRow(),
                      BrandHero(
                        tagline: s.loginTagline,
                        floatie1: '₫',
                        floatie2: '📈',
                        floatie3: '🛡️',
                      ),
                      LoginFormCard(
                        emailController: emailController,
                        passwordController: passwordController,
                        isLoading: loginState.isLoading,
                        errorMessage: loginState.errorMessage,
                        emailErrorText: loginState.emailError.message(context),
                        passwordErrorText: loginState.passwordError.message(context),
                        onLogin: canSubmit ? handleLogin : null,
                        onEmailChanged: loginNotifier.validateEmail,
                        onPasswordChanged: loginNotifier.validatePassword,
                        title: s.loginWelcomeTitle,
                        subtitle: s.loginWelcomeSubtitle,
                        accountLabel: s.loginAccountLabel,
                        emailPlaceholder: s.loginEmailPlaceholder,
                        passwordLabel: s.loginPasswordLabel,
                        passwordPlaceholder: s.loginPasswordPlaceholder,
                        forgotPasswordText: s.loginForgotPassword,
                        loginButtonText: s.authSignInAction,
                        registerButtonText: s.loginRegisterButton,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/login/login_provider.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/auth/providers/auth_session_state.dart';
import 'package:monikid/features/auth/login/widgets/login_form_card.dart';
import 'package:monikid/features/auth/login/widgets/login_header.dart';
import 'package:monikid/shared/widgets/auth_redirect_prompt.dart';
import 'package:monikid/shared/widgets/auth_social_section.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final loginNotifier = ref.read(loginProvider.notifier);
    final loginState = ref.watch(loginProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    useEffect(() {
      return () {
        loginNotifier.reset();
      };
    }, [loginNotifier]);

    ref.listen<AuthSessionState>(authSessionProvider, (previous, next) {
      final wasAuthenticated = previous?.isAuthenticated ?? false;
      if (!wasAuthenticated && next.isAuthenticated && loginState.isLoading) {
        loginNotifier.reset();
      }
    });

    Future<void> handleLogin() async {
      loginNotifier.clearError();
      await loginNotifier.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 64,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoginHeader(),
                    LoginFormCard(
                      emailController: emailController,
                      passwordController: passwordController,
                      isLoading: loginState.isLoading,
                      errorMessage: loginState.errorMessage,
                      onLogin: handleLogin,
                    ),
                    const SizedBox(height: 32),
                    AuthSocialSection(
                      onGooglePressed: () {},
                      onApplePressed: () {},
                    ),
                    const SizedBox(height: 32),
                    AuthRedirectPrompt(
                      promptText: s.authNoAccountPrompt,
                      actionText: s.authSignUpAction,
                      onTap: () => context.push(AppRoutes.register),
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

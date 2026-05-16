import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/auth/providers/auth_session_state.dart';
import 'package:monikid/features/auth/register/register_provider.dart';
import 'package:monikid/features/auth/register/widgets/register_form_card.dart';
import 'package:monikid/features/auth/register/widgets/register_header.dart';
import 'package:monikid/shared/widgets/auth_redirect_prompt.dart';
import 'package:monikid/shared/widgets/auth_social_section.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final selectedRole = useState('parent');
    final registerNotifier = ref.read(registerProvider.notifier);
    final registerState = ref.watch(registerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    useEffect(() {
      return () {
        registerNotifier.reset();
      };
    }, [registerNotifier]);

    ref.listen<AuthSessionState>(authSessionProvider, (previous, next) async {
      final wasAuthenticated = previous?.isAuthenticated ?? false;
      if (!wasAuthenticated &&
          next.isAuthenticated &&
          registerState.isLoading &&
          context.mounted) {
        registerNotifier.reset();
      }
    });

    Future<void> handleSignUp() async {
      final fullName = fullNameController.text.trim();
      final email = emailController.text.trim();
      final phone = phoneController.text.trim();
      final password = passwordController.text;

      if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.validationEmptyFields),
            backgroundColor: AppTheme.redAlert,
          ),
        );
        return;
      }

      await registerNotifier.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: selectedRole.value,
      );
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: Stack(
        children: [
          SafeArea(
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
                          selectedRole: selectedRole.value,
                          onRoleChanged: (role) {
                            selectedRole.value = role;
                          },
                          fullNameController: fullNameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          passwordController: passwordController,
                          isLoading: registerState.isLoading,
                          buttonText: registerState.errorMessage != null
                              ? s.actionRetry
                              : s.authSignUpAction,
                          errorMessage: registerState.errorMessage,
                          onSubmit: handleSignUp,
                        ),
                        const SizedBox(height: 32),
                        AuthSocialSection(
                          onGooglePressed: () {},
                          onApplePressed: () {},
                        ),
                        const SizedBox(height: 32),
                        AuthRedirectPrompt(
                          promptText: s.authHaveAccountPrompt,
                          actionText: s.authSignInAction,
                          onTap: () => context.go(AppRoutes.login),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (registerState.isLoading) ...[
            const ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ],
      ),
    );
  }
}

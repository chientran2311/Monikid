import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_field_error.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/auth_session/auth_session_state.dart';
import 'package:monikid/features/auth/register/register_provider.dart';
import 'package:monikid/features/auth/register/widgets/register_form_card.dart';
import 'package:monikid/shared/widgets/brand_hero.dart';
import 'package:monikid/shared/widgets/brand_row.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final selectedRoleIndex = useState(0);
    final registerNotifier = ref.read(registerProvider.notifier);
    final registerState = ref.watch(registerProvider);
    final s = context.l10n;

    useEffect(() {
      return registerNotifier.reset;
    }, const []);

    ref.listen<AuthSessionState>(authSessionProvider, (previous, next) {
      final wasAuthenticated = previous?.isAuthenticated ?? false;
      if (!wasAuthenticated && next.isAuthenticated && registerState.isLoading) {
        registerNotifier.reset();
      }
    });

    Future<void> handleSignUp() async {
      await registerNotifier.signUp(
        email: emailController.text,
        password: passwordController.text,
        fullName: usernameController.text,
        role: selectedRoleIndex.value == 0 ? 'parent' : 'child',
      );
    }

    final canSubmit = !registerState.hasFieldErrors &&
        emailController.text.trim().isNotEmpty &&
        usernameController.text.trim().isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;

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
                        tagline: s.registerTagline,
                        floatie1: '✨',
                        floatie2: '💳',
                        floatie3: '🌱',
                      ),
                      RegisterFormCard(
                        emailController: emailController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        isLoading: registerState.isLoading,
                        errorMessage: registerState.errorMessage,
                        emailErrorText: registerState.emailError.message(context),
                        usernameErrorText: registerState.usernameError.message(context),
                        passwordErrorText: registerState.passwordError.message(context),
                        confirmPasswordErrorText: registerState.confirmPasswordError.message(context),
                        onSubmit: canSubmit ? handleSignUp : null,
                        onEmailChanged: registerNotifier.validateEmail,
                        onUsernameChanged: registerNotifier.validateUsername,
                        onPasswordChanged: registerNotifier.validatePassword,
                        onConfirmPasswordChanged: (value) =>
                            registerNotifier.validateConfirmPassword(value, passwordController.text),
                        title: s.registerTitle,
                        subtitle: s.registerSubtitle,
                        emailLabel: s.profileEditEmail,
                        emailPlaceholder: s.registerEmailPlaceholder,
                        usernameLabel: s.registerUsernameLabel,
                        usernamePlaceholder: s.registerUsernamePlaceholder,
                        passwordLabel: s.loginPasswordLabel,
                        passwordPlaceholder: s.registerPasswordPlaceholder,
                        confirmPasswordLabel: s.registerConfirmPasswordLabel,
                        confirmPasswordPlaceholder: s.registerConfirmPasswordPlaceholder,
                        submitButtonText: s.authSignUpAction,
                        haveAccountText: s.registerHaveAccountText,
                        signInText: s.authSignInAction,
                        selectedRoleIndex: selectedRoleIndex.value,
                        onRoleChanged: (i) => selectedRoleIndex.value = i,
                        roleParentText: s.registerRoleParent,
                        roleStudentText: s.registerRoleStudent,
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

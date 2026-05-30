import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/local_notification_service.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/app_transitions.dart';
import 'package:monikid/features/auth/onboard/onboarding_notification_step.dart';
import 'package:monikid/features/auth/onboard/onboarding_welcome_step.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_language_step.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/repositories/auth/onboarding_repository.dart';

enum _OnboardingStep { language, notification, welcome }

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = useState(_OnboardingStep.language);
    final isFinishing = useState(false);

    Future<void> finishOnboarding() async {
      if (isFinishing.value) return;
      isFinishing.value = true;
      try {
        await ref.read(onboardingRepositoryProvider).markOnboardingComplete();
        if (context.mounted) context.go(AppRoutes.login);
      } finally {
        if (context.mounted) isFinishing.value = false;
      }
    }

    void goNext() {
      if (step.value == _OnboardingStep.language) {
        step.value = _OnboardingStep.notification;
      } else if (step.value == _OnboardingStep.notification) {
        step.value = _OnboardingStep.welcome;
      }
    }

    Future<void> allowAndGoNext() async {
      await getIt<LocalNotificationService>().requestPermission();
      if (context.mounted) goNext();
    }

    Future<void> selectLanguage(String localeCode) {
      return ref.read(changeLanguageProvider.notifier).setLanguage(localeCode);
    }

    final selectedLocaleCode = ref.watch(changeLanguageProvider).localeCode;

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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: switcherSlideTransition,
            child: switch (step.value) {
              _OnboardingStep.language => OnboardingLanguageStep(
                  key: const ValueKey('onboarding-language'),
                  selectedLocaleCode: selectedLocaleCode,
                  isFinishing: isFinishing.value,
                  onSkip: goNext,
                  onContinue: goNext,
                  onSelectLanguage: selectLanguage,
                ),
              _OnboardingStep.notification => OnboardingNotificationStep(
                  key: const ValueKey('onboarding-notification'),
                  isFinishing: isFinishing.value,
                  onAllow: allowAndGoNext,
                  onDeny: goNext,
                ),
              _OnboardingStep.welcome => OnboardingWelcomeStep(
                  key: const ValueKey('onboarding-welcome'),
                  isFinishing: isFinishing.value,
                  onStart: finishOnboarding,
                ),
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_currency_step.dart';
import 'package:monikid/features/auth/onboard/widgets/onboarding_language_step.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/repositories/auth/onboarding_repository.dart';

enum _OnboardingStep { language, currency }

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final step = useState(_OnboardingStep.language);
    final selectedCurrencyCode = useState('vnd');
    final isFinishing = useState(false);

    Future<void> finishOnboarding() async {
      if (isFinishing.value) {
        return;
      }

      isFinishing.value = true;
      try {
        await ref.read(onboardingRepositoryProvider).markOnboardingComplete();
        if (context.mounted) {
          context.go(AppRoutes.login);
        }
      } finally {
        if (context.mounted) {
          isFinishing.value = false;
        }
      }
    }

    Future<void> selectLanguage(String localeCode) {
      return ref.read(changeLanguageProvider.notifier).setLanguage(localeCode);
    }

    void continueStep() {
      if (step.value == _OnboardingStep.language) {
        step.value = _OnboardingStep.currency;
        return;
      }

      finishOnboarding();
    }

    final l10n = context.l10n;
    final selectedLocaleCode = ref.watch(changeLanguageProvider).localeCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          child: step.value == _OnboardingStep.language
              ? OnboardingLanguageStep(
                  key: const ValueKey('onboarding-language'),
                  selectedLocaleCode: selectedLocaleCode,
                  isFinishing: isFinishing.value,
                  onSkip: finishOnboarding,
                  onContinue: continueStep,
                  onSelectLanguage: selectLanguage,
                )
              : OnboardingCurrencyStep(
                  key: const ValueKey('onboarding-currency'),
                  selectedCurrencyCode: selectedCurrencyCode.value,
                  isFinishing: isFinishing.value,
                  onSkip: finishOnboarding,
                  onContinue: continueStep,
                  onSelectCurrency: (code) {
                    selectedCurrencyCode.value = code;
                  },
                  continueLabel: l10n.onboardingContinueAction,
                ),
        ),
      ),
    );
  }
}

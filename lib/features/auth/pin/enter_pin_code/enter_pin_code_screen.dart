import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_provider.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_state.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/shared/widgets/app_background.dart';

class EnterPinCodeScreen extends HookConsumerWidget {
  const EnterPinCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enterPINCodeProvider);
    final notifier = ref.read(enterPINCodeProvider.notifier);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    useEffect(() {
      Future.microtask(notifier.onInit);
      return null;
    }, const []);

    ref.listen<EnterPINCodeState>(enterPINCodeProvider, (_, next) {
      if (next.status != EnterPINCodeStatus.success) return;
      final role = ref.read(authSessionProvider).account?.role;
      if (role == 'parent') {
        context.go(AppRoutes.parent);
      } else if (role == 'child') {
        context.go(AppRoutes.studentMain);
      }
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
        body: AppBackground(
          child: SafeArea(
            child: PinScreenBody(
              title: s.pinEnterTitle,
              description: s.pinEnterDescription,
              currentPin: state.currentPin,
              hasError: state.hasError,
              isLoading: state.isLoading,
              isInputDisabled: state.isLocked,
              message: _buildMessage(state, s),
              onAddNumber: notifier.addNumber,
              onRemoveNumber: notifier.removeNumber,
            ),
          ),
        ),
      ),
    );
  }

  String? _buildMessage(EnterPINCodeState state, AppLocalizations s) {
    if (state.isLocked) {
      return s.pinLockedMessage(state.remainingLockSeconds);
    }

    if (state.status == EnterPINCodeStatus.incorrect) {
      return s.pinIncorrectError;
    }

    if (state.status == EnterPINCodeStatus.error && state.errorMessage != null) {
      return s.pinGenericError;
    }

    return null;
  }
}

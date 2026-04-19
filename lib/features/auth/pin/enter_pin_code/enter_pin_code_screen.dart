import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_provider.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_state.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';
import 'package:monikid/l10n/app_localizations.dart';

class EnterPinCodeScreen extends HookConsumerWidget {
  const EnterPinCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enterPINCodeProvider);
    final notifier = ref.read(enterPINCodeProvider.notifier);
    final s = context.l10n;

    useEffect(() {
      Future.microtask(notifier.onInit);
      return null;
    }, const []);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
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

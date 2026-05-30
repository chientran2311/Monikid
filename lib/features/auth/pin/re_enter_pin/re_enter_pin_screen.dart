import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_provider.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';

class ReEnterPinScreen extends HookConsumerWidget {
  const ReEnterPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reEnterPINProvider);
    final notifier = ref.read(reEnterPINProvider.notifier);
    final draftPinCode = ref.watch(
      createNewPINProvider.select((value) => value.draftPinCode),
    );
    final s = context.l10n;

    useEffect(() {
      if (draftPinCode == null || draftPinCode.length != 6) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.go(AppRoutes.createNewPin);
          }
        });
      }
      return null;
    }, [draftPinCode]);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: PinScreenBody(
              title: s.pinReEnterTitle,
              description: s.pinReEnterDescription,
              currentPin: state.currentPin,
              hasError: state.hasError,
              isLoading: state.isLoading,
              message: state.errorMessage ??
                  (state.hasError ? s.pinMismatchError : null),
              onAddNumber: notifier.addNumber,
              onRemoveNumber: notifier.removeNumber,
            ),
          ),
        ),
      ),
    );
  }
}

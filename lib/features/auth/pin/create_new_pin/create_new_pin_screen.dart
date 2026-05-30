import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_state.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';

class CreateNewPinScreen extends ConsumerWidget {
  const CreateNewPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createNewPINProvider);
    final notifier = ref.read(createNewPINProvider.notifier);
    final s = context.l10n;

    ref.listen<CreateNewPINState>(createNewPINProvider, (previous, next) {
      final shouldNavigate =
          previous?.status != CreateNewPinStatus.readyForConfirmation &&
          next.status == CreateNewPinStatus.readyForConfirmation;

      if (!shouldNavigate || !context.mounted) {
        return;
      }

      notifier.consumeReadyForConfirmation();
      context.go(AppRoutes.reEnterPin);
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: PinScreenBody(
              title: s.pinCreateTitle,
              description: s.pinCreateDescription,
              currentPin: state.currentPin,
              hasError: false,
              isLoading: false,
              onAddNumber: notifier.addNumber,
              onRemoveNumber: notifier.removeNumber,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_provider.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_state.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';

class EnterPinCodeScreen extends ConsumerWidget {
  const EnterPinCodeScreen({
    required this.expectedPinHash,
    this.canCancel = true,
    super.key,
  });

  final String expectedPinHash;
  final bool canCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = enterPINCodeProvider(expectedPinHash);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    ref.listen<EnterPINCodeState>(provider, (previous, next) {
      if (next.isSuccess && (previous == null || !previous.isSuccess)) {
        Navigator.of(context).pop(true);
      }
    });

    return PopScope(
      canPop: canCancel && !state.isLoading,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: PinScreenBody(
              title: 'Xác nhận mã PIN',
              description:
                  'Vui lòng nhập mã PIN 6 chữ số để tiếp tục giao dịch.',
              currentPin: state.currentPin,
              hasError: state.hasError,
              isLoading: state.isLoading,
              onAddNumber: notifier.addNumber,
              onRemoveNumber: notifier.removeNumber,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_provider.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_state.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';

class ReEnterPinScreen extends ConsumerWidget {
  const ReEnterPinScreen({
    required this.pinCodeHash,
    this.canCancel = true,
    super.key,
  });

  final String pinCodeHash;
  final bool canCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = reEnterPINProvider(pinCodeHash);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    ref.listen<ReEnterPINState>(provider, (previous, next) {
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
              title: 'Xác nhận lại mã PIN',
              description: 'Nhập lại mã PIN vừa tạo để đảm bảo độ chính xác.',
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

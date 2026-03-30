import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/features/auth/pin/enum/enter_pin_code_enum.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';

class CreateNewPinScreen extends ConsumerWidget {
  const CreateNewPinScreen({
    required this.type,
    this.pinCode,
    this.canCancel = true,
    super.key,
  });

  final EnterPINCodeEnum type;
  final String? pinCode;
  final bool canCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = createNewPINProvider(type, pinCode: pinCode);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    ref.listen(provider, (previous, next) async {
      final shouldNavigate =
          previous?.pendingPinCodeHash == null && next.pendingPinCodeHash != null;

      if (!shouldNavigate || !context.mounted) {
        return;
      }

      final pinCodeHash = next.pendingPinCodeHash!;
      notifier.clearPendingPinCodeHash();

      final result = await context.push<bool>(
        AppRoutes.reEnterPin,
        extra: {
          'pinCodeHash': pinCodeHash,
          'canCancel': canCancel,
        },
      );

      if (!context.mounted) {
        return;
      }

      if (result == true) {
        Navigator.of(context).pop(true);
      } else {
        notifier.reset();
      }
    });

    final title = type == EnterPINCodeEnum.createNew
        ? 'Tạo mã PIN mới'
        : 'Nhập mã PIN';
    const description = 'Tạo mã PIN 6 chữ số để bảo mật tài khoản của bạn.';

    return PopScope(
      canPop: canCancel && !state.isLoading,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: PinScreenBody(
              title: title,
              description: description,
              currentPin: state.pinCode,
              hasError: false,
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

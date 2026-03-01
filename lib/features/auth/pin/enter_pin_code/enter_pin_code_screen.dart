import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_provider.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_state.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';

/// Màn hình XÁC THỰC PIN trước giao dịch — toàn màn hình.
/// [HookConsumerWidget] + [useTextEditingController] + [useEffect] đúng theo guide.
class EnterPinCodeScreen extends HookConsumerWidget {
  const EnterPinCodeScreen({required this.expectedPinHash, super.key});

  final String expectedPinHash;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enterPINCodeProvider(expectedPinHash));
    final notifier = ref.read(enterPINCodeProvider(expectedPinHash).notifier);
    final enterPINCtrl = useTextEditingController();

    // Khi xác thực thành công: pop với result = true
    ref.listen<EnterPINCodeState>(enterPINCodeProvider(expectedPinHash), (
      previous,
      next,
    ) {
      if (next.isSuccess && (previous == null || !previous.isSuccess)) {
        Navigator.of(context).pop(true);
      }
    });

    // useEffect: listener trigger mỗi khi text thay đổi
    useEffect(() {
      void listener() {
        final text = enterPINCtrl.text;
        notifier.onTextChanged(text);
      }

      enterPINCtrl.addListener(listener);
      return () => enterPINCtrl.removeListener(listener);
    }, const []);

    // Auto-clear controller khi bắt đầu lại (ví dụ: từ error)
    useEffect(() {
      if (state.currentPin.isEmpty && enterPINCtrl.text.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          enterPINCtrl.clear();
        });
      }
      return null;
    }, [state.currentPin]);

    return PopScope(
      canPop: !state.isLoading,
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
              onAddNumber: (digit) {
                if (!state.isLoading) {
                  if (state.hasError) {
                    enterPINCtrl.value = TextEditingValue(text: digit);
                  } else if (enterPINCtrl.text.length < 6) {
                    enterPINCtrl.value = TextEditingValue(
                      text: enterPINCtrl.text + digit,
                    );
                  }
                }
              },
              onRemoveNumber: () {
                if (!state.isLoading) {
                  if (state.hasError) {
                    enterPINCtrl.clear();
                  } else if (enterPINCtrl.text.isNotEmpty) {
                    enterPINCtrl.value = TextEditingValue(
                      text: enterPINCtrl.text.substring(
                        0,
                        enterPINCtrl.text.length - 1,
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

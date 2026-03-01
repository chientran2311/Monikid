import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_provider.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_state.dart';

/// Màn hình NHẬP LẠI PIN để xác nhận — toàn màn hình.
/// [HookConsumerWidget] + [useTextEditingController] + [useEffect] đúng theo guide.
class ReEnterPinScreen extends HookConsumerWidget {
  const ReEnterPinScreen({
    required this.pinCodeHash,
    this.canCancel = true,
    super.key,
  });

  final String pinCodeHash;
  final bool canCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reEnterPINProvider(pinCodeHash));
    final notifier = ref.read(reEnterPINProvider(pinCodeHash).notifier);
    final enterPINCtrl = useTextEditingController();

    // Khi success: pop về màn trước với result = true
    ref.listen<ReEnterPINState>(reEnterPINProvider(pinCodeHash), (
      previous,
      next,
    ) {
      if (next.isSuccess && (previous == null || !previous.isSuccess)) {
        Navigator.of(context).pop(true);
      }
    });

    // useEffect: lắng nghe controller để trigger provider
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
      canPop: canCancel,
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

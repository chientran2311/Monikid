import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/features/auth/pin/widgets/pin_screen_body.dart';
import 'package:monikid/features/auth/pin/enum/enter_pin_code_enum.dart';

/// Màn hình TẠO mã PIN mới — toàn màn hình (không phải dialog).
/// [HookConsumerWidget] + [useTextEditingController] + [useEffect] đúng theo guide.
class CreateNewPinScreen extends HookConsumerWidget {
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
    final state = ref.watch(createNewPINProvider(type, pinCode: pinCode));
    final notifier = ref.read(
      createNewPINProvider(type, pinCode: pinCode).notifier,
    );
    final enterPINCtrl = useTextEditingController();

    // Lắng nghe thay đổi text — chỉ add listener 1 lần nhờ dependency list rỗng
    useEffect(() {
      void listener() {
        final text = enterPINCtrl.text;
        // Đồng bộ state với controller (để PinScreenBody hiển thị đúng dots)
        notifier.onTextChanged(text);
        // Khi đủ 6 số: bcrypt + navigate (isLoading guard trong provider)
        if (text.length == 6) {
          notifier.navigationReEnterPinCode(text, context);
        }
      }

      enterPINCtrl.addListener(listener);
      return () => enterPINCtrl.removeListener(listener);
    }, const []);

    // Reset controller khi bắt đầu lại (ví dụ: từ error)
    useEffect(() {
      if (state.pinCode.isEmpty && enterPINCtrl.text.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          enterPINCtrl.clear();
        });
      }
      return null;
    }, [state.pinCode]);

    final title = type == EnterPINCodeEnum.createdNew
        ? 'Tạo mã PIN mới'
        : 'Nhập mã PIN';
    const description = 'Tạo mã PIN 6 chữ số để bảo mật tài khoản CỦA BẠN.';

    return PopScope(
      canPop: canCancel,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: SingleChildScrollView(
            child: PinScreenBody(
              title: title,
              description: description,
              // PIN hiển thị qua state (Riverpod) — controller chỉ làm trigger
              currentPin: state.pinCode.length > 6
                  ? state.pinCode.substring(0, 6)
                  : state.pinCode,
              hasError: false,
              isLoading: state.isLoading,
              onAddNumber: (digit) {
                if (enterPINCtrl.text.length < 6) {
                  enterPINCtrl.value = TextEditingValue(
                    text: enterPINCtrl.text + digit,
                  );
                }
              },
              onRemoveNumber: () {
                if (enterPINCtrl.text.isNotEmpty) {
                  enterPINCtrl.value = TextEditingValue(
                    text: enterPINCtrl.text.substring(
                      0,
                      enterPINCtrl.text.length - 1,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

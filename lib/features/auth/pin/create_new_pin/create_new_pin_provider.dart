import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/pin/enum/enter_pin_code_enum.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'create_new_pin_state.dart';

part 'create_new_pin_provider.g.dart';

@riverpod
class CreateNewPIN extends _$CreateNewPIN {
  late final PinCodeRepository _pinCodeRepository = getIt<PinCodeRepository>();

  @override
  CreateNewPINState build(EnterPINCodeEnum type, {String? pinCode}) {
    return CreateNewPINState(pinCode: pinCode ?? '', type: type);
  }

  Future<void> addNumber(String digit) async {
    if (state.isLoading || state.pinCode.length >= 6) {
      return;
    }

    final newPin = state.pinCode + digit;
    state = state.copyWith(pinCode: newPin);

    if (newPin.length == 6) {
      await preparePinCodeConfirmation(newPin);
    }
  }

  void removeNumber() {
    if (state.isLoading || state.pinCode.isEmpty) {
      return;
    }

    state = state.copyWith(
      pinCode: state.pinCode.substring(0, state.pinCode.length - 1),
    );
  }

  Future<void> preparePinCodeConfirmation(String pinCode) async {
    if (state.isLoading || pinCode.length != 6) {
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      final pinCodeHash = await _pinCodeRepository.hashPinCode(pinCode);
      state = state.copyWith(
        pinCode: '',
        isLoading: false,
        pendingPinCodeHash: pinCodeHash,
      );
    } catch (_) {
      state = state.copyWith(
        pinCode: '',
        isLoading: false,
      );
    }
  }

  void clearPendingPinCodeHash() {
    state = state.copyWith(pendingPinCodeHash: null);
  }

  void reset() {
    state = CreateNewPINState(
      pinCode: '',
      type: state.type,
    );
  }
}

import 'package:monikid/core/di/di.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'enter_pin_code_state.dart';

part 'enter_pin_code_provider.g.dart';

@riverpod
class EnterPINCode extends _$EnterPINCode {
  late final PinCodeRepository _pinCodeRepository = getIt<PinCodeRepository>();

  @override
  EnterPINCodeState build(String expectedPinHash) {
    return EnterPINCodeState.initial(expectedPinHash);
  }

  Future<void> addNumber(String digit) async {
    if (state.isLoading) {
      return;
    }

    var currentPin = state.currentPin;
    if (state.hasError) {
      currentPin = '';
      state = state.copyWith(hasError: false, currentPin: '');
    }

    if (currentPin.length >= 6) {
      return;
    }

    final newPin = currentPin + digit;
    state = state.copyWith(currentPin: newPin);

    if (newPin.length == 6) {
      await verifyCurrentPin(newPin);
    }
  }

  void removeNumber() {
    if (state.isLoading) {
      return;
    }

    if (state.hasError) {
      state = state.copyWith(hasError: false, currentPin: '');
      return;
    }

    if (state.currentPin.isEmpty) {
      return;
    }

    state = state.copyWith(
      currentPin: state.currentPin.substring(0, state.currentPin.length - 1),
    );
  }

  Future<void> verifyCurrentPin(String pin) async {
    state = state.copyWith(isLoading: true);
    try {
      final correct = await _pinCodeRepository.verifyPinCode(
        plainPinCode: pin,
        pinCodeHash: state.expectedPinHash,
      );

      if (correct) {
        state = state.copyWith(
          currentPin: '',
          isLoading: false,
          status: EnterPINCodeStatus.correct,
          isSuccess: true,
        );
        return;
      }

      state = state.copyWith(
        currentPin: '',
        isLoading: false,
        status: EnterPINCodeStatus.incorrect,
        hasError: true,
      );
      _scheduleResetAfterError();
    } catch (_) {
      state = state.copyWith(
        currentPin: '',
        isLoading: false,
        status: EnterPINCodeStatus.incorrect,
        hasError: true,
      );
      _scheduleResetAfterError();
    }
  }

  void reset() {
    state = EnterPINCodeState.initial(state.expectedPinHash);
  }

  void _scheduleResetAfterError() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (state.hasError) {
        state = state.copyWith(
          currentPin: '',
          hasError: false,
          status: EnterPINCodeStatus.initial,
        );
      }
    });
  }
}

import 'package:monikid/core/di/di.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 're_enter_pin_state.dart';

part 're_enter_pin_provider.g.dart';

@riverpod
class ReEnterPIN extends _$ReEnterPIN {
  late final PinCodeRepository _pinCodeRepository = getIt<PinCodeRepository>();

  @override
  ReEnterPINState build(String pinCodeHash) {
    return ReEnterPINState.initial(pinCodeHash);
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
      await confirmAndSavePinCode(newPin);
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

  Future<void> confirmAndSavePinCode(String pin) async {
    state = state.copyWith(isLoading: true);
    try {
      final correct = await _pinCodeRepository.verifyPinCode(
        plainPinCode: pin,
        pinCodeHash: state.pinCodeHash,
      );

      if (correct) {
        await _pinCodeRepository.savePinCodeHash(state.pinCodeHash);
        state = state.copyWith(
          currentPin: '',
          isLoading: false,
          status: ReEnterPINCodeStatus.correct,
          isSuccess: true,
        );
        return;
      }

      state = state.copyWith(
        currentPin: '',
        isLoading: false,
        status: ReEnterPINCodeStatus.incorrect,
        hasError: true,
      );
      _scheduleResetAfterError();
    } catch (_) {
      state = state.copyWith(
        currentPin: '',
        isLoading: false,
        status: ReEnterPINCodeStatus.incorrect,
        hasError: true,
      );
      _scheduleResetAfterError();
    }
  }

  void reset() {
    state = ReEnterPINState.initial(state.pinCodeHash);
  }

  void _scheduleResetAfterError() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (state.hasError) {
        state = state.copyWith(
          currentPin: '',
          hasError: false,
          status: ReEnterPINCodeStatus.initial,
        );
      }
    });
  }
}

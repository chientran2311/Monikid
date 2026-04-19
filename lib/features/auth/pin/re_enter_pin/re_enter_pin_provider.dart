import 'dart:async';

import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 're_enter_pin_state.dart';

part 're_enter_pin_provider.g.dart';

@riverpod
class ReEnterPIN extends _$ReEnterPIN {
  late final PinCodeRepository _pinCodeRepository;
  Timer? _errorResetTimer;

  @override
  ReEnterPINState build() {
    _pinCodeRepository = ref.read(pinCodeRepositoryProvider);
    ref.onDispose(() {
      _errorResetTimer?.cancel();
    });
    return const ReEnterPINState();
  }

  Future<void> addNumber(String digit) async {
    if (state.isLoading || !_isDigit(digit)) {
      return;
    }

    var currentPin = state.currentPin;
    if (state.hasError) {
      currentPin = '';
      state = state.copyWith(
        status: ReEnterPINCodeStatus.initial,
        errorMessage: null,
        currentPin: '',
      );
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
      state = state.copyWith(
        status: ReEnterPINCodeStatus.initial,
        errorMessage: null,
        currentPin: '',
      );
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
    final draftPinCode = ref.read(createNewPINProvider).draftPinCode;
    if (draftPinCode == null || draftPinCode.length != 6) {
      state = state.copyWith(
        currentPin: '',
        status: ReEnterPINCodeStatus.error,
        errorMessage: 'PIN draft is missing.',
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      status: ReEnterPINCodeStatus.loading,
      errorMessage: null,
    );

    try {
      if (pin != draftPinCode) {
        state = state.copyWith(
          currentPin: '',
          isLoading: false,
          status: ReEnterPINCodeStatus.mismatch,
          errorMessage: null,
        );
        _scheduleResetAfterError();
        return;
      }

      final pinCodeHash = await _pinCodeRepository.hashPinCode(draftPinCode);
      await _pinCodeRepository.savePinCodeHash(pinCodeHash);
      ref.read(createNewPINProvider.notifier).reset();
      ref.read(authSessionProvider.notifier).markPinVerified();
      state = state.copyWith(
        currentPin: '',
        isLoading: false,
        status: ReEnterPINCodeStatus.success,
        errorMessage: null,
      );
    } catch (_) {
      state = state.copyWith(
        currentPin: '',
        isLoading: false,
        status: ReEnterPINCodeStatus.error,
        errorMessage: 'Failed to save the PIN code.',
      );
    }
  }

  void reset() {
    _errorResetTimer?.cancel();
    state = const ReEnterPINState();
  }

  void _scheduleResetAfterError() {
    _errorResetTimer?.cancel();
    _errorResetTimer = Timer(const Duration(milliseconds: 600), () {
      if (state.hasError) {
        state = state.copyWith(
          currentPin: '',
          status: ReEnterPINCodeStatus.initial,
          errorMessage: null,
        );
      }
    });
  }

  bool _isDigit(String value) {
    return RegExp(r'^\d$').hasMatch(value);
  }
}

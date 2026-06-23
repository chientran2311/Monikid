import 'dart:async';

import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/features/auth/pin/pin_input_validator.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 're_enter_pin_state.dart';

part 're_enter_pin_provider.g.dart';

@riverpod
class ReEnterPIN extends _$ReEnterPIN {
  late final Logger _logger;
  late final PinCodeRepository _pinCodeRepository;
  Timer? _errorResetTimer;

  @override
  ReEnterPINState build() {
    _logger = getIt<Logger>();
    _pinCodeRepository = ref.read(pinCodeRepositoryProvider);
    ref.onDispose(() {
      _errorResetTimer?.cancel();
    });
    return const ReEnterPINState();
  }

  Future<void> addNumber(String digit) async {
    if (state.isLoading || !isPinDigit(digit)) {
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
    _logger.d('ReEnterPIN.confirmAndSavePinCode: start.');
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
      status: ReEnterPINCodeStatus.loading,
      errorMessage: null,
    );

    // Keep the provider alive across the async gap and the navigation-triggering
    // side effects below; otherwise autoDispose may tear it down mid-flight and
    // using `ref`/`state` afterwards throws "Cannot use ref after dispose".
    final keepAlive = ref.keepAlive();
    // Capture notifiers before the await so they are resolved while alive.
    final createNewPinNotifier = ref.read(createNewPINProvider.notifier);
    final authSessionNotifier = ref.read(authSessionProvider.notifier);
    try {
      if (pin != draftPinCode) {
        state = state.copyWith(
          currentPin: '',
          status: ReEnterPINCodeStatus.mismatch,
          errorMessage: null,
        );
        _scheduleResetAfterError();
        return;
      }

      final pinCodeHash = await _pinCodeRepository.hashPinCode(draftPinCode);
      await _pinCodeRepository.savePinCodeHash(pinCodeHash);
      _logger.i('ReEnterPIN.confirmAndSavePinCode: success.');
      // Set the terminal state before triggering navigation side effects so the
      // last write to `state` happens while the notifier is guaranteed alive.
      state = state.copyWith(
        currentPin: '',
        status: ReEnterPINCodeStatus.success,
        errorMessage: null,
      );
      createNewPinNotifier.reset();
      authSessionNotifier.markPinVerified();
    } catch (error, stackTrace) {
      _logger.e(
        'ReEnterPIN.confirmAndSavePinCode failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        currentPin: '',
        status: ReEnterPINCodeStatus.error,
        errorMessage: 'Failed to save the PIN code.',
      );
    } finally {
      keepAlive.close();
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
}

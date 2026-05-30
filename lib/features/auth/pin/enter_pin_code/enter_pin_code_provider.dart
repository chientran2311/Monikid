import 'dart:async';

import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/pin/pin_code_snapshot/pin_security_snapshot.dart';
import 'package:monikid/features/auth/pin/pin_input_validator.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'enter_pin_code_state.dart';

part 'enter_pin_code_provider.g.dart';

@riverpod
class EnterPINCode extends _$EnterPINCode {
  late final Logger _logger;
  late final PinCodeRepository _pinCodeRepository;
  Timer? _errorResetTimer;
  Timer? _lockTimer;

  @override
  EnterPINCodeState build() {
    _logger = getIt<Logger>();
    _pinCodeRepository = ref.read(pinCodeRepositoryProvider);
    ref.onDispose(() {
      _errorResetTimer?.cancel();
      _lockTimer?.cancel();
    });
    return const EnterPINCodeState();
  }

  Future<void> onInit() async {
    if (state.status != EnterPINCodeStatus.initial) {
      return;
    }

    await _loadSecuritySnapshot();
  }

  Future<void> addNumber(String digit) async {
    if (state.isLoading || state.isLocked || !isPinDigit(digit)) {
      return;
    }

    var currentPin = state.currentPin;
    if (state.hasError) {
      currentPin = '';
      state = state.copyWith(
        status: EnterPINCodeStatus.ready,
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
      await verifyCurrentPin(newPin);
    }
  }

  void removeNumber() {
    if (state.isLoading || state.isLocked) {
      return;
    }

    if (state.hasError) {
      state = state.copyWith(
        status: EnterPINCodeStatus.ready,
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

  Future<void> verifyCurrentPin(String pin) async {
    _logger.d('EnterPINCode.verifyCurrentPin: start.');
    state = state.copyWith(
      status: EnterPINCodeStatus.loading,
      errorMessage: null,
    );

    try {
      final snapshot = await _pinCodeRepository.getPinSecuritySnapshot();
      if (!snapshot.hasPinCode) {
        state = state.copyWith(
          currentPin: '',
          status: EnterPINCodeStatus.error,
          errorMessage: 'Stored PIN data is missing.',
        );
        return;
      }

      if (snapshot.isLocked) {
        _applyLockedSnapshot(snapshot, keepCurrentPin: false);
        return;
      }

      final correct = await _pinCodeRepository.verifyPinCode(
        plainPinCode: pin,
        pinCodeHash: snapshot.pinCodeHash!,
      );

      if (correct) {
        _logger.i('EnterPINCode.verifyCurrentPin: success.');
        await _pinCodeRepository.resetPinAttemptState();
        ref.read(authSessionProvider.notifier).markPinVerified();
        state = state.copyWith(
          currentPin: '',
          failedCount: 0,
          lockedUntil: null,
          remainingLockSeconds: 0,
          status: EnterPINCodeStatus.success,
          errorMessage: null,
        );
        return;
      }

      final updatedSnapshot = await _pinCodeRepository.registerFailedAttempt();
      if (updatedSnapshot.isLocked) {
        _applyLockedSnapshot(updatedSnapshot, keepCurrentPin: false);
        return;
      }

      state = state.copyWith(
        currentPin: '',
        failedCount: updatedSnapshot.failedCount,
        lockedUntil: null,
        remainingLockSeconds: 0,
        status: EnterPINCodeStatus.incorrect,
        errorMessage: null,
      );
      _scheduleResetAfterError();
    } catch (error, stackTrace) {
      _logger.e(
        'EnterPINCode.verifyCurrentPin failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        currentPin: '',
        status: EnterPINCodeStatus.error,
        errorMessage: 'Failed to verify the PIN code.',
      );
    }
  }

  void reset() {
    _errorResetTimer?.cancel();
    _lockTimer?.cancel();
    state = const EnterPINCodeState();
  }

  Future<void> _loadSecuritySnapshot() async {
    _logger.d('EnterPINCode._loadSecuritySnapshot: start.');
    state = state.copyWith(
      status: EnterPINCodeStatus.loading,
      errorMessage: null,
    );

    try {
      final snapshot = await _pinCodeRepository.getPinSecuritySnapshot();
      if (!snapshot.hasPinCode) {
        state = state.copyWith(
          status: EnterPINCodeStatus.error,
          errorMessage: 'Stored PIN data is missing.',
        );
        return;
      }

      if (snapshot.isLocked) {
        _applyLockedSnapshot(snapshot);
        return;
      }

      _logger.i(
        'EnterPINCode._loadSecuritySnapshot: ready. failedCount=${snapshot.failedCount}',
      );
      state = state.copyWith(
        status: EnterPINCodeStatus.ready,
        failedCount: snapshot.failedCount,
        lockedUntil: null,
        remainingLockSeconds: 0,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'EnterPINCode._loadSecuritySnapshot failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: EnterPINCodeStatus.error,
        errorMessage: 'Failed to load the PIN security state.',
      );
    }
  }

  void _applyLockedSnapshot(
    PinSecuritySnapshot snapshot, {
    bool keepCurrentPin = true,
  }) {
    _lockTimer?.cancel();
    state = state.copyWith(
      currentPin: keepCurrentPin ? state.currentPin : '',
      failedCount: snapshot.failedCount,
      lockedUntil: snapshot.lockedUntil,
      remainingLockSeconds: snapshot.remainingLockSeconds,
      status: EnterPINCodeStatus.locked,
      errorMessage: null,
    );
    _startLockCountdown(snapshot.lockedUntil);
  }

  void _scheduleResetAfterError() {
    _errorResetTimer?.cancel();
    _errorResetTimer = Timer(const Duration(milliseconds: 600), () {
      if (state.hasError) {
        state = state.copyWith(
          currentPin: '',
          status: EnterPINCodeStatus.ready,
          errorMessage: null,
        );
      }
    });
  }

  void _startLockCountdown(DateTime? lockedUntil) {
    if (lockedUntil == null) {
      return;
    }

    _lockTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final remainingMilliseconds =
          lockedUntil.difference(DateTime.now()).inMilliseconds;

      if (remainingMilliseconds <= 0) {
        timer.cancel();
        await _loadSecuritySnapshot();
        return;
      }

      state = state.copyWith(
        remainingLockSeconds: ((remainingMilliseconds + 999) / 1000).floor(),
      );
    });
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_pin_code_state.freezed.dart';

enum EnterPINCodeStatus {
  initial,
  loading,
  ready,
  incorrect,
  locked,
  success,
  error,
}

@freezed
abstract class EnterPINCodeState with _$EnterPINCodeState {
  const factory EnterPINCodeState({
    @Default('') String currentPin,
    @Default(EnterPINCodeStatus.initial) EnterPINCodeStatus status,
    @Default(0) int failedCount,
    DateTime? lockedUntil,
    @Default(0) int remainingLockSeconds,
    String? errorMessage,
  }) = _EnterPINCodeState;

  const EnterPINCodeState._();

  bool get isLoading => status == EnterPINCodeStatus.loading;
  bool get isSuccess => status == EnterPINCodeStatus.success;
  bool get hasError =>
      status == EnterPINCodeStatus.incorrect ||
      status == EnterPINCodeStatus.error;
  bool get isLocked =>
      status == EnterPINCodeStatus.locked && remainingLockSeconds > 0;
}

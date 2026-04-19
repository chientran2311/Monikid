import 'package:freezed_annotation/freezed_annotation.dart';

part 're_enter_pin_state.freezed.dart';

enum ReEnterPINCodeStatus {
  initial,
  loading,
  mismatch,
  success,
  error,
}

@freezed
abstract class ReEnterPINState with _$ReEnterPINState {
  const factory ReEnterPINState({
    @Default('') String currentPin,
    @Default(ReEnterPINCodeStatus.initial) ReEnterPINCodeStatus status,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ReEnterPINState;

  const ReEnterPINState._();

  bool get isSuccess => status == ReEnterPINCodeStatus.success;
  bool get hasError =>
      status == ReEnterPINCodeStatus.mismatch ||
      status == ReEnterPINCodeStatus.error;
}

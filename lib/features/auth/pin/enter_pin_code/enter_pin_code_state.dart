import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_pin_code_state.freezed.dart';

enum EnterPINCodeStatus { initial, correct, incorrect }

@freezed
abstract class EnterPINCodeState with _$EnterPINCodeState {
  const factory EnterPINCodeState({
    required String expectedPinHash,
    @Default('') String currentPin,
    @Default(EnterPINCodeStatus.initial) EnterPINCodeStatus status,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool hasError,
  }) = _EnterPINCodeState;

  const EnterPINCodeState._();

  factory EnterPINCodeState.initial(String expectedPinHash) =>
      EnterPINCodeState(expectedPinHash: expectedPinHash);
}

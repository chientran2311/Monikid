import 'package:freezed_annotation/freezed_annotation.dart';

part 're_enter_pin_state.freezed.dart';

enum ReEnterPINCodeStatus { initial, correct, incorrect }

@freezed
abstract class ReEnterPINState with _$ReEnterPINState {
  const factory ReEnterPINState({
    required String pinCodeHash,
    @Default('') String currentPin,
    @Default(ReEnterPINCodeStatus.initial) ReEnterPINCodeStatus status,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool hasError,
  }) = _ReEnterPINState;

  const ReEnterPINState._();

  factory ReEnterPINState.initial(String pinCodeHash) =>
      ReEnterPINState(pinCodeHash: pinCodeHash);
}

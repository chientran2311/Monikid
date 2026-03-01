import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/auth/pin/enum/enter_pin_code_enum.dart';

part 'create_new_pin_state.freezed.dart';

@freezed
abstract class CreateNewPINState with _$CreateNewPINState {
  const factory CreateNewPINState({
    required String pinCode,
    required EnterPINCodeEnum type,
    @Default(false) bool isLoading,
  }) = _CreateNewPINState;

  const CreateNewPINState._();
}

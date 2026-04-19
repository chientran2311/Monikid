import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_new_pin_state.freezed.dart';

enum CreateNewPinStatus {
  editing,
  readyForConfirmation,
}

@freezed
abstract class CreateNewPINState with _$CreateNewPINState {
  const factory CreateNewPINState({
    @Default('') String currentPin,
    String? draftPinCode,
    @Default(CreateNewPinStatus.editing) CreateNewPinStatus status,
  }) = _CreateNewPINState;

  const CreateNewPINState._();

  bool get hasDraftPin => draftPinCode != null && draftPinCode!.length == 6;
}

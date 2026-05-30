import 'package:monikid/features/auth/pin/pin_input_validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'create_new_pin_state.dart';

part 'create_new_pin_provider.g.dart';

@Riverpod(keepAlive: true)
class CreateNewPIN extends _$CreateNewPIN {
  @override
  CreateNewPINState build() {
    return const CreateNewPINState();
  }

  void addNumber(String digit) {
    if (!isPinDigit(digit) || state.currentPin.length >= 6) {
      return;
    }

    final newPin = state.currentPin + digit;

    if (newPin.length == 6) {
      state = state.copyWith(
        currentPin: '',
        draftPinCode: newPin,
        status: CreateNewPinStatus.readyForConfirmation,
      );
      return;
    }

    state = state.copyWith(currentPin: newPin);
  }

  void removeNumber() {
    if (state.currentPin.isEmpty) {
      return;
    }

    state = state.copyWith(
      currentPin: state.currentPin.substring(0, state.currentPin.length - 1),
    );
  }

  void consumeReadyForConfirmation() {
    if (state.status != CreateNewPinStatus.readyForConfirmation) {
      return;
    }

    state = state.copyWith(status: CreateNewPinStatus.editing);
  }

  void reset() {
    state = const CreateNewPINState();
  }
}

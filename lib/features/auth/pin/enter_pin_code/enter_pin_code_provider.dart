import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/utils/bcrypt_util.dart';
import 'enter_pin_code_state.dart';

part 'enter_pin_code_provider.g.dart';

@riverpod
class EnterPINCode extends _$EnterPINCode {
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  EnterPINCodeState build(String expectedPinHash) {
    return EnterPINCodeState.initial(expectedPinHash);
  }

  void addNumber(String digit) {
    if (state.hasError) {
      state = state.copyWith(hasError: false, currentPin: '');
    }
    if (state.currentPin.length < 6) {
      final newPin = state.currentPin + digit;
      state = state.copyWith(currentPin: newPin);
      if (newPin.length == 6) {
        _handlePinComplete(newPin);
      }
    }
  }

  void removeNumber() {
    if (state.hasError) {
      state = state.copyWith(hasError: false, currentPin: '');
      return;
    }
    if (state.currentPin.isNotEmpty) {
      state = state.copyWith(
        currentPin: state.currentPin.substring(0, state.currentPin.length - 1),
      );
    }
  }

  void onTextChanged(String text) {
    if (!state.isLoading) {
      if (state.hasError) {
        state = state.copyWith(hasError: false);
      }
      state = state.copyWith(currentPin: text);
      if (text.length == 6) {
        _handlePinComplete(text);
      }
    }
  }

  Future<void> _handlePinComplete(String pin) async {
    state = state.copyWith(isLoading: true);
    try {
      _logger.i('🔒 Verifying entered PIN...');
      final correct = await checkPinCode(pin, state.expectedPinHash);
      if (correct) {
        _logger.i('✅ PIN verified successfully!');
        state = state.copyWith(
          isLoading: false,
          status: EnterPINCodeStatus.correct,
          isSuccess: true,
        );
      } else {
        _logger.w('❌ Wrong PIN!');
        state = state.copyWith(
          isLoading: false,
          status: EnterPINCodeStatus.incorrect,
          hasError: true,
        );
        Future.delayed(const Duration(milliseconds: 600), () {
          if (state.hasError) {
            state = state.copyWith(
              currentPin: '',
              hasError: false,
              status: EnterPINCodeStatus.initial,
            );
          }
        });
      }
    } catch (e, stack) {
      _logger.e('❌ Error verifying PIN', error: e, stackTrace: stack);
      state = state.copyWith(
        isLoading: false,
        status: EnterPINCodeStatus.incorrect,
        hasError: true,
      );
    }
  }

  void reset() {
    state = EnterPINCodeState.initial(state.expectedPinHash);
  }
}

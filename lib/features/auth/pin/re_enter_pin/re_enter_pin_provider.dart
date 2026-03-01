import 'package:logger/logger.dart';
import 'package:monikid/core/utils/bcrypt_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 're_enter_pin_state.dart';

part 're_enter_pin_provider.g.dart';

@riverpod
class ReEnterPIN extends _$ReEnterPIN {
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
  ReEnterPINState build(String pinCodeHash) {
    return ReEnterPINState.initial(pinCodeHash);
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
      _logger.i('🔒 Verifying re-entered PIN...');
      final correct = await checkPinCode(pin, state.pinCodeHash);
      if (correct) {
        _logger.i('✅ PIN confirmed. Saving to Secure Storage...');
        final storage = getIt<AppSecureStorage>();
        await storage.write(
          key: StorageKeys.hashedPinKey,
          value: state.pinCodeHash,
        );
        _logger.i('✅ PIN hash saved successfully!');
        state = state.copyWith(
          isLoading: false,
          status: ReEnterPINCodeStatus.correct,
          isSuccess: true,
        );
      } else {
        _logger.w('❌ PIN does not match!');
        state = state.copyWith(
          isLoading: false,
          status: ReEnterPINCodeStatus.incorrect,
          hasError: true,
        );
        // Auto reset sau 600ms để UI xoá input
        Future.delayed(const Duration(milliseconds: 600), () {
          if (state.hasError) {
            state = state.copyWith(
              currentPin: '',
              hasError: false,
              status: ReEnterPINCodeStatus.initial,
            );
          }
        });
      }
    } catch (e, stack) {
      _logger.e('❌ Error verifying PIN', error: e, stackTrace: stack);
      state = state.copyWith(
        isLoading: false,
        status: ReEnterPINCodeStatus.incorrect,
        hasError: true,
      );
    }
  }

  void reset() {
    state = ReEnterPINState.initial(state.pinCodeHash);
  }
}

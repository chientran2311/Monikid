import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'pin_dialog_state.dart';

part 'pin_dialog_provider.g.dart';

@Riverpod(keepAlive: true)
class PinDialogNotifier extends _$PinDialogNotifier {
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
  PinDialogState build() {
    return const PinDialogState(mode: PinDialogMode.setup);
  }

  /// Khởi tạo mode ban đầu. Trả về true nếu yêu cầu popup lên (setup hoặc verify)
  Future<bool> initialize() async {
    _logger.i(
      '🔒 PinDialogNotifier: Initializing... Checking Secure Storage for PIN.',
    );
    final storage = getIt<AppSecureStorage>();
    final storedPin = await storage.read(StorageKeys.hashedPinKey);

    if (storedPin == null || storedPin.isEmpty) {
      _logger.w('⚠️ No PIN found in Secure Storage. Mode set to: SETUP');
      state = const PinDialogState(mode: PinDialogMode.setup);
      return true; // Cần popup setup
    } else {
      _logger.i('✅ PIN found in Secure Storage. Mode set to: VERIFY');
      state = PinDialogState(
        mode: PinDialogMode.verify,
        expectedPin: storedPin,
      );
      return true; // Cần popup verify
    }
  }

  void addNumber(String number) {
    if (state.hasError) {
      state = state.copyWith(hasError: false, currentPin: '');
    }

    if (state.currentPin.length < 6) {
      state = state.copyWith(currentPin: state.currentPin + number);

      if (state.currentPin.length == 6) {
        _handlePinComplete();
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

  Future<void> _handlePinComplete() async {
    if (state.mode == PinDialogMode.verify) {
      _logger.i('🔒 Verifying PIN...');
      state = state.copyWith(isLoading: true);
      // Simulate verifying delay for UX
      await Future.delayed(const Duration(milliseconds: 300));

      if (state.currentPin == state.expectedPin) {
        _logger.i('✅ PIN verified successfully!');
        state = state.copyWith(isSuccess: true, isLoading: false);
      } else {
        _logger.w('❌ Incorrect PIN entered. Verification failed.');
        state = state.copyWith(hasError: true, isLoading: false);
        // Delay 1 chút rồi clear
        Future.delayed(const Duration(milliseconds: 500), () {
          if (state.hasError) {
            state = state.copyWith(currentPin: '', hasError: false);
          }
        });
      }
    } else {
      // Setup
      if (!state.isConfirming) {
        // Lưu first pin, chuyển sang mode confirm
        state = state.copyWith(
          firstPin: state.currentPin,
          currentPin: '',
          isConfirming: true,
        );
      } else {
        // Đang confirm
        if (state.currentPin == state.firstPin) {
          state = state.copyWith(isLoading: true);
          // Lưu vào secure storage
          try {
            _logger.i('💾 Attempting to save new PIN to Secure Storage...');
            final storage = getIt<AppSecureStorage>();
            await storage.write(
              key: StorageKeys.hashedPinKey,
              value: state.currentPin,
            );
            _logger.i('✅ PIN saved to Secure Storage successfully!');
            state = state.copyWith(
              isSuccess: true,
              isLoading: false,
              isPinCreated: true,
            );
          } catch (e, stackTrace) {
            _logger.e(
              '❌ Failed to save PIN to Secure Storage',
              error: e,
              stackTrace: stackTrace,
            );
            state = state.copyWith(hasError: true, isLoading: false);
          }
        } else {
          state = state.copyWith(hasError: true);
          // Xóa và reset về bước xác nhận
          Future.delayed(const Duration(milliseconds: 500), () {
            if (state.hasError) {
              state = state.copyWith(currentPin: '', hasError: false);
            }
          });
        }
      }
    }
  }

  void resetError() {
    state = state.copyWith(hasError: false, currentPin: '');
  }
}

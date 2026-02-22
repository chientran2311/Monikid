import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'pin_dialog_state.dart';

part 'pin_dialog_provider.g.dart';

@riverpod
class PinDialogNotifier extends _$PinDialogNotifier {
  @override
  PinDialogState build() {
    return const PinDialogState(mode: PinDialogMode.setup);
  }

  /// Khởi tạo mode ban đầu. Trả về true nếu yêu cầu popup lên (setup hoặc verify)
  Future<bool> initialize() async {
    final storage = getIt<AppSecureStorage>();
    final storedPin = await storage.read(StorageKeys.hashedPinKey);

    if (storedPin == null || storedPin.isEmpty) {
      state = const PinDialogState(mode: PinDialogMode.setup);
      return true; // Cần popup setup
    } else {
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
      if (state.currentPin == state.expectedPin) {
        state = state.copyWith(isSuccess: true);
      } else {
        state = state.copyWith(hasError: true);
        // Delay 1 chút rồi clear
        Future.delayed(const Duration(milliseconds: 500), () {
          if (state.hasError) {
            state = state.copyWith(currentPin: '');
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
          // Lưu vào secure storage
          final storage = getIt<AppSecureStorage>();
          await storage.write(
            key: StorageKeys.hashedPinKey,
            value: state.currentPin,
          );
          state = state.copyWith(isSuccess: true);
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

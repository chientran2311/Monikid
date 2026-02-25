import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_dialog_state.freezed.dart';

enum PinDialogMode { setup, verify }

@freezed
abstract class PinDialogState with _$PinDialogState {
  const factory PinDialogState({
    required PinDialogMode mode,
    @Default('') String expectedPin, // Dùng cho mode verify
    @Default('') String firstPin, // Lưu mã PIN lần 1 (cho mode setup)
    @Default('') String currentPin, // Mã PIN đang nhập
    @Default(false) bool isConfirming, // Đang ở bước xác nhận lại (setup)
    @Default(false) bool hasError, // Đang ở trạng thái lỗi (rung)
    @Default(false) bool isSuccess, // Xử lý thành công
    @Default(false) bool isLoading, // Đang xử lý
    @Default(false) bool isPinCreated, // Đã tạo mã PIN hay chưa
  }) = _PinDialogState;
}

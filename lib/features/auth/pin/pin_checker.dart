import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';

/// Hàm kiểm tra xem người dùng đã cài đặt mã PIN chưa.
/// Nếu chưa -> Điều hướng sang màn hình tạo mã PIN mới (CreateNewPinScreen).
/// Nếu rồi -> Điều hướng sang màn hình nhập mã PIN (EnterPinCodeScreen) để xác thực.
Future<bool> checkAndShowPinScreens(BuildContext context) async {
  final pinCodeRepository = getIt<PinCodeRepository>();
  final storedPinHash = await pinCodeRepository.getStoredPinHash();

  if (!context.mounted) return false;

  if (storedPinHash == null || storedPinHash.isEmpty) {
    // Chưa có mã PIN -> Điều hướng qua màn tạo PIN (không được cancel)
    final result = await context.push<bool>(
      AppRoutes.createNewPin,
      extra: {'canCancel': false},
    );
    return result ?? false;
  } else {
    // Đã có mã PIN -> Điều hướng qua màn xác thực PIN (không được cancel)
    final result = await context.push<bool>(
      AppRoutes.enterPinCode,
      extra: {'expectedPinHash': storedPinHash, 'canCancel': false},
    );
    return result ?? false;
  }
}

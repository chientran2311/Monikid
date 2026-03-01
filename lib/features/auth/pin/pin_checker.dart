import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/core/storage/secure_storage.dart';

/// Hàm kiểm tra xem người dùng đã cài đặt mã PIN chưa.
/// Nếu chưa -> Điều hướng sang màn hình tạo mã PIN mới (CreateNewPinScreen).
/// Nếu rồi -> Điều hướng sang màn hình nhập mã PIN (EnterPinCodeScreen) để xác thực.
Future<bool> checkAndShowPinScreens(BuildContext context) async {
  final storage = getIt<AppSecureStorage>();
  final storedPinHash = await storage.read(StorageKeys.hashedPinKey);

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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/utils/bcrypt_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/app/router.dart';

import 'package:monikid/features/auth/pin/enum/enter_pin_code_enum.dart';
import 'create_new_pin_state.dart';

part 'create_new_pin_provider.g.dart';

@riverpod
class CreateNewPIN extends _$CreateNewPIN {
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
  CreateNewPINState build(EnterPINCodeEnum type, {String? pinCode}) {
    return CreateNewPINState(pinCode: pinCode ?? '', type: type);
  }

  void onTextChanged(String text) {
    state = state.copyWith(pinCode: text);
  }

  /// Bcrypt PIN ngay tại đây, rồi navigate sang Re-Enter PIN screen.
  /// [context] dùng để GoRouter navigate.
  Future<void> navigationReEnterPinCode(
    String text,
    BuildContext context,
  ) async {
    if (!state.isLoading) {
      state = state.copyWith(isLoading: true);
      try {
        _logger.i('🔐 Hashing PIN with bcrypt before navigation...');
        // Hash PIN trước khi truyền sang màn re-enter. PIN thô chỉ tồn tại trong RAM.
        final pinCodeHash = await bcryptPin(text);
        _logger.i('✅ PIN hashed. Navigating to Re-Enter PIN screen.');

        if (context.mounted) {
          final result = await context.push<bool>(
            AppRoutes.reEnterPin,
            extra: {'pinCodeHash': pinCodeHash},
          );
          if (result == true && context.mounted) {
            Navigator.of(context).pop(true);
          }
        }
      } catch (e, stack) {
        _logger.e(
          '❌ Failed to hash PIN or navigate',
          error: e,
          stackTrace: stack,
        );
      } finally {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}

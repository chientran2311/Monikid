import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:monikid/core/utils/bcrypt_util.dart';
import 'package:monikid/features/auth/pin/domain/pin_security_snapshot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pin_code_repository.g.dart';

@riverpod
PinCodeRepository pinCodeRepository(Ref ref) {
  return getIt<PinCodeRepository>();
}

abstract class PinCodeRepository {
  Future<String?> getStoredPinHash();

  Future<PinSecuritySnapshot> getPinSecuritySnapshot();

  Future<bool> hasPinCode();

  Future<String> hashPinCode(String pinCode);

  Future<bool> verifyPinCode({
    required String plainPinCode,
    required String pinCodeHash,
  });

  Future<void> savePinCodeHash(String pinCodeHash);

  Future<PinSecuritySnapshot> registerFailedAttempt();

  Future<void> resetPinAttemptState();
}

class PinCodeRepositoryImpl implements PinCodeRepository {
  static const Duration _pinLockDuration = Duration(seconds: 30);

  PinCodeRepositoryImpl(this._secureStorage, this._logger);

  final AppSecureStorage _secureStorage;
  final Logger _logger;

  @override
  Future<String?> getStoredPinHash() async {
    try {
      final snapshot = await getPinSecuritySnapshot();
      return snapshot.pinCodeHash;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to read the stored PIN hash.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<PinSecuritySnapshot> getPinSecuritySnapshot() async {
    try {
      final pinCodeHash = await _secureStorage.read(StorageKeys.hashedPinKey);
      final failedCountRaw = await _secureStorage.read(
        StorageKeys.pinFailedCountKey,
      );
      final lockedUntilRaw = await _secureStorage.read(
        StorageKeys.pinLockedUntilKey,
      );

      final failedCount = int.tryParse(failedCountRaw ?? '') ?? 0;
      final lockedUntil = lockedUntilRaw == null
          ? null
          : DateTime.tryParse(lockedUntilRaw);

      final snapshot = PinSecuritySnapshot(
        pinCodeHash: pinCodeHash,
        failedCount: failedCount,
        lockedUntil: lockedUntil,
      );

      if (snapshot.isLocked || lockedUntil == null) {
        return snapshot;
      }

      if (failedCount > 0) {
        await resetPinAttemptState();
      }

      return snapshot.copyWith(
        failedCount: 0,
        lockedUntil: null,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to read the PIN security snapshot.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> hasPinCode() async {
    final snapshot = await getPinSecuritySnapshot();
    return snapshot.hasPinCode;
  }

  @override
  Future<String> hashPinCode(String pinCode) async {
    try {
      _logger.i('Hashing a new PIN code.');
      return await bcryptPin(pinCode);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to hash the PIN code.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> verifyPinCode({
    required String plainPinCode,
    required String pinCodeHash,
  }) async {
    try {
      _logger.i('Verifying the entered PIN code.');
      return await checkPinCode(plainPinCode, pinCodeHash);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to verify the PIN code.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> savePinCodeHash(String pinCodeHash) async {
    try {
      await _secureStorage.write(
        key: StorageKeys.hashedPinKey,
        value: pinCodeHash,
      );
      await resetPinAttemptState();
      _logger.i('Saved the hashed PIN code to secure storage.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to save the PIN code.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<PinSecuritySnapshot> registerFailedAttempt() async {
    try {
      final snapshot = await getPinSecuritySnapshot();
      final nextFailedCount = snapshot.failedCount + 1;
      final shouldLock = nextFailedCount >= 3;
      final lockedUntil = shouldLock
          ? DateTime.now().add(_pinLockDuration)
          : null;

      await _secureStorage.write(
        key: StorageKeys.pinFailedCountKey,
        value: nextFailedCount.toString(),
      );
      await _secureStorage.write(
        key: StorageKeys.pinLockedUntilKey,
        value: lockedUntil?.toIso8601String(),
      );

      _logger.w(
        'Registered a failed PIN attempt. count=$nextFailedCount locked=$shouldLock',
      );

      return snapshot.copyWith(
        failedCount: nextFailedCount,
        lockedUntil: lockedUntil,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to register the failed PIN attempt.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> resetPinAttemptState() async {
    try {
      await _secureStorage.write(
        key: StorageKeys.pinFailedCountKey,
        value: '0',
      );
      await _secureStorage.write(
        key: StorageKeys.pinLockedUntilKey,
        value: null,
      );
      _logger.i('Reset the PIN attempt state.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to reset the PIN attempt state.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

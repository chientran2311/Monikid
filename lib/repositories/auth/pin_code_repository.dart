import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:monikid/core/utils/bcrypt_util.dart';

abstract class PinCodeRepository {
  Future<String?> getStoredPinHash();

  Future<bool> hasPinCode();

  Future<String> hashPinCode(String pinCode);

  Future<bool> verifyPinCode({
    required String plainPinCode,
    required String pinCodeHash,
  });

  Future<void> savePinCodeHash(String pinCodeHash);
}

class PinCodeRepositoryImpl implements PinCodeRepository {
  PinCodeRepositoryImpl(this._secureStorage, this._logger);

  final AppSecureStorage _secureStorage;
  final Logger _logger;

  @override
  Future<String?> getStoredPinHash() async {
    try {
      return await _secureStorage.read(StorageKeys.hashedPinKey);
    } catch (e, stackTrace) {
      _logger.e(
        'Không thể đọc mã PIN đã lưu.',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> hasPinCode() async {
    final storedPinHash = await getStoredPinHash();
    return storedPinHash != null && storedPinHash.isNotEmpty;
  }

  @override
  Future<String> hashPinCode(String pinCode) async {
    try {
      _logger.i('Đang băm mã PIN mới.');
      return await bcryptPin(pinCode);
    } catch (e, stackTrace) {
      _logger.e(
        'Không thể băm mã PIN.',
        error: e,
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
      return await checkPinCode(plainPinCode, pinCodeHash);
    } catch (e, stackTrace) {
      _logger.e(
        'Không thể xác thực mã PIN.',
        error: e,
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
      _logger.i('Đã lưu mã PIN đã băm vào secure storage.');
    } catch (e, stackTrace) {
      _logger.e(
        'Không thể lưu mã PIN.',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

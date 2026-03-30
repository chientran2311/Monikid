import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/storage/local_storage.dart';

abstract class OnboardingRepository {
  Future<bool> isOnboardingComplete();

  Future<void> markOnboardingComplete();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._localStorage, this._logger);

  final AppLocalStorage _localStorage;
  final Logger _logger;

  @override
  Future<bool> isOnboardingComplete() async {
    try {
      return _localStorage.readBoolSync(StorageKeys.isOnboarded) ?? false;
    } catch (e, stackTrace) {
      _logger.e(
        'Không thể đọc trạng thái onboarding.',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> markOnboardingComplete() async {
    try {
      await _localStorage.writeBool(
        key: StorageKeys.isOnboarded,
        value: true,
      );
      _logger.i('Đã đánh dấu onboarding hoàn tất.');
    } catch (e, stackTrace) {
      _logger.e(
        'Không thể lưu trạng thái onboarding.',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

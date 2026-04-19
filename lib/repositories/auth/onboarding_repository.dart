import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_repository.g.dart';

@riverpod
OnboardingRepository onboardingRepository(Ref ref) {
  return getIt<OnboardingRepository>();
}

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
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to read the onboarding status.',
        error: error,
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
      _logger.i('Marked onboarding as completed.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to persist the onboarding status.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

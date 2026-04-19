import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'set_money_limit_repository.g.dart';

@riverpod
SetMoneyLimitRepository setMoneyLimitRepository(Ref ref) {
  return getIt<SetMoneyLimitRepository>();
}

abstract class SetMoneyLimitRepository {
  Future<int?> readMonthlyLimitMinor(String userId);

  Future<void> saveMonthlyLimitMinor({
    required String userId,
    required int amountMinor,
  });

  Future<void> clearMonthlyLimitMinor(String userId);
}

class SetMoneyLimitRepositoryImpl implements SetMoneyLimitRepository {
  SetMoneyLimitRepositoryImpl(this._localStorage, this._logger);

  final AppLocalStorage _localStorage;
  final Logger _logger;

  @override
  Future<int?> readMonthlyLimitMinor(String userId) async {
    try {
      final rawValue = _localStorage.readSync(_storageKey(userId));
      if (rawValue == null || rawValue.isEmpty) {
        return null;
      }

      return int.tryParse(rawValue);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to read the monthly spending limit from local storage.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<void> saveMonthlyLimitMinor({
    required String userId,
    required int amountMinor,
  }) async {
    try {
      await _localStorage.write(
        key: _storageKey(userId),
        value: amountMinor.toString(),
      );
      _logger.i('Saved the monthly spending limit for userId=$userId.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to save the monthly spending limit to local storage.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> clearMonthlyLimitMinor(String userId) async {
    try {
      await _localStorage.delete(key: _storageKey(userId));
      _logger.i('Cleared the monthly spending limit for userId=$userId.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to clear the monthly spending limit from local storage.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  String _storageKey(String userId) {
    return '${StorageKeys.monthlyLimitMinorPrefix}_$userId';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
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

class FirestoreSpendingLimitRepositoryImpl implements SetMoneyLimitRepository {
  FirestoreSpendingLimitRepositoryImpl({
    required FirebaseFirestore firestore,
    required Logger logger,
  })  : _firestore = firestore,
        _logger = logger;

  final FirebaseFirestore _firestore;
  final Logger _logger;

  DocumentReference<Map<String, dynamic>> _userDoc(String userId) =>
      _firestore.collection('users').doc(userId);

  @override
  Future<int?> readMonthlyLimitMinor(String userId) async {
    try {
      final snap = await _userDoc(userId).get();
      final data = snap.data();
      if (data == null) return null;
      // Reads new key (monthly_limit) with fallback to legacy (monthly_limit_minor).
      final raw = data['monthly_limit'];
      return raw is int ? raw : null;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to read monthly_limit from Firestore.',
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
      await _userDoc(userId).update({
        'monthly_limit': amountMinor,
        'updated_at': FieldValue.serverTimestamp(),
      });
      _logger.i('Saved monthly_limit=$amountMinor for userId=$userId.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to save monthly_limit to Firestore.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> clearMonthlyLimitMinor(String userId) async {
    try {
      await _userDoc(userId).update({
        'monthly_limit': FieldValue.delete(),
        'updated_at': FieldValue.serverTimestamp(),
      });
      _logger.i('Cleared monthly_limit for userId=$userId.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to clear monthly_limit from Firestore.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

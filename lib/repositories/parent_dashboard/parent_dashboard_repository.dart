import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'parent_dashboard_repository.g.dart';

abstract class ParentDashboardRepository {
  Future<List<TransactionModel>> getChildRecentTransactions({
    required String childUid,
    int limit = 5,
  });

  Future<({int expenseMinor, int incomeMinor})> getChildMonthlySummary({
    required String childUid,
    required String monthKey,
  });

  /// Reads the monthly spending limit (VND) set on the child's user doc.
  /// Returns null when no limit is configured.
  Future<int?> getChildMonthlyLimit({required String childUid});

  Future<void> setChildMonthlyLimit({
    required String childUid,
    required int amountMinor,
  });

  Future<void> removeChildMonthlyLimit({required String childUid});

  Future<Map<String, int?>> getChildrenMonthlyLimits({
    required List<String> childUids,
  });
}

class ParentDashboardRepositoryImpl implements ParentDashboardRepository {
  ParentDashboardRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  Future<List<TransactionModel>> getChildRecentTransactions({
    required String childUid,
    int limit = 5,
  }) async {
    try {
      final snap = await _firestore
          .collection('users')
          .doc(childUid)
          .collection('transactions')
          .orderBy('transaction_date', descending: true)
          .limit(limit)
          .get();
      return snap.docs
          .map((doc) {
            final data = doc.data();
            return TransactionModel.fromFirestore({
              ...data,
              if ((data['transaction_id'] as String?) == null ||
                  (data['transaction_id'] as String).isEmpty)
                'transaction_id': doc.id,
            });
          })
          .toList(growable: false);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch recent transactions for child $childUid',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<({int expenseMinor, int incomeMinor})> getChildMonthlySummary({
    required String childUid,
    required String monthKey,
  }) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(childUid)
          .collection('monthly_summaries')
          .doc(monthKey)
          .get();

      if (!doc.exists) return (expenseMinor: 0, incomeMinor: 0);
      final data = doc.data()!;
      return (
        expenseMinor: (data['total_expense'] as num?)?.toInt() ?? 0,
        incomeMinor: (data['total_income'] as num?)?.toInt() ?? 0,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch monthly summary for child $childUid',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<int?> getChildMonthlyLimit({required String childUid}) async {
    try {
      final doc = await _firestore.collection('users').doc(childUid).get();
      if (!doc.exists) return null;
      return (doc.data()?['monthly_limit'] as num?)?.toInt();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch monthly limit for child $childUid',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> setChildMonthlyLimit({
    required String childUid,
    required int amountMinor,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(childUid)
          .update({
            'monthly_limit': amountMinor,
            'updated_at': FieldValue.serverTimestamp(),
          });
      _logger.i('Set monthly_limit=$amountMinor for child=$childUid.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to set child monthly limit for child=$childUid.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> removeChildMonthlyLimit({required String childUid}) async {
    try {
      await _firestore
          .collection('users')
          .doc(childUid)
          .update({
            'monthly_limit': FieldValue.delete(),
            'updated_at': FieldValue.serverTimestamp(),
          });
      _logger.i('Removed monthly_limit for child=$childUid.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to remove child monthly limit for child=$childUid.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<Map<String, int?>> getChildrenMonthlyLimits({
    required List<String> childUids,
  }) async {
    if (childUids.isEmpty) return {};
    try {
      final docs = await Future.wait(
        childUids.map(
          (uid) => _firestore.collection('users').doc(uid).get(),
        ),
      );
      final limits = <String, int?>{};
      for (var i = 0; i < childUids.length; i++) {
        final data = docs[i].data();
        limits[childUids[i]] = (data?['monthly_limit'] as num?)?.toInt();
      }
      return limits;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch monthly limits for children=$childUids.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

@riverpod
ParentDashboardRepository parentDashboardRepository(Ref ref) {
  return getIt<ParentDashboardRepository>();
}

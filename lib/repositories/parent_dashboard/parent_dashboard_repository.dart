import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> setChildMonthlyLimit({
    required String childUid,
    required int amountMinor,
  });

  Future<void> removeChildMonthlyLimit({required String childUid});
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
          .orderBy('date_ts', descending: true)
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
        expenseMinor: (data['total_expense_minor'] as num?)?.toInt() ?? 0,
        incomeMinor: (data['total_income_minor'] as num?)?.toInt() ?? 0,
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
  Future<void> setChildMonthlyLimit({
    required String childUid,
    required int amountMinor,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(childUid)
          .update({'monthly_limit_minor': amountMinor});
      _logger.i('Set monthly_limit_minor=$amountMinor for child=$childUid.');
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
          .update({'monthly_limit_minor': FieldValue.delete()});
      _logger.i('Removed monthly_limit_minor for child=$childUid.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to remove child monthly limit for child=$childUid.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

@riverpod
ParentDashboardRepository parentDashboardRepository(
    ParentDashboardRepositoryRef ref) {
  return getIt<ParentDashboardRepository>();
}

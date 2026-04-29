import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthly_summary_repository.g.dart';

@riverpod
MonthlySummaryRepository monthlySummaryRepository(Ref ref) {
  return getIt<MonthlySummaryRepository>();
}

abstract class MonthlySummaryRepository {
  Future<void> applyDelta({
    required String userId,
    String? familyId,
    required String monthKey,
    required int deltaExpenseMinor,
    required int deltaIncomeMinor,
    required int deltaCount,
  });
}

class MonthlySummaryRepositoryImpl implements MonthlySummaryRepository {
  MonthlySummaryRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  DocumentReference<Map<String, dynamic>> _summaryDoc(
    String userId,
    String monthKey,
  ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('monthly_summaries')
        .doc(monthKey);
  }

  @override
  Future<void> applyDelta({
    required String userId,
    String? familyId,
    required String monthKey,
    required int deltaExpenseMinor,
    required int deltaIncomeMinor,
    required int deltaCount,
  }) async {
    try {
      await _summaryDoc(userId, monthKey).set(
        {
          'month_key': monthKey,
          'user_id': userId,
          if (familyId != null) 'family_id': familyId,
          'total_expense_minor': FieldValue.increment(deltaExpenseMinor),
          'total_income_minor': FieldValue.increment(deltaIncomeMinor),
          'transaction_count': FieldValue.increment(deltaCount),
          'updated_at': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (error, stackTrace) {
      _logger.w(
        'MonthlySummaryRepository: failed to apply delta for $userId/$monthKey',
        error: error,
        stackTrace: stackTrace,
      );
      // Non-blocking: summary failure must not fail the transaction write.
    }
  }
}

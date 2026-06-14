import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/transaction/transaction_type.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/ai/receipt_ocr_service.dart';
import 'package:monikid/repositories/child_statistic/statistic_repository.dart';
import 'package:monikid/repositories/transaction/transaction_evidence_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  return getIt<TransactionRepository>();
}

typedef TransactionSummary = ({double totalIncome, double totalExpense});
typedef TransactionMonthRecord = ({
  List<TransactionModel> transactions,
  DateTime month,
});

abstract class TransactionRepository {
  Future<TransactionModel> addTransaction(
    TransactionModel transaction, {
    TransactionEvidenceUploadPayload? evidenceUpload,
    Duration uploadTimeout = const Duration(seconds: 30),
  });

  Future<TransactionModel> updateTransaction(
    TransactionModel transaction, {
    TransactionEvidenceUploadPayload? newEvidenceUpload,
    TransactionEvidenceImage? previousEvidenceImage,
    bool removeExistingEvidence = false,
    Duration uploadTimeout = const Duration(seconds: 30),
  });

  Future<String?> getEvidenceDownloadUrl(
    TransactionEvidenceImage? evidenceImage,
  );

  Future<TransactionModel?> getTransactionById(
    String userId,
    String transactionId,
  );

  Future<TransactionMonthRecord> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  });

  Future<List<TransactionModel>?> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 6,
  });

  Future<List<TransactionModel>> getTransactionsByFilter(
    String userId, {
    DateTime? date,
    String? categoryKey,
    String? type,
    TransactionModel? lastTransaction,
    int limit = 8,
  });

  Future<List<TransactionModel>> getTransactionsByCategoryAndPeriod(
    String userId, {
    required String categoryKey,
    required int selectedTabIndex,
    required DateTime anchorDate,
    TransactionType type = TransactionType.expense,
  });

  Future<TransactionSummary?> getSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
    String? categoryKey,
    String? type,
  });

  Stream<TransactionSummary> watchSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
    String? categoryKey,
    String? type,
  });
}

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(
    this._firestore,
    this._evidenceStorage,
    this._logger,
    this._ocrService,
  );

  final FirebaseFirestore _firestore;
  final TransactionEvidenceStorage _evidenceStorage;
  final Logger _logger;
  final ReceiptOcrService _ocrService;

  String _monthKey(DateTime date) => DateFormat('yyyy-MM').format(date);

  CollectionReference<Map<String, dynamic>> _transactionsOfUser(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions');
  }

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
  Future<TransactionModel> addTransaction(
    TransactionModel transaction, {
    TransactionEvidenceUploadPayload? evidenceUpload,
    Duration uploadTimeout = const Duration(seconds: 30),
  }) async {
    TransactionEvidenceImage? uploadedEvidenceImage;

    try {
      if (evidenceUpload != null) {
        final (recipientName, transactionDate) = await _resolveOcrMetadata(evidenceUpload);
        uploadedEvidenceImage = await _evidenceStorage
            .uploadEvidenceImage(
              userId: transaction.userId,
              transactionId: transaction.transactionId,
              payload: evidenceUpload,
              recipientName: recipientName,
              transactionDate: transactionDate,
            )
            .timeout(uploadTimeout);
      }

      final transactionToSave = transaction.copyWith(
        updatedAt: transaction.updatedAt ?? DateTime.now(),
        evidenceImage: uploadedEvidenceImage ?? transaction.evidenceImage,
      );

      _logger.i('Adding transaction ${transaction.transactionId}.');
      final monthKey = _monthKey(transactionToSave.date);
      final txRef = _transactionsOfUser(transactionToSave.userId)
          .doc(transactionToSave.transactionId);
      final summaryRef = _summaryDoc(transactionToSave.userId, monthKey);
      final isExpense = transactionToSave.type == 'expense';
      await _firestore.runTransaction((txn) async {
        txn.set(txRef, transactionToSave.toFirestore());
        txn.set(
          summaryRef,
          {
            'month_key': monthKey,
            'user_id': transactionToSave.userId,
            'total_expense':
                FieldValue.increment(isExpense ? transactionToSave.amountMinor : 0),
            'total_income':
                FieldValue.increment(!isExpense ? transactionToSave.amountMinor : 0),
            'updated_at': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      });
      return transactionToSave;
    } catch (error, stackTrace) {
      if (uploadedEvidenceImage != null) {
        await _cleanupUploadedEvidence(uploadedEvidenceImage.storagePath);
      }
      if (error is FirebaseException) {
        _logger.e(
          'Failed to add transaction with firebase code=${error.code} '
          'message=${error.message} payloadKeys=${transactionToDebugKeys(transaction, uploadedEvidenceImage)}',
          error: error,
          stackTrace: stackTrace,
        );
      }
      _logger.e(
        'Failed to add transaction.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TransactionModel> updateTransaction(
    TransactionModel transaction, {
    TransactionEvidenceUploadPayload? newEvidenceUpload,
    TransactionEvidenceImage? previousEvidenceImage,
    bool removeExistingEvidence = false,
    Duration uploadTimeout = const Duration(seconds: 30),
  }) async {
    TransactionEvidenceImage? uploadedEvidenceImage;

    try {
      if (newEvidenceUpload != null) {
        final (recipientName, transactionDate) = await _resolveOcrMetadata(newEvidenceUpload);
        uploadedEvidenceImage = await _evidenceStorage
            .uploadEvidenceImage(
              userId: transaction.userId,
              transactionId: transaction.transactionId,
              payload: newEvidenceUpload,
              recipientName: recipientName,
              transactionDate: transactionDate,
            )
            .timeout(uploadTimeout);
      }

      final updatedTransaction = transaction.copyWith(
        updatedAt: DateTime.now(),
        evidenceImage:
            uploadedEvidenceImage ??
            (removeExistingEvidence ? null : transaction.evidenceImage),
      );
      _logger.i('Updating transaction ${transaction.transactionId}.');
      final txRef = _transactionsOfUser(updatedTransaction.userId)
          .doc(updatedTransaction.transactionId);
      await _firestore.runTransaction((txn) async {
        final oldSnap = await txn.get(txRef);
        txn.update(txRef, updatedTransaction.toFirestore());
        if (oldSnap.exists) {
          final oldTx = TransactionModel.fromFirestore({
            ...oldSnap.data()!,
            'transaction_id': oldSnap.id,
          });
          final oldMonthKey = _monthKey(oldTx.date);
          final newMonthKey = _monthKey(updatedTransaction.date);
          final oldExp = oldTx.type == 'expense' ? oldTx.amountMinor : 0;
          final newExp = updatedTransaction.type == 'expense' ? updatedTransaction.amountMinor : 0;
          final oldInc = oldTx.type == 'income' ? oldTx.amountMinor : 0;
          final newInc = updatedTransaction.type == 'income' ? updatedTransaction.amountMinor : 0;
          if (oldMonthKey == newMonthKey) {
            txn.set(
              _summaryDoc(updatedTransaction.userId, newMonthKey),
              {
                'month_key': newMonthKey,
                'user_id': updatedTransaction.userId,
                'total_expense': FieldValue.increment(newExp - oldExp),
                'total_income': FieldValue.increment(newInc - oldInc),
                'updated_at': FieldValue.serverTimestamp(),
              },
              SetOptions(merge: true),
            );
          } else {
            // Transaction moved to a different month — reverse old, add to new.
            txn.set(
              _summaryDoc(updatedTransaction.userId, oldMonthKey),
              {
                'month_key': oldMonthKey,
                'user_id': updatedTransaction.userId,
                'total_expense': FieldValue.increment(-oldExp),
                'total_income': FieldValue.increment(-oldInc),
                'updated_at': FieldValue.serverTimestamp(),
              },
              SetOptions(merge: true),
            );
            txn.set(
              _summaryDoc(updatedTransaction.userId, newMonthKey),
              {
                'month_key': newMonthKey,
                'user_id': updatedTransaction.userId,
                'total_expense': FieldValue.increment(newExp),
                'total_income': FieldValue.increment(newInc),
                'updated_at': FieldValue.serverTimestamp(),
              },
              SetOptions(merge: true),
            );
          }
        }
      });

      if (uploadedEvidenceImage != null &&
          previousEvidenceImage != null &&
          previousEvidenceImage.storagePath !=
              uploadedEvidenceImage.storagePath) {
        await _cleanupUploadedEvidence(previousEvidenceImage.storagePath);
      }

      if (removeExistingEvidence && previousEvidenceImage != null) {
        await _cleanupUploadedEvidence(previousEvidenceImage.storagePath);
      }
      return updatedTransaction;
    } catch (error, stackTrace) {
      if (uploadedEvidenceImage != null) {
        await _cleanupUploadedEvidence(uploadedEvidenceImage.storagePath);
      }
      _logger.e(
        'Failed to update transaction.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<String?> getEvidenceDownloadUrl(
    TransactionEvidenceImage? evidenceImage,
  ) async {
    if (evidenceImage == null || evidenceImage.storagePath.trim().isEmpty) {
      return null;
    }

    try {
      return await _evidenceStorage.getEvidenceDownloadUrl(
        evidenceImage.storagePath,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to resolve evidence image URL.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<TransactionModel?> getTransactionById(
    String userId,
    String transactionId,
  ) async {
    try {
      _logger.i('Fetching transaction $transactionId.');
      final snapshot = await _transactionsOfUser(
        userId,
      ).doc(transactionId).get();
      final data = snapshot.data();
      if (!snapshot.exists || data == null) {
        return null;
      }

      return TransactionModel.fromFirestore({
        ...data,
        'transaction_id': data['transaction_id'] ?? snapshot.id,
        if ((data['user_id'] as String?) == null ||
            (data['user_id'] as String).isEmpty)
          'user_id': userId,
      });
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch transaction by id.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<TransactionMonthRecord> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  }) async {
    final range = _monthRange(month);

    Query<Map<String, dynamic>> query = _transactionsOfUser(userId)
        .where(
          'transaction_date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
        )
        .where('transaction_date', isLessThanOrEqualTo: Timestamp.fromDate(range.end))
        .orderBy('transaction_date', descending: true);

    if (type != null && type != 'all') {
      query = query.where('type', isEqualTo: type);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    try {
      final snapshot = await query.get();
      final transactions = snapshot.docs.map(_mapTransaction).toList();
      return (transactions: transactions, month: month);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch transactions by month.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>?> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 6,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _transactionsOfUser(
        userId,
      ).orderBy('transaction_date', descending: true).limit(limit);

      if (lastTransaction != null) {
        query = query.startAfter([Timestamp.fromDate(lastTransaction.dateTs)]);
      }

      final snapshot = await query.get();
      return snapshot.docs.map(_mapTransaction).toList();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch recent transactions.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByFilter(
    String userId, {
    DateTime? date,
    String? categoryKey,
    String? type,
    TransactionModel? lastTransaction,
    int limit = 8,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _buildFilteredTransactionQuery(
        userId,
        date: date,
        month: date == null ? DateTime.now() : null,
        categoryKey: categoryKey,
        type: type,
      ).limit(limit);

      if (lastTransaction != null) {
        query = query.startAfter([Timestamp.fromDate(lastTransaction.dateTs)]);
      }

      final snapshot = await query.get();
      return snapshot.docs.map(_mapTransaction).toList();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to fetch transactions by filter.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategoryAndPeriod(
    String userId, {
    required String categoryKey,
    required int selectedTabIndex,
    required DateTime anchorDate,
    TransactionType type = TransactionType.expense,
  }) async {
    _logger.d(
      'TransactionRepositoryImpl.getTransactionsByCategoryAndPeriod: '
      'userId=$userId, categoryKey=$categoryKey, selectedTabIndex=$selectedTabIndex, '
      'type=${type.value}',
    );
    try {
      final range = statisticGetPeriodRange(
        selectedTabIndex: selectedTabIndex,
        anchorDate: anchorDate,
      );
      final snapshot = await _transactionsOfUser(userId)
          .where(
            'transaction_date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where(
            'transaction_date',
            isLessThanOrEqualTo: Timestamp.fromDate(range.end),
          )
          .where('category_id', isEqualTo: categoryKey)
          .where('type', isEqualTo: type.value)
          .orderBy('transaction_date', descending: true)
          .get();
      final result = snapshot.docs.map(_mapTransaction).toList();
      _logger.i(
        'TransactionRepositoryImpl.getTransactionsByCategoryAndPeriod: success. count=${result.length}',
      );
      return result;
    } catch (error, stackTrace) {
      _logger.e(
        'TransactionRepositoryImpl.getTransactionsByCategoryAndPeriod failed.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TransactionSummary?> getSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
    String? categoryKey,
    String? type,
  }) async {
    try {
      final snapshot = await _buildSummaryQuery(
        userId,
        month: month,
        date: date,
        categoryKey: categoryKey,
        type: type,
      ).get();
      return _sumTransactions(snapshot.docs.map(_mapTransaction));
    } catch (error, stackTrace) {
      _logger.e('Failed to get summary.', error: error, stackTrace: stackTrace);
      return null;
    }
  }

  @override
  Stream<TransactionSummary> watchSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
    String? categoryKey,
    String? type,
  }) {
    return _buildSummaryQuery(
      userId,
      month: month,
      date: date,
      categoryKey: categoryKey,
      type: type,
    ).snapshots().map(
      (snapshot) => _sumTransactions(snapshot.docs.map(_mapTransaction)),
    );
  }

  Query<Map<String, dynamic>> _buildFilteredTransactionQuery(
    String userId, {
    DateTime? month,
    DateTime? date,
    String? categoryKey,
    String? type,
  }) {
    Query<Map<String, dynamic>> query = _transactionsOfUser(userId);

    if (date != null) {
      final range = _dayRange(date);
      query = query
          .where(
            'transaction_date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where('transaction_date', isLessThanOrEqualTo: Timestamp.fromDate(range.end));
    } else {
      final range = _monthRange(month ?? DateTime.now());
      query = query
          .where(
            'transaction_date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where('transaction_date', isLessThanOrEqualTo: Timestamp.fromDate(range.end));
    }

    if (categoryKey != null && categoryKey.isNotEmpty) {
      query = query.where('category_id', isEqualTo: categoryKey);
    }

    if (type != null && type != 'all') {
      query = query.where('type', isEqualTo: type);
    }

    return query.orderBy('transaction_date', descending: true);
  }

  Query<Map<String, dynamic>> _buildSummaryQuery(
    String userId, {
    DateTime? month,
    DateTime? date,
    String? categoryKey,
    String? type,
  }) {
    return _buildFilteredTransactionQuery(
      userId,
      month: month,
      date: date,
      categoryKey: categoryKey,
      type: type,
    );
  }

  TransactionModel _mapTransaction(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final inferredUserId = doc.reference.parent.parent?.id ?? '';
    return TransactionModel.fromFirestore({
      ...data,
      if ((data['transaction_id'] as String?) == null ||
          (data['transaction_id'] as String).isEmpty)
        'transaction_id': doc.id,
      if ((data['user_id'] as String?) == null ||
          (data['user_id'] as String).isEmpty)
        'user_id': inferredUserId,
    });
  }

  TransactionSummary _sumTransactions(Iterable<TransactionModel> transactions) {
    double totalIncome = 0;
    double totalExpense = 0;

    for (final transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    return (totalIncome: totalIncome, totalExpense: totalExpense);
  }

  ({DateTime start, DateTime end}) _dayRange(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    return (start: start, end: end);
  }

  ({DateTime start, DateTime end}) _monthRange(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59, 999);
    return (start: start, end: end);
  }

  Future<void> _cleanupUploadedEvidence(String storagePath) async {
    try {
      await _evidenceStorage.deleteEvidenceImage(storagePath);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to clean up uploaded evidence after error.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<(String recipientName, DateTime transactionDate)> _resolveOcrMetadata(
    TransactionEvidenceUploadPayload payload,
  ) async {
    if (payload.filePath == null) {
      return ('unknown', DateTime.now());
    }
    try {
      final result = await _ocrService.extractFromImage(filePath: payload.filePath!);
      return (
        result?.merchantName ?? 'unknown',
        result?.transactionDate ?? DateTime.now(),
      );
    } catch (error, stackTrace) {
      _logger.w(
        'OCR failed for evidence image; using fallback metadata.',
        error: error,
        stackTrace: stackTrace,
      );
      return ('unknown', DateTime.now());
    }
  }

  String transactionToDebugKeys(
    TransactionModel transaction,
    TransactionEvidenceImage? uploadedEvidenceImage,
  ) {
    final payload = transaction
        .copyWith(
          evidenceImage: uploadedEvidenceImage ?? transaction.evidenceImage,
        )
        .toFirestore();
    return payload.keys.join(',');
  }
}

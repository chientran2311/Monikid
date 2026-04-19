import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_evidence_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  return getIt<TransactionRepository>();
}

typedef TransactionSummary = ({double totalIncome, double totalExpense});
typedef TransactionMonthRecord = ({List<TransactionModel> transactions, DateTime month});

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

  Future<void> deleteTransaction(String userId, String transactionId);

  Future<String?> getEvidenceDownloadUrl(TransactionEvidenceImage? evidenceImage);

  Future<TransactionModel?> getTransactionById(
    String userId,
    String transactionId,
  );

  Stream<TransactionMonthRecord> getTransactionsByMonth(
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
  );

  final FirebaseFirestore _firestore;
  final TransactionEvidenceStorage _evidenceStorage;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> _transactionsOfUser(String userId) {
    return _firestore.collection('users').doc(userId).collection('transactions');
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
        uploadedEvidenceImage = await _evidenceStorage
            .uploadEvidenceImage(
              userId: transaction.userId,
              transactionId: transaction.transactionId,
              payload: evidenceUpload,
            )
            .timeout(uploadTimeout);
      }

      final transactionToSave = transaction.copyWith(
        updatedAt: transaction.updatedAt ?? DateTime.now(),
        evidenceImage: uploadedEvidenceImage ?? transaction.evidenceImage,
      );

      _logger.i('Adding transaction ${transaction.transactionId}.');
      await _transactionsOfUser(transaction.userId)
          .doc(transaction.transactionId)
          .set(transactionToSave.toFirestore());
      return transactionToSave;
    } catch (error, stackTrace) {
      if (uploadedEvidenceImage != null) {
        await _cleanupUploadedEvidence(uploadedEvidenceImage.storagePath);
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
        uploadedEvidenceImage = await _evidenceStorage
            .uploadEvidenceImage(
              userId: transaction.userId,
              transactionId: transaction.transactionId,
              payload: newEvidenceUpload,
            )
            .timeout(uploadTimeout);
      }

      final updatedTransaction = transaction.copyWith(
        updatedAt: DateTime.now(),
        evidenceImage: uploadedEvidenceImage ??
            (removeExistingEvidence ? null : transaction.evidenceImage),
      );
      _logger.i('Updating transaction ${transaction.transactionId}.');
      await _transactionsOfUser(transaction.userId)
          .doc(transaction.transactionId)
          .update(updatedTransaction.toFirestore());

      if (uploadedEvidenceImage != null &&
          previousEvidenceImage != null &&
          previousEvidenceImage.storagePath != uploadedEvidenceImage.storagePath) {
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
  Future<void> deleteTransaction(String userId, String transactionId) async {
    try {
      _logger.i('Deleting transaction $transactionId.');
      final existingTransaction = await getTransactionById(userId, transactionId);
      await _transactionsOfUser(userId).doc(transactionId).delete();
      if (existingTransaction?.evidenceImage != null) {
        await _cleanupUploadedEvidence(
          existingTransaction!.evidenceImage!.storagePath,
        );
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to delete transaction.',
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
        'Failed to get evidence download url.',
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
      final snapshot = await _transactionsOfUser(userId).doc(transactionId).get();
      final data = snapshot.data();
      if (!snapshot.exists || data == null) {
        return null;
      }

      return TransactionModel.fromFirestore({
        ...data,
        'transaction_id': data['transaction_id'] ?? snapshot.id,
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
  Stream<TransactionMonthRecord> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  }) {
    final range = _monthRange(month);

    Query<Map<String, dynamic>> query = _transactionsOfUser(userId)
        .where(
          'date_ts',
          isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
        )
        .where(
          'date_ts',
          isLessThanOrEqualTo: Timestamp.fromDate(range.end),
        )
        .orderBy('date_ts', descending: true);

    if (type != null && type != 'all') {
      query = query.where('type', isEqualTo: type);
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      final transactions = snapshot.docs.map(_mapTransaction).toList();
      return (transactions: transactions, month: month);
    }).handleError((error, stackTrace) {
      _logger.e(
        'Failed to listen transactions by month.',
        error: error,
        stackTrace: stackTrace,
      );
      throw error;
    });
  }

  @override
  Future<List<TransactionModel>?> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 6,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _transactionsOfUser(userId)
          .orderBy('date_ts', descending: true)
          .limit(limit);

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
      _logger.e(
        'Failed to get summary.',
        error: error,
        stackTrace: stackTrace,
      );
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
    )
        .snapshots()
        .map((snapshot) => _sumTransactions(snapshot.docs.map(_mapTransaction)));
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
            'date_ts',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where(
            'date_ts',
            isLessThanOrEqualTo: Timestamp.fromDate(range.end),
          );
    } else {
      final range = _monthRange(month ?? DateTime.now());
      query = query
          .where(
            'date_ts',
            isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
          )
          .where(
            'date_ts',
            isLessThanOrEqualTo: Timestamp.fromDate(range.end),
          );
    }

    if (categoryKey != null && categoryKey.isNotEmpty) {
      query = query.where('category_key', isEqualTo: categoryKey);
    }

    if (type != null && type != 'all') {
      query = query.where('type', isEqualTo: type);
    }

    return query.orderBy('date_ts', descending: true);
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
    return TransactionModel.fromFirestore({
      ...data,
      if ((data['transaction_id'] as String?) == null ||
          (data['transaction_id'] as String).isEmpty)
        'transaction_id': doc.id,
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
        'Evidence cleanup failed for $storagePath.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

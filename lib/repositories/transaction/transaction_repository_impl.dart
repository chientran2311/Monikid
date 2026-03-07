import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'transaction_repository.dart';
import 'package:monikid/models/entities/transaction_model.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  TransactionRepositoryImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _transactions =>
      _firestore.collection('transactions');

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      _logger.i('➕ Adding transaction: ${transaction.transactionId}');
      await _transactions
          .doc(transaction.transactionId)
          .set(transaction.toJson());
      _logger.i('✅ Transaction added successfully');
    } catch (e) {
      _logger.e('❌ Error adding transaction: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      _logger.i('🔄 Updating transaction: ${transaction.transactionId}');
      // Update updatedAt timestamp
      final updatedTx = transaction.copyWith(updatedAt: DateTime.now());
      await _transactions
          .doc(transaction.transactionId)
          .update(updatedTx.toJson());
      _logger.i('✅ Transaction updated successfully');
    } catch (e) {
      _logger.e('❌ Error updating transaction: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      _logger.i('🗑️ Deleting transaction: $transactionId');
      await _transactions.doc(transactionId).delete();
      _logger.i('✅ Transaction deleted successfully');
    } catch (e) {
      _logger.e('❌ Error deleting transaction: $e');
      rethrow;
    }
  }

  @override
  Stream<({List<TransactionModel> transactions, DateTime month})> getTransactionsByMonth(
    String userId,
    DateTime month, {
    int? limit,
    String? type,
  }) {
    _logger.i(
      '📡 Listening to transactions for user: $userId in month: ${month.month}/${month.year} | type: $type',
    );

    // Calculate start and end of the month
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(
      month.year,
      month.month + 1,
      0,
      23,
      59,
      59,
      999,
    );

    var query = _transactions
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: startOfMonth.toIso8601String())
        .where('date', isLessThanOrEqualTo: endOfMonth.toIso8601String());

    if (type != null && type != 'all') {
      query = query.where('type', isEqualTo: type);
    }

    query = query.orderBy('date', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().handleError((error) {
      _logger.i('❌ Error listening to transactions (Missing Index?):\n$error');
      throw error;
    }).map((snapshot) {
      final txs = snapshot.docs.map((doc) {
        return TransactionModel.fromJson(doc.data());
      }).toList();
      return (transactions: txs, month: month);
    });
  }

  @override
  Future<List<TransactionModel>> getRecentTransactionsPaginated(
    String userId, {
    TransactionModel? lastTransaction,
    int limit = 4,
  }) async {
    _logger.i('Fetching paginated transactions for user: $userId');
    var query = _transactions
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .limit(limit);

    if (lastTransaction != null) {
      try {
        final lastDocSnapshot = await _transactions
            .doc(lastTransaction.transactionId)
            .get();
        if (lastDocSnapshot.exists) {
          query = query.startAfterDocument(lastDocSnapshot);
        }
      } catch (e) {
        _logger.e('Failed to fetch last document for pagination: $e');
      }
    }

    try {
      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      _logger.i('❌ Error fetching paginated transactions: $e');
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByFilter(
    String userId, {
    DateTime? date,
    String? category,
    String? type,
    TransactionModel? lastTransaction,
    int limit = 8,
  }) async {
    try {
      _logger.i(
        '📊 Fetching transactions for $userId | date: ${date?.day}/${date?.month}/${date?.year} | category: $category | type: $type',
      );

      var query = _transactions
          .where('userId', isEqualTo: userId);

      if (date != null) {
        final startOfDay = DateTime(
          date.year,
          date.month,
          date.day,
        ).toIso8601String();
        final endOfDay = DateTime(
          date.year,
          date.month,
          date.day,
          23,
          59,
          59,
          999,
        ).toIso8601String();

        query = query
            .where('date', isGreaterThanOrEqualTo: startOfDay)
            .where('date', isLessThanOrEqualTo: endOfDay);
      }

      // Optional category filter
      if (category != null && category.isNotEmpty) {
         query = query.where('category', isEqualTo: category);
      }

      // Optional type filter
      if (type != null && type != 'all') {
         query = query.where('type', isEqualTo: type);
      }

      query = query.orderBy('date', descending: true).limit(limit);

      // Cursor-based pagination
      if (lastTransaction != null) {
        try {
          final lastDoc = await _transactions
              .doc(lastTransaction.transactionId)
              .get();
          if (lastDoc.exists) {
            query = query.startAfterDocument(lastDoc);
          }
        } catch (e) {
          _logger.e('Failed to fetch cursor document: $e');
        }
      }

      final snapshot = await query.get();
      final results = snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
      _logger.i('✅ Fetched ${results.length} transactions');
      return results;
    } catch (e) {
      _logger.e('❌ getTransactionsByFilter failed: $e');
      rethrow;
    }
  }

  @override
  Future<({double totalIncome, double totalExpense})> getSummary(
    String userId, {
    DateTime? month,
    DateTime? date,
  }) async {
    try {
      _logger.i('📊 getSummary: $userId | ${date?.day}/${date?.month}/${date?.year} or ${month?.month}/${month?.year}');

      var query = _transactions.where('userId', isEqualTo: userId);

      if (date != null) {
        final startOfDay = DateTime(date.year, date.month, date.day).toIso8601String();
        final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999).toIso8601String();
        query = query.where('date', isGreaterThanOrEqualTo: startOfDay)
                     .where('date', isLessThanOrEqualTo: endOfDay);
      } else if (month != null) {
        final startOfMonth = DateTime(month.year, month.month, 1).toIso8601String();
        final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59, 999).toIso8601String();
        query = query.where('date', isGreaterThanOrEqualTo: startOfMonth)
                     .where('date', isLessThanOrEqualTo: endOfMonth);
      }

      final snapshot = await query.get();

      double totalIncome = 0;
      double totalExpense = 0;

      for (final doc in snapshot.docs) {
        final tx = TransactionModel.fromJson(doc.data());
        if (tx.type == 'income') {
          totalIncome += tx.amount;
        } else {
          totalExpense += tx.amount;
        }
      }

      _logger.i('✅ Summary: income=$totalIncome, expense=$totalExpense');
      return (totalIncome: totalIncome, totalExpense: totalExpense);
    } catch (e) {
      _logger.e('❌ getSummary failed: $e');
      rethrow;
    }
  }
}

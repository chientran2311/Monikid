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
  Stream<List<TransactionModel>> getTransactions(String userId) {
    _logger.i('📡 Listening to transactions for user: $userId');
    return _transactions
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TransactionModel.fromJson(doc.data());
          }).toList();
        });
  }

  @override
  Stream<List<TransactionModel>> getTransactionsByMonth(
    String userId,
    DateTime month,
  ) {
    _logger.i(
      '📡 Listening to transactions for user: $userId in month: ${month.month}/${month.year}',
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

    return _transactions
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TransactionModel.fromJson(doc.data());
          }).toList();
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

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => TransactionModel.fromJson(doc.data()))
        .toList();
  }
}

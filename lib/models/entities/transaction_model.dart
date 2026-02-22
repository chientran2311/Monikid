import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType { income, expense }

enum TransactionSource { manual, ocr }

class TransactionModel {
  final String transactionId;
  final String userId;
  final double amount;
  final TransactionType type;
  final String category; // food | transport | study | ...
  final String note;
  final TransactionSource source;
  final String? receiptImageUrl;
  final DateTime date;
  final DateTime createdAt;

  const TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    required this.note,
    required this.source,
    this.receiptImageUrl,
    required this.date,
    required this.createdAt,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      transactionId: doc.id,
      userId: d['userId'] ?? '',
      amount: (d['amount'] as num).toDouble(),
      type: d['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      category: d['category'] ?? 'other',
      note: d['note'] ?? '',
      source: d['source'] == 'ocr'
          ? TransactionSource.ocr
          : TransactionSource.manual,
      receiptImageUrl: d['receiptImageUrl'],
      date: (d['date'] as Timestamp).toDate(),
      createdAt: (d['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'amount': amount,
    'type': type.name,
    'category': category,
    'note': note,
    'source': source.name,
    'receiptImageUrl': receiptImageUrl,
    'date': Timestamp.fromDate(date),
    'createdAt': Timestamp.fromDate(createdAt),
  };

  bool get isExpense => type == TransactionType.expense;
  bool get isIncome => type == TransactionType.income;
  bool get hasReceipt => receiptImageUrl != null;
  bool get isOcr => source == TransactionSource.ocr;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

/// Chuyển đổi Timestamp của Firestore sang DateTime của Dart
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    if (timestamp == null) return null;
    return timestamp.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String transactionId,
    required String userId,
    required double amount,

    /// 'expense' or 'income'
    required String type,

    required String category,
    String? categoryEmoji,

    String? note,
    String? source,
    String? paymentMethod,
    String? receiptImageUrl,

    @TimestampConverter() required DateTime date,

    @TimestampConverter() DateTime? createdAt,

    @TimestampConverter() DateTime? updatedAt,

    String? location,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  factory TransactionModel.fromFirestore(Map<String, dynamic> json) {
    final transactionId = (json['transactionId'] ?? json['id'] ?? '') as String;

    return TransactionModel(
      transactionId: transactionId,
      userId: (json['userId'] ?? '') as String,
      amount: _parseAmount(json['amount']),
      type: (json['type'] ?? 'expense') as String,
      category: (json['category'] ?? 'Khac') as String,
      categoryEmoji: json['categoryEmoji'] as String?,
      note: json['note'] as String?,
      source: json['source'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      receiptImageUrl: json['receiptImageUrl'] as String?,
      date: _parseDate(json['dateTs'] ?? json['date']) ?? DateTime.now(),
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      location: json['location'] as String?,
    );
  }

  const TransactionModel._();

  Map<String, dynamic> toFirestore() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'amount': amount,
      'type': type,
      'category': category,
      'categoryEmoji': categoryEmoji,
      'note': note,
      'source': source,
      'paymentMethod': paymentMethod,
      'receiptImageUrl': receiptImageUrl,
      'date': date.toIso8601String(),
      'dateTs': Timestamp.fromDate(date),
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'location': location,
    };
  }
}

double _parseAmount(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

DateTime? _parseDate(Object? value) {
  if (value == null) {
    return null;
  }
  if (value is Timestamp) {
    return value.toDate();
  }
  if (value is DateTime) {
    return value;
  }
  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value);
  }
  return null;
}

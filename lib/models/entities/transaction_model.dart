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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    if (timestamp == null) {
      return null;
    }
    return timestamp.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) {
    if (date == null) {
      return null;
    }
    return Timestamp.fromDate(date);
  }
}

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String transactionId,
    required String userId,
    String? familyId,
    required int amountMinor,
    @Default('VND') String currency,
    required String type,
    required String categoryKey,
    required String categoryLabel,
    String? categoryIcon,
    String? note,
    String? source,
    String? merchantName,
    String? paymentMethod,
    @TimestampConverter() required DateTime dateTs,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    bool? ocrUsed,
    double? ocrConfidence,
  }) = _TransactionModel;

  const TransactionModel._();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  factory TransactionModel.fromFirestore(Map<String, dynamic> json) {
    final transactionId = _readString(
      json,
      snakeKey: 'transaction_id',
      camelKey: 'transactionId',
      fallbackKey: 'id',
    );
    final amountMinor = _readAmountMinor(json);

    final ocrMeta = json['ocr_meta'];
    final ocrData = ocrMeta is Map<String, dynamic> ? ocrMeta : null;

    return TransactionModel(
      transactionId: transactionId,
      userId: _readString(json, snakeKey: 'user_id', camelKey: 'userId'),
      familyId: _readNullableString(
        json,
        snakeKey: 'family_id',
        camelKey: 'familyId',
      ),
      amountMinor: amountMinor,
      currency:
          _readNullableString(json, snakeKey: 'currency', camelKey: 'currency') ??
          'VND',
      type: _readString(json, snakeKey: 'type', camelKey: 'type'),
      categoryKey: _readString(
        json,
        snakeKey: 'category_key',
        camelKey: 'categoryKey',
        fallbackKey: 'category',
      ),
      categoryLabel: _readString(
        json,
        snakeKey: 'category_label',
        camelKey: 'categoryLabel',
        fallbackKey: 'category',
      ),
      categoryIcon: _readNullableString(
        json,
        snakeKey: 'category_icon',
        camelKey: 'categoryIcon',
        fallbackKey: 'categoryEmoji',
      ),
      note: _readNullableString(json, snakeKey: 'note', camelKey: 'note'),
      source: _readNullableString(json, snakeKey: 'source', camelKey: 'source'),
      merchantName: _readNullableString(
        json,
        snakeKey: 'merchant_name',
        camelKey: 'merchantName',
      ),
      paymentMethod: _readNullableString(
        json,
        snakeKey: 'payment_method',
        camelKey: 'paymentMethod',
      ),
      dateTs:
          _parseDate(json['date_ts'] ?? json['dateTs'] ?? json['date']) ??
          DateTime.now(),
      createdAt: _parseDate(json['created_at'] ?? json['createdAt']),
      updatedAt: _parseDate(json['updated_at'] ?? json['updatedAt']),
      ocrUsed: _parseBool(ocrData?['used']),
      ocrConfidence: _parseDouble(ocrData?['confidence']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'transaction_id': transactionId,
      'user_id': userId,
      'family_id': familyId,
      'type': type,
      'amount_minor': amountMinor,
      'currency': currency,
      'category_key': categoryKey,
      'category_label': categoryLabel,
      'category_icon': categoryIcon,
      'note': note,
      'source': source,
      'merchant_name': merchantName ?? '',
      'payment_method': paymentMethod,
      'date_ts': Timestamp.fromDate(dateTs),
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'ocr_meta': {
        'used': ocrUsed ?? false,
        'confidence': ocrConfidence,
      },
    };
  }

  double get amount => amountMinor.toDouble();
  String get category => categoryLabel;
  String? get categoryEmoji => categoryIcon;
  DateTime get date => dateTs;
  String? get location => merchantName;

  TransactionModel copyWithUi({
    double? amount,
    String? type,
    String? categoryLabel,
    String? categoryIcon,
    DateTime? date,
    String? note,
  }) {
    return copyWith(
      amountMinor: amount != null ? amount.round() : amountMinor,
      type: type ?? this.type,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      categoryKey:
          categoryLabel != null && categoryLabel != this.categoryLabel
              ? _slugifyCategory(categoryLabel)
              : categoryKey,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      dateTs: date ?? dateTs,
      note: note,
    );
  }
}

String _readString(
  Map<String, dynamic> json, {
  required String snakeKey,
  required String camelKey,
  String? fallbackKey,
}) {
  final value =
      json[snakeKey] ?? json[camelKey] ?? (fallbackKey != null ? json[fallbackKey] : null);
  if (value is String) {
    return value.trim();
  }
  return '';
}

String? _readNullableString(
  Map<String, dynamic> json, {
  required String snakeKey,
  required String camelKey,
  String? fallbackKey,
}) {
  final value =
      json[snakeKey] ?? json[camelKey] ?? (fallbackKey != null ? json[fallbackKey] : null);
  if (value is String) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
  return null;
}

int _readAmountMinor(Map<String, dynamic> json) {
  final amountMinor = json['amount_minor'];
  if (amountMinor is num) {
    return amountMinor.round();
  }

  final amount = json['amount'];
  if (amount is num) {
    return amount.round();
  }
  if (amount is String) {
    return double.tryParse(amount)?.round() ?? 0;
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

bool? _parseBool(Object? value) {
  if (value is bool) {
    return value;
  }
  return null;
}

double? _parseDouble(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  return null;
}

String _slugifyCategory(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');
}

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
abstract class TransactionEvidenceImage with _$TransactionEvidenceImage {
  const factory TransactionEvidenceImage({
    required String storagePath,
    String? fileName,
    String? mimeType,
    @TimestampConverter() DateTime? uploadedAt,
  }) = _TransactionEvidenceImage;

  const TransactionEvidenceImage._();

  factory TransactionEvidenceImage.fromJson(Map<String, dynamic> json) =>
      _$TransactionEvidenceImageFromJson(json);

  factory TransactionEvidenceImage.fromFirestore(Map<String, dynamic> json) {
    return TransactionEvidenceImage(
      // Reads new key (image_url) with fallback to legacy (storage_path).
      storagePath: _readString(
        json,
        snakeKey: 'image_url',
        camelKey: 'imageUrl',
        fallbackKey: 'storage_path',
      ),
      fileName: _readNullableString(
        json,
        snakeKey: 'image_name',
        camelKey: 'imageName',
      ),
      mimeType: _readNullableString(
        json,
        snakeKey: 'image_type',
        camelKey: 'imageType',
      ),
      uploadedAt: _parseDate(json['uploaded_at'] ?? json['uploadedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'image_url': storagePath,
      'image_name': fileName,
      'image_type': mimeType,
      'uploaded_at': uploadedAt != null
          ? Timestamp.fromDate(uploadedAt!)
          : null,
    };
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
    @TimestampConverter() required DateTime dateTs,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    bool? ocrUsed,
    double? ocrConfidence,
    TransactionEvidenceImage? evidenceImage,
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
    final evidenceImage = json['evidence_image'];
    final evidenceData = evidenceImage is Map<String, dynamic>
        ? evidenceImage
        : null;

    return TransactionModel(
      transactionId: transactionId,
      userId: _readString(json, snakeKey: 'user_id', camelKey: 'userId'),
      familyId: _readNullableString(
        json,
        snakeKey: 'family_id',
        camelKey: 'familyId',
      ),
      amountMinor: amountMinor,
      currency: 'VND',
      type: _readString(json, snakeKey: 'type', camelKey: 'type'),
      // Reads both new key (category_id) and legacy key (category_key).
      categoryKey: _readString(
        json,
        snakeKey: 'category_id',
        camelKey: 'categoryId',
        fallbackKey: 'category_key',
      ),
      categoryLabel: _readString(
        json,
        snakeKey: 'category_label',
        camelKey: 'categoryLabel',
        fallbackKey: 'category',
      ),
      // category_icon removed from writes; kept in reads for legacy data.
      categoryIcon: _readNullableString(
        json,
        snakeKey: 'category_icon',
        camelKey: 'categoryIcon',
        fallbackKey: 'categoryEmoji',
      ),
      note: _readNullableString(json, snakeKey: 'note', camelKey: 'note'),
      source: _readNullableString(json, snakeKey: 'source', camelKey: 'source'),
      // Reads both new key (merchant) and legacy key (merchant_name).
      merchantName: _readNullableString(
        json,
        snakeKey: 'merchant',
        camelKey: 'merchant',
        fallbackKey: 'merchant_name',
      ),
      // Reads both new key (transaction_date) and legacy key (date_ts).
      dateTs:
          _parseDate(json['transaction_date'] ?? json['date_ts'] ?? json['dateTs'] ?? json['date']) ??
          DateTime.now(),
      createdAt: _parseDate(json['created_at'] ?? json['createdAt']),
      updatedAt: _parseDate(json['updated_at'] ?? json['updatedAt']),
      ocrUsed: _parseBool(ocrData?['used']),
      ocrConfidence: _parseDouble(ocrData?['confidence']),
      evidenceImage: evidenceData == null
          ? null
          : TransactionEvidenceImage.fromFirestore(evidenceData),
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{
      'transaction_id': transactionId,
      'type': type,
      'amount': amountMinor,
      'category_id': categoryKey,
      'note': note,
      'transaction_date': Timestamp.fromDate(dateTs),
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };

    if (evidenceImage != null) {
      data['evidence_image'] = evidenceImage!.toFirestore();
    }

    return data;
  }

  double get amount => amountMinor.toDouble();
  String get category => categoryLabel;
  String? get categoryEmoji => categoryIcon;
  DateTime get date => dateTs;
  String? get location => merchantName;
  bool get hasEvidenceImage =>
      evidenceImage != null && evidenceImage!.storagePath.isNotEmpty;

  TransactionModel copyWithUi({
    double? amount,
    String? type,
    String? categoryId,
    String? categoryLabel,
    String? categoryIcon,
    DateTime? date,
    String? note,
  }) {
    return copyWith(
      amountMinor: amount != null ? amount.round() : amountMinor,
      type: type ?? this.type,
      // categoryKey (stored as category_id in Firestore) must be set explicitly;
      // it is never derived from the label to preserve FK stability.
      categoryKey: categoryId ?? categoryKey,
      categoryLabel: categoryLabel ?? this.categoryLabel,
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
      json[snakeKey] ??
      json[camelKey] ??
      (fallbackKey != null ? json[fallbackKey] : null);
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
      json[snakeKey] ??
      json[camelKey] ??
      (fallbackKey != null ? json[fallbackKey] : null);
  if (value is String) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
  return null;
}

int _readAmountMinor(Map<String, dynamic> json) {
  // Reads new key (amount) first, falls back to legacy (amount_minor).
  final amount = json['amount'] ?? json['amount_minor'];
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


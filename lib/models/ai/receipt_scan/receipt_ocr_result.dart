import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_ocr_result.freezed.dart';
part 'receipt_ocr_result.g.dart';

@freezed
abstract class ReceiptOcrResult with _$ReceiptOcrResult {
  const factory ReceiptOcrResult({
    required String rawText,
    int? amountMinor,
    DateTime? transactionDate,
    String? merchantName,
    double? confidence,
  }) = _ReceiptOcrResult;

  factory ReceiptOcrResult.fromJson(Map<String, dynamic> json) =>
      _$ReceiptOcrResultFromJson(json);
}

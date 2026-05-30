import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_convention_hint.dart';

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
    String? senderName,
    String? recipientName,
    String? description,
    ReceiptConventionHint? conventionHint,
  }) = _ReceiptOcrResult;

  factory ReceiptOcrResult.fromJson(Map<String, dynamic> json) =>
      _$ReceiptOcrResultFromJson(json);
}

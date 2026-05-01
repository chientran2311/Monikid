// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_ai_result.freezed.dart';
part 'transaction_ai_result.g.dart';

@freezed
abstract class TransactionAiResult with _$TransactionAiResult {
  const factory TransactionAiResult({
    @JsonKey(name: 'amount_minor') required int amountMinor,
    @JsonKey(name: 'category') required String categoryKey,
    @JsonKey(name: 'description') required String note,
    @JsonKey(name: 'transaction_date') required String transactionDate,
  }) = _TransactionAiResult;

  factory TransactionAiResult.fromJson(Map<String, dynamic> json) =>
      _$TransactionAiResultFromJson(json);
}

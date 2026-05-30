import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_convention_hint.freezed.dart';
part 'receipt_convention_hint.g.dart';

@freezed
abstract class ReceiptConventionHint with _$ReceiptConventionHint {
  const factory ReceiptConventionHint({
    String? purpose,
    String? merchant,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'category_hint') String? categoryHint,
  }) = _ReceiptConventionHint;

  factory ReceiptConventionHint.fromJson(Map<String, dynamic> json) =>
      _$ReceiptConventionHintFromJson(json);
}

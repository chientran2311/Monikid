import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_category_option.freezed.dart';
part 'receipt_category_option.g.dart';

@freezed
abstract class ReceiptCategoryOption with _$ReceiptCategoryOption {
  const factory ReceiptCategoryOption({
    required String key,
    required String label,
    required String type,
  }) = _ReceiptCategoryOption;

  factory ReceiptCategoryOption.fromJson(Map<String, dynamic> json) =>
      _$ReceiptCategoryOptionFromJson(json);
}

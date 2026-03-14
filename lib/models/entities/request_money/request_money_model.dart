import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_money_model.freezed.dart';
part 'request_money_model.g.dart';

@freezed
class RequestMoneyModel with _$RequestMoneyModel {
  const factory RequestMoneyModel({
    required String id,
    required double amount,
    required String category,
    String? note,
    required List<String> recipients,
    required String status,
    required DateTime createdAt,
    required String familyCode,
    required String studentId,
  }) = _RequestMoneyModel;

  factory RequestMoneyModel.fromJson(Map<String, dynamic> json) =>
      _$RequestMoneyModelFromJson(json);
}

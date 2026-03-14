import 'package:freezed_annotation/freezed_annotation.dart';

part 'fqa_model.freezed.dart';
part 'fqa_model.g.dart';

@freezed
class FQAModel with _$FQAModel {
  const factory FQAModel({
    required String id,
    required String question,
    required String answer,
    @Default(0) int orderIndex,
  }) = _FQAModel;

  factory FQAModel.fromJson(Map<String, dynamic> json) =>
      _$FQAModelFromJson(json);
}

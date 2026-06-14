import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String label,
    required String icon,
    @Default('expense') String type,
    String? colorHex,
    @Default(false) bool isDefault,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return CategoryModel.fromJson({...data, 'id': doc.id});
  }
}

extension CategoryModelX on CategoryModel {
  Map<String, dynamic> toFirestore() => {
    'category_id': id,
    'label': label,
    'icon': icon,
    'type': type,
    'created_at': Timestamp.now(),
  };
}

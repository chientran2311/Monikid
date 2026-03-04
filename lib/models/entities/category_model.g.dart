// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: json['id'] as String,
      label: json['label'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String? ?? 'expense',
      colorHex: json['colorHex'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'icon': instance.icon,
      'type': instance.type,
      'colorHex': instance.colorHex,
      'isDefault': instance.isDefault,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostDataWrapper _$PostDataWrapperFromJson(Map<String, dynamic> json) =>
    _PostDataWrapper(
      items:
          (json['data'] as List<dynamic>?)
              ?.map((e) => PostResponseItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PostDataWrapperToJson(_PostDataWrapper instance) =>
    <String, dynamic>{'data': instance.items};

_PostResponseItem _$PostResponseItemFromJson(Map<String, dynamic> json) =>
    _PostResponseItem(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$PostResponseItemToJson(_PostResponseItem instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };

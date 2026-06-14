// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FAQModel {

 String get id; String get question; String get answer;
/// Create a copy of FAQModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FAQModelCopyWith<FAQModel> get copyWith => _$FAQModelCopyWithImpl<FAQModel>(this as FAQModel, _$identity);

  /// Serializes this FAQModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FAQModel&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer);

@override
String toString() {
  return 'FAQModel(id: $id, question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $FAQModelCopyWith<$Res>  {
  factory $FAQModelCopyWith(FAQModel value, $Res Function(FAQModel) _then) = _$FAQModelCopyWithImpl;
@useResult
$Res call({
 String id, String question, String answer
});




}
/// @nodoc
class _$FAQModelCopyWithImpl<$Res>
    implements $FAQModelCopyWith<$Res> {
  _$FAQModelCopyWithImpl(this._self, this._then);

  final FAQModel _self;
  final $Res Function(FAQModel) _then;

/// Create a copy of FAQModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? answer = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FAQModel implements FAQModel {
  const _FAQModel({required this.id, required this.question, required this.answer});
  factory _FAQModel.fromJson(Map<String, dynamic> json) => _$FAQModelFromJson(json);

@override final  String id;
@override final  String question;
@override final  String answer;

/// Create a copy of FAQModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FAQModelCopyWith<_FAQModel> get copyWith => __$FAQModelCopyWithImpl<_FAQModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FAQModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FAQModel&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer);

@override
String toString() {
  return 'FAQModel(id: $id, question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$FAQModelCopyWith<$Res> implements $FAQModelCopyWith<$Res> {
  factory _$FAQModelCopyWith(_FAQModel value, $Res Function(_FAQModel) _then) = __$FAQModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String question, String answer
});




}
/// @nodoc
class __$FAQModelCopyWithImpl<$Res>
    implements _$FAQModelCopyWith<$Res> {
  __$FAQModelCopyWithImpl(this._self, this._then);

  final _FAQModel _self;
  final $Res Function(_FAQModel) _then;

/// Create a copy of FAQModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? answer = null,}) {
  return _then(_FAQModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

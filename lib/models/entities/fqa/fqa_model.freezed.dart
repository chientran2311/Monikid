// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fqa_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FQAModel {

 String get id; String get question; String get answer; int get orderIndex;
/// Create a copy of FQAModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FQAModelCopyWith<FQAModel> get copyWith => _$FQAModelCopyWithImpl<FQAModel>(this as FQAModel, _$identity);

  /// Serializes this FQAModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FQAModel&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer,orderIndex);

@override
String toString() {
  return 'FQAModel(id: $id, question: $question, answer: $answer, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class $FQAModelCopyWith<$Res>  {
  factory $FQAModelCopyWith(FQAModel value, $Res Function(FQAModel) _then) = _$FQAModelCopyWithImpl;
@useResult
$Res call({
 String id, String question, String answer, int orderIndex
});




}
/// @nodoc
class _$FQAModelCopyWithImpl<$Res>
    implements $FQAModelCopyWith<$Res> {
  _$FQAModelCopyWithImpl(this._self, this._then);

  final FQAModel _self;
  final $Res Function(FQAModel) _then;

/// Create a copy of FQAModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? answer = null,Object? orderIndex = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FQAModel implements FQAModel {
  const _FQAModel({required this.id, required this.question, required this.answer, this.orderIndex = 0});
  factory _FQAModel.fromJson(Map<String, dynamic> json) => _$FQAModelFromJson(json);

@override final  String id;
@override final  String question;
@override final  String answer;
@override@JsonKey() final  int orderIndex;

/// Create a copy of FQAModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FQAModelCopyWith<_FQAModel> get copyWith => __$FQAModelCopyWithImpl<_FQAModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FQAModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FQAModel&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,question,answer,orderIndex);

@override
String toString() {
  return 'FQAModel(id: $id, question: $question, answer: $answer, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class _$FQAModelCopyWith<$Res> implements $FQAModelCopyWith<$Res> {
  factory _$FQAModelCopyWith(_FQAModel value, $Res Function(_FQAModel) _then) = __$FQAModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String question, String answer, int orderIndex
});




}
/// @nodoc
class __$FQAModelCopyWithImpl<$Res>
    implements _$FQAModelCopyWith<$Res> {
  __$FQAModelCopyWithImpl(this._self, this._then);

  final _FQAModel _self;
  final $Res Function(_FQAModel) _then;

/// Create a copy of FQAModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? answer = null,Object? orderIndex = null,}) {
  return _then(_FQAModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

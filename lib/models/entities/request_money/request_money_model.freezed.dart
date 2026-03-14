// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_money_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestMoneyModel {

 String get id; double get amount; String get category; String? get note; List<String> get recipients; String get status; DateTime get createdAt; String get familyCode; String get studentId;
/// Create a copy of RequestMoneyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestMoneyModelCopyWith<RequestMoneyModel> get copyWith => _$RequestMoneyModelCopyWithImpl<RequestMoneyModel>(this as RequestMoneyModel, _$identity);

  /// Serializes this RequestMoneyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestMoneyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.recipients, recipients)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.familyCode, familyCode) || other.familyCode == familyCode)&&(identical(other.studentId, studentId) || other.studentId == studentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,category,note,const DeepCollectionEquality().hash(recipients),status,createdAt,familyCode,studentId);

@override
String toString() {
  return 'RequestMoneyModel(id: $id, amount: $amount, category: $category, note: $note, recipients: $recipients, status: $status, createdAt: $createdAt, familyCode: $familyCode, studentId: $studentId)';
}


}

/// @nodoc
abstract mixin class $RequestMoneyModelCopyWith<$Res>  {
  factory $RequestMoneyModelCopyWith(RequestMoneyModel value, $Res Function(RequestMoneyModel) _then) = _$RequestMoneyModelCopyWithImpl;
@useResult
$Res call({
 String id, double amount, String category, String? note, List<String> recipients, String status, DateTime createdAt, String familyCode, String studentId
});




}
/// @nodoc
class _$RequestMoneyModelCopyWithImpl<$Res>
    implements $RequestMoneyModelCopyWith<$Res> {
  _$RequestMoneyModelCopyWithImpl(this._self, this._then);

  final RequestMoneyModel _self;
  final $Res Function(RequestMoneyModel) _then;

/// Create a copy of RequestMoneyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? category = null,Object? note = freezed,Object? recipients = null,Object? status = null,Object? createdAt = null,Object? familyCode = null,Object? studentId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,recipients: null == recipients ? _self.recipients : recipients // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,familyCode: null == familyCode ? _self.familyCode : familyCode // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RequestMoneyModel implements RequestMoneyModel {
  const _RequestMoneyModel({required this.id, required this.amount, required this.category, this.note, required final  List<String> recipients, required this.status, required this.createdAt, required this.familyCode, required this.studentId}): _recipients = recipients;
  factory _RequestMoneyModel.fromJson(Map<String, dynamic> json) => _$RequestMoneyModelFromJson(json);

@override final  String id;
@override final  double amount;
@override final  String category;
@override final  String? note;
 final  List<String> _recipients;
@override List<String> get recipients {
  if (_recipients is EqualUnmodifiableListView) return _recipients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipients);
}

@override final  String status;
@override final  DateTime createdAt;
@override final  String familyCode;
@override final  String studentId;

/// Create a copy of RequestMoneyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestMoneyModelCopyWith<_RequestMoneyModel> get copyWith => __$RequestMoneyModelCopyWithImpl<_RequestMoneyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestMoneyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestMoneyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._recipients, _recipients)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.familyCode, familyCode) || other.familyCode == familyCode)&&(identical(other.studentId, studentId) || other.studentId == studentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,category,note,const DeepCollectionEquality().hash(_recipients),status,createdAt,familyCode,studentId);

@override
String toString() {
  return 'RequestMoneyModel(id: $id, amount: $amount, category: $category, note: $note, recipients: $recipients, status: $status, createdAt: $createdAt, familyCode: $familyCode, studentId: $studentId)';
}


}

/// @nodoc
abstract mixin class _$RequestMoneyModelCopyWith<$Res> implements $RequestMoneyModelCopyWith<$Res> {
  factory _$RequestMoneyModelCopyWith(_RequestMoneyModel value, $Res Function(_RequestMoneyModel) _then) = __$RequestMoneyModelCopyWithImpl;
@override @useResult
$Res call({
 String id, double amount, String category, String? note, List<String> recipients, String status, DateTime createdAt, String familyCode, String studentId
});




}
/// @nodoc
class __$RequestMoneyModelCopyWithImpl<$Res>
    implements _$RequestMoneyModelCopyWith<$Res> {
  __$RequestMoneyModelCopyWithImpl(this._self, this._then);

  final _RequestMoneyModel _self;
  final $Res Function(_RequestMoneyModel) _then;

/// Create a copy of RequestMoneyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? category = null,Object? note = freezed,Object? recipients = null,Object? status = null,Object? createdAt = null,Object? familyCode = null,Object? studentId = null,}) {
  return _then(_RequestMoneyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,recipients: null == recipients ? _self._recipients : recipients // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,familyCode: null == familyCode ? _self.familyCode : familyCode // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

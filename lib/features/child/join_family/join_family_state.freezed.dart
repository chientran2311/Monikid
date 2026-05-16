// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_family_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JoinFamilyState {

 JoinFamilyStatus get status; String? get errorMessage;
/// Create a copy of JoinFamilyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinFamilyStateCopyWith<JoinFamilyState> get copyWith => _$JoinFamilyStateCopyWithImpl<JoinFamilyState>(this as JoinFamilyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinFamilyState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'JoinFamilyState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $JoinFamilyStateCopyWith<$Res>  {
  factory $JoinFamilyStateCopyWith(JoinFamilyState value, $Res Function(JoinFamilyState) _then) = _$JoinFamilyStateCopyWithImpl;
@useResult
$Res call({
 JoinFamilyStatus status, String? errorMessage
});




}
/// @nodoc
class _$JoinFamilyStateCopyWithImpl<$Res>
    implements $JoinFamilyStateCopyWith<$Res> {
  _$JoinFamilyStateCopyWithImpl(this._self, this._then);

  final JoinFamilyState _self;
  final $Res Function(JoinFamilyState) _then;

/// Create a copy of JoinFamilyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JoinFamilyStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _JoinFamilyState extends JoinFamilyState {
  const _JoinFamilyState({this.status = JoinFamilyStatus.initial, this.errorMessage}): super._();
  

@override@JsonKey() final  JoinFamilyStatus status;
@override final  String? errorMessage;

/// Create a copy of JoinFamilyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinFamilyStateCopyWith<_JoinFamilyState> get copyWith => __$JoinFamilyStateCopyWithImpl<_JoinFamilyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinFamilyState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'JoinFamilyState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$JoinFamilyStateCopyWith<$Res> implements $JoinFamilyStateCopyWith<$Res> {
  factory _$JoinFamilyStateCopyWith(_JoinFamilyState value, $Res Function(_JoinFamilyState) _then) = __$JoinFamilyStateCopyWithImpl;
@override @useResult
$Res call({
 JoinFamilyStatus status, String? errorMessage
});




}
/// @nodoc
class __$JoinFamilyStateCopyWithImpl<$Res>
    implements _$JoinFamilyStateCopyWith<$Res> {
  __$JoinFamilyStateCopyWithImpl(this._self, this._then);

  final _JoinFamilyState _self;
  final $Res Function(_JoinFamilyState) _then;

/// Create a copy of JoinFamilyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_JoinFamilyState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JoinFamilyStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

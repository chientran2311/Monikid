// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_new_pin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateNewPINState {

 String get currentPin; String? get draftPinCode; CreateNewPinStatus get status;
/// Create a copy of CreateNewPINState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNewPINStateCopyWith<CreateNewPINState> get copyWith => _$CreateNewPINStateCopyWithImpl<CreateNewPINState>(this as CreateNewPINState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNewPINState&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.draftPinCode, draftPinCode) || other.draftPinCode == draftPinCode)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,currentPin,draftPinCode,status);

@override
String toString() {
  return 'CreateNewPINState(currentPin: $currentPin, draftPinCode: $draftPinCode, status: $status)';
}


}

/// @nodoc
abstract mixin class $CreateNewPINStateCopyWith<$Res>  {
  factory $CreateNewPINStateCopyWith(CreateNewPINState value, $Res Function(CreateNewPINState) _then) = _$CreateNewPINStateCopyWithImpl;
@useResult
$Res call({
 String currentPin, String? draftPinCode, CreateNewPinStatus status
});




}
/// @nodoc
class _$CreateNewPINStateCopyWithImpl<$Res>
    implements $CreateNewPINStateCopyWith<$Res> {
  _$CreateNewPINStateCopyWithImpl(this._self, this._then);

  final CreateNewPINState _self;
  final $Res Function(CreateNewPINState) _then;

/// Create a copy of CreateNewPINState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPin = null,Object? draftPinCode = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,draftPinCode: freezed == draftPinCode ? _self.draftPinCode : draftPinCode // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateNewPinStatus,
  ));
}

}


/// @nodoc


class _CreateNewPINState extends CreateNewPINState {
  const _CreateNewPINState({this.currentPin = '', this.draftPinCode, this.status = CreateNewPinStatus.editing}): super._();
  

@override@JsonKey() final  String currentPin;
@override final  String? draftPinCode;
@override@JsonKey() final  CreateNewPinStatus status;

/// Create a copy of CreateNewPINState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNewPINStateCopyWith<_CreateNewPINState> get copyWith => __$CreateNewPINStateCopyWithImpl<_CreateNewPINState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNewPINState&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.draftPinCode, draftPinCode) || other.draftPinCode == draftPinCode)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,currentPin,draftPinCode,status);

@override
String toString() {
  return 'CreateNewPINState(currentPin: $currentPin, draftPinCode: $draftPinCode, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CreateNewPINStateCopyWith<$Res> implements $CreateNewPINStateCopyWith<$Res> {
  factory _$CreateNewPINStateCopyWith(_CreateNewPINState value, $Res Function(_CreateNewPINState) _then) = __$CreateNewPINStateCopyWithImpl;
@override @useResult
$Res call({
 String currentPin, String? draftPinCode, CreateNewPinStatus status
});




}
/// @nodoc
class __$CreateNewPINStateCopyWithImpl<$Res>
    implements _$CreateNewPINStateCopyWith<$Res> {
  __$CreateNewPINStateCopyWithImpl(this._self, this._then);

  final _CreateNewPINState _self;
  final $Res Function(_CreateNewPINState) _then;

/// Create a copy of CreateNewPINState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPin = null,Object? draftPinCode = freezed,Object? status = null,}) {
  return _then(_CreateNewPINState(
currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,draftPinCode: freezed == draftPinCode ? _self.draftPinCode : draftPinCode // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateNewPinStatus,
  ));
}


}

// dart format on

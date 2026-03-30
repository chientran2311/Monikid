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

 String get pinCode; EnterPINCodeEnum get type; String? get pendingPinCodeHash; bool get isLoading;
/// Create a copy of CreateNewPINState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNewPINStateCopyWith<CreateNewPINState> get copyWith => _$CreateNewPINStateCopyWithImpl<CreateNewPINState>(this as CreateNewPINState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNewPINState&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.type, type) || other.type == type)&&(identical(other.pendingPinCodeHash, pendingPinCodeHash) || other.pendingPinCodeHash == pendingPinCodeHash)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,pinCode,type,pendingPinCodeHash,isLoading);

@override
String toString() {
  return 'CreateNewPINState(pinCode: $pinCode, type: $type, pendingPinCodeHash: $pendingPinCodeHash, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CreateNewPINStateCopyWith<$Res>  {
  factory $CreateNewPINStateCopyWith(CreateNewPINState value, $Res Function(CreateNewPINState) _then) = _$CreateNewPINStateCopyWithImpl;
@useResult
$Res call({
 String pinCode, EnterPINCodeEnum type, String? pendingPinCodeHash, bool isLoading
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
@pragma('vm:prefer-inline') @override $Res call({Object? pinCode = null,Object? type = null,Object? pendingPinCodeHash = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
pinCode: null == pinCode ? _self.pinCode : pinCode // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnterPINCodeEnum,pendingPinCodeHash: freezed == pendingPinCodeHash ? _self.pendingPinCodeHash : pendingPinCodeHash // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _CreateNewPINState extends CreateNewPINState {
  const _CreateNewPINState({required this.pinCode, required this.type, this.pendingPinCodeHash, this.isLoading = false}): super._();
  

@override final  String pinCode;
@override final  EnterPINCodeEnum type;
@override final  String? pendingPinCodeHash;
@override@JsonKey() final  bool isLoading;

/// Create a copy of CreateNewPINState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNewPINStateCopyWith<_CreateNewPINState> get copyWith => __$CreateNewPINStateCopyWithImpl<_CreateNewPINState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNewPINState&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.type, type) || other.type == type)&&(identical(other.pendingPinCodeHash, pendingPinCodeHash) || other.pendingPinCodeHash == pendingPinCodeHash)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,pinCode,type,pendingPinCodeHash,isLoading);

@override
String toString() {
  return 'CreateNewPINState(pinCode: $pinCode, type: $type, pendingPinCodeHash: $pendingPinCodeHash, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CreateNewPINStateCopyWith<$Res> implements $CreateNewPINStateCopyWith<$Res> {
  factory _$CreateNewPINStateCopyWith(_CreateNewPINState value, $Res Function(_CreateNewPINState) _then) = __$CreateNewPINStateCopyWithImpl;
@override @useResult
$Res call({
 String pinCode, EnterPINCodeEnum type, String? pendingPinCodeHash, bool isLoading
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
@override @pragma('vm:prefer-inline') $Res call({Object? pinCode = null,Object? type = null,Object? pendingPinCodeHash = freezed,Object? isLoading = null,}) {
  return _then(_CreateNewPINState(
pinCode: null == pinCode ? _self.pinCode : pinCode // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EnterPINCodeEnum,pendingPinCodeHash: freezed == pendingPinCodeHash ? _self.pendingPinCodeHash : pendingPinCodeHash // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

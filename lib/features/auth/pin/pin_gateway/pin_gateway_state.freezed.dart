// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_gateway_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinGatewayState {

 PinGatewayStatus get status; String? get errorMessage;
/// Create a copy of PinGatewayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinGatewayStateCopyWith<PinGatewayState> get copyWith => _$PinGatewayStateCopyWithImpl<PinGatewayState>(this as PinGatewayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinGatewayState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'PinGatewayState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PinGatewayStateCopyWith<$Res>  {
  factory $PinGatewayStateCopyWith(PinGatewayState value, $Res Function(PinGatewayState) _then) = _$PinGatewayStateCopyWithImpl;
@useResult
$Res call({
 PinGatewayStatus status, String? errorMessage
});




}
/// @nodoc
class _$PinGatewayStateCopyWithImpl<$Res>
    implements $PinGatewayStateCopyWith<$Res> {
  _$PinGatewayStateCopyWithImpl(this._self, this._then);

  final PinGatewayState _self;
  final $Res Function(PinGatewayState) _then;

/// Create a copy of PinGatewayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PinGatewayStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _PinGatewayState extends PinGatewayState {
  const _PinGatewayState({this.status = PinGatewayStatus.initial, this.errorMessage}): super._();
  

@override@JsonKey() final  PinGatewayStatus status;
@override final  String? errorMessage;

/// Create a copy of PinGatewayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinGatewayStateCopyWith<_PinGatewayState> get copyWith => __$PinGatewayStateCopyWithImpl<_PinGatewayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinGatewayState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'PinGatewayState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PinGatewayStateCopyWith<$Res> implements $PinGatewayStateCopyWith<$Res> {
  factory _$PinGatewayStateCopyWith(_PinGatewayState value, $Res Function(_PinGatewayState) _then) = __$PinGatewayStateCopyWithImpl;
@override @useResult
$Res call({
 PinGatewayStatus status, String? errorMessage
});




}
/// @nodoc
class __$PinGatewayStateCopyWithImpl<$Res>
    implements _$PinGatewayStateCopyWith<$Res> {
  __$PinGatewayStateCopyWithImpl(this._self, this._then);

  final _PinGatewayState _self;
  final $Res Function(_PinGatewayState) _then;

/// Create a copy of PinGatewayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_PinGatewayState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PinGatewayStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

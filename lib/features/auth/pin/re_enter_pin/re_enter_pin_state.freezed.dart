// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 're_enter_pin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReEnterPINState {

 String get currentPin; ReEnterPINCodeStatus get status; bool get isLoading; String? get errorMessage;
/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReEnterPINStateCopyWith<ReEnterPINState> get copyWith => _$ReEnterPINStateCopyWithImpl<ReEnterPINState>(this as ReEnterPINState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReEnterPINState&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentPin,status,isLoading,errorMessage);

@override
String toString() {
  return 'ReEnterPINState(currentPin: $currentPin, status: $status, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ReEnterPINStateCopyWith<$Res>  {
  factory $ReEnterPINStateCopyWith(ReEnterPINState value, $Res Function(ReEnterPINState) _then) = _$ReEnterPINStateCopyWithImpl;
@useResult
$Res call({
 String currentPin, ReEnterPINCodeStatus status, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$ReEnterPINStateCopyWithImpl<$Res>
    implements $ReEnterPINStateCopyWith<$Res> {
  _$ReEnterPINStateCopyWithImpl(this._self, this._then);

  final ReEnterPINState _self;
  final $Res Function(ReEnterPINState) _then;

/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReEnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _ReEnterPINState extends ReEnterPINState {
  const _ReEnterPINState({this.currentPin = '', this.status = ReEnterPINCodeStatus.initial, this.isLoading = false, this.errorMessage}): super._();
  

@override@JsonKey() final  String currentPin;
@override@JsonKey() final  ReEnterPINCodeStatus status;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReEnterPINStateCopyWith<_ReEnterPINState> get copyWith => __$ReEnterPINStateCopyWithImpl<_ReEnterPINState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReEnterPINState&&(identical(other.currentPin, currentPin) || other.currentPin == currentPin)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentPin,status,isLoading,errorMessage);

@override
String toString() {
  return 'ReEnterPINState(currentPin: $currentPin, status: $status, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReEnterPINStateCopyWith<$Res> implements $ReEnterPINStateCopyWith<$Res> {
  factory _$ReEnterPINStateCopyWith(_ReEnterPINState value, $Res Function(_ReEnterPINState) _then) = __$ReEnterPINStateCopyWithImpl;
@override @useResult
$Res call({
 String currentPin, ReEnterPINCodeStatus status, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$ReEnterPINStateCopyWithImpl<$Res>
    implements _$ReEnterPINStateCopyWith<$Res> {
  __$ReEnterPINStateCopyWithImpl(this._self, this._then);

  final _ReEnterPINState _self;
  final $Res Function(_ReEnterPINState) _then;

/// Create a copy of ReEnterPINState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPin = null,Object? status = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_ReEnterPINState(
currentPin: null == currentPin ? _self.currentPin : currentPin // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReEnterPINCodeStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

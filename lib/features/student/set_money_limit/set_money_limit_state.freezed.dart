// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_money_limit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetMoneyLimitState {

 SetMoneyLimitStatus get status; String? get userId; int? get storedLimitMinor; String get amountInput; SetMoneyLimitValidationError? get validationError;
/// Create a copy of SetMoneyLimitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetMoneyLimitStateCopyWith<SetMoneyLimitState> get copyWith => _$SetMoneyLimitStateCopyWithImpl<SetMoneyLimitState>(this as SetMoneyLimitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetMoneyLimitState&&(identical(other.status, status) || other.status == status)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.storedLimitMinor, storedLimitMinor) || other.storedLimitMinor == storedLimitMinor)&&(identical(other.amountInput, amountInput) || other.amountInput == amountInput)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,status,userId,storedLimitMinor,amountInput,validationError);

@override
String toString() {
  return 'SetMoneyLimitState(status: $status, userId: $userId, storedLimitMinor: $storedLimitMinor, amountInput: $amountInput, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class $SetMoneyLimitStateCopyWith<$Res>  {
  factory $SetMoneyLimitStateCopyWith(SetMoneyLimitState value, $Res Function(SetMoneyLimitState) _then) = _$SetMoneyLimitStateCopyWithImpl;
@useResult
$Res call({
 SetMoneyLimitStatus status, String? userId, int? storedLimitMinor, String amountInput, SetMoneyLimitValidationError? validationError
});




}
/// @nodoc
class _$SetMoneyLimitStateCopyWithImpl<$Res>
    implements $SetMoneyLimitStateCopyWith<$Res> {
  _$SetMoneyLimitStateCopyWithImpl(this._self, this._then);

  final SetMoneyLimitState _self;
  final $Res Function(SetMoneyLimitState) _then;

/// Create a copy of SetMoneyLimitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? userId = freezed,Object? storedLimitMinor = freezed,Object? amountInput = null,Object? validationError = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetMoneyLimitStatus,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,storedLimitMinor: freezed == storedLimitMinor ? _self.storedLimitMinor : storedLimitMinor // ignore: cast_nullable_to_non_nullable
as int?,amountInput: null == amountInput ? _self.amountInput : amountInput // ignore: cast_nullable_to_non_nullable
as String,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as SetMoneyLimitValidationError?,
  ));
}

}


/// @nodoc


class _SetMoneyLimitState extends SetMoneyLimitState {
  const _SetMoneyLimitState({this.status = SetMoneyLimitStatus.initial, this.userId, this.storedLimitMinor, this.amountInput = '', this.validationError}): super._();
  

@override@JsonKey() final  SetMoneyLimitStatus status;
@override final  String? userId;
@override final  int? storedLimitMinor;
@override@JsonKey() final  String amountInput;
@override final  SetMoneyLimitValidationError? validationError;

/// Create a copy of SetMoneyLimitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetMoneyLimitStateCopyWith<_SetMoneyLimitState> get copyWith => __$SetMoneyLimitStateCopyWithImpl<_SetMoneyLimitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetMoneyLimitState&&(identical(other.status, status) || other.status == status)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.storedLimitMinor, storedLimitMinor) || other.storedLimitMinor == storedLimitMinor)&&(identical(other.amountInput, amountInput) || other.amountInput == amountInput)&&(identical(other.validationError, validationError) || other.validationError == validationError));
}


@override
int get hashCode => Object.hash(runtimeType,status,userId,storedLimitMinor,amountInput,validationError);

@override
String toString() {
  return 'SetMoneyLimitState(status: $status, userId: $userId, storedLimitMinor: $storedLimitMinor, amountInput: $amountInput, validationError: $validationError)';
}


}

/// @nodoc
abstract mixin class _$SetMoneyLimitStateCopyWith<$Res> implements $SetMoneyLimitStateCopyWith<$Res> {
  factory _$SetMoneyLimitStateCopyWith(_SetMoneyLimitState value, $Res Function(_SetMoneyLimitState) _then) = __$SetMoneyLimitStateCopyWithImpl;
@override @useResult
$Res call({
 SetMoneyLimitStatus status, String? userId, int? storedLimitMinor, String amountInput, SetMoneyLimitValidationError? validationError
});




}
/// @nodoc
class __$SetMoneyLimitStateCopyWithImpl<$Res>
    implements _$SetMoneyLimitStateCopyWith<$Res> {
  __$SetMoneyLimitStateCopyWithImpl(this._self, this._then);

  final _SetMoneyLimitState _self;
  final $Res Function(_SetMoneyLimitState) _then;

/// Create a copy of SetMoneyLimitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? userId = freezed,Object? storedLimitMinor = freezed,Object? amountInput = null,Object? validationError = freezed,}) {
  return _then(_SetMoneyLimitState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetMoneyLimitStatus,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,storedLimitMinor: freezed == storedLimitMinor ? _self.storedLimitMinor : storedLimitMinor // ignore: cast_nullable_to_non_nullable
as int?,amountInput: null == amountInput ? _self.amountInput : amountInput // ignore: cast_nullable_to_non_nullable
as String,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as SetMoneyLimitValidationError?,
  ));
}


}

// dart format on

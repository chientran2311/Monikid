// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddTransactionState {

 TransactionStatus get status; String? get errorMessage; Uint8List? get evidenceImageBytes; String? get evidenceImageFileName; String? get evidenceImageMimeType;
/// Create a copy of AddTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddTransactionStateCopyWith<AddTransactionState> get copyWith => _$AddTransactionStateCopyWithImpl<AddTransactionState>(this as AddTransactionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddTransactionState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.evidenceImageBytes, evidenceImageBytes)&&(identical(other.evidenceImageFileName, evidenceImageFileName) || other.evidenceImageFileName == evidenceImageFileName)&&(identical(other.evidenceImageMimeType, evidenceImageMimeType) || other.evidenceImageMimeType == evidenceImageMimeType));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(evidenceImageBytes),evidenceImageFileName,evidenceImageMimeType);

@override
String toString() {
  return 'AddTransactionState(status: $status, errorMessage: $errorMessage, evidenceImageBytes: $evidenceImageBytes, evidenceImageFileName: $evidenceImageFileName, evidenceImageMimeType: $evidenceImageMimeType)';
}


}

/// @nodoc
abstract mixin class $AddTransactionStateCopyWith<$Res>  {
  factory $AddTransactionStateCopyWith(AddTransactionState value, $Res Function(AddTransactionState) _then) = _$AddTransactionStateCopyWithImpl;
@useResult
$Res call({
 TransactionStatus status, String? errorMessage, Uint8List? evidenceImageBytes, String? evidenceImageFileName, String? evidenceImageMimeType
});




}
/// @nodoc
class _$AddTransactionStateCopyWithImpl<$Res>
    implements $AddTransactionStateCopyWith<$Res> {
  _$AddTransactionStateCopyWithImpl(this._self, this._then);

  final AddTransactionState _self;
  final $Res Function(AddTransactionState) _then;

/// Create a copy of AddTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? evidenceImageBytes = freezed,Object? evidenceImageFileName = freezed,Object? evidenceImageMimeType = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,evidenceImageBytes: freezed == evidenceImageBytes ? _self.evidenceImageBytes : evidenceImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,evidenceImageFileName: freezed == evidenceImageFileName ? _self.evidenceImageFileName : evidenceImageFileName // ignore: cast_nullable_to_non_nullable
as String?,evidenceImageMimeType: freezed == evidenceImageMimeType ? _self.evidenceImageMimeType : evidenceImageMimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _AddTransactionState extends AddTransactionState {
  const _AddTransactionState({this.status = TransactionStatus.initial, this.errorMessage, this.evidenceImageBytes, this.evidenceImageFileName, this.evidenceImageMimeType}): super._();
  

@override@JsonKey() final  TransactionStatus status;
@override final  String? errorMessage;
@override final  Uint8List? evidenceImageBytes;
@override final  String? evidenceImageFileName;
@override final  String? evidenceImageMimeType;

/// Create a copy of AddTransactionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddTransactionStateCopyWith<_AddTransactionState> get copyWith => __$AddTransactionStateCopyWithImpl<_AddTransactionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddTransactionState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.evidenceImageBytes, evidenceImageBytes)&&(identical(other.evidenceImageFileName, evidenceImageFileName) || other.evidenceImageFileName == evidenceImageFileName)&&(identical(other.evidenceImageMimeType, evidenceImageMimeType) || other.evidenceImageMimeType == evidenceImageMimeType));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(evidenceImageBytes),evidenceImageFileName,evidenceImageMimeType);

@override
String toString() {
  return 'AddTransactionState(status: $status, errorMessage: $errorMessage, evidenceImageBytes: $evidenceImageBytes, evidenceImageFileName: $evidenceImageFileName, evidenceImageMimeType: $evidenceImageMimeType)';
}


}

/// @nodoc
abstract mixin class _$AddTransactionStateCopyWith<$Res> implements $AddTransactionStateCopyWith<$Res> {
  factory _$AddTransactionStateCopyWith(_AddTransactionState value, $Res Function(_AddTransactionState) _then) = __$AddTransactionStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionStatus status, String? errorMessage, Uint8List? evidenceImageBytes, String? evidenceImageFileName, String? evidenceImageMimeType
});




}
/// @nodoc
class __$AddTransactionStateCopyWithImpl<$Res>
    implements _$AddTransactionStateCopyWith<$Res> {
  __$AddTransactionStateCopyWithImpl(this._self, this._then);

  final _AddTransactionState _self;
  final $Res Function(_AddTransactionState) _then;

/// Create a copy of AddTransactionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? evidenceImageBytes = freezed,Object? evidenceImageFileName = freezed,Object? evidenceImageMimeType = freezed,}) {
  return _then(_AddTransactionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,evidenceImageBytes: freezed == evidenceImageBytes ? _self.evidenceImageBytes : evidenceImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,evidenceImageFileName: freezed == evidenceImageFileName ? _self.evidenceImageFileName : evidenceImageFileName // ignore: cast_nullable_to_non_nullable
as String?,evidenceImageMimeType: freezed == evidenceImageMimeType ? _self.evidenceImageMimeType : evidenceImageMimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

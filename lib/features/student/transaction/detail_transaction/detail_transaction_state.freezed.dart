// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailTransactionState {

 TransactionStatus get status; String? get currentTransactionId; TransactionModel? get transaction; String? get errorMessage;
/// Create a copy of DetailTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailTransactionStateCopyWith<DetailTransactionState> get copyWith => _$DetailTransactionStateCopyWithImpl<DetailTransactionState>(this as DetailTransactionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailTransactionState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentTransactionId, currentTransactionId) || other.currentTransactionId == currentTransactionId)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentTransactionId,transaction,errorMessage);

@override
String toString() {
  return 'DetailTransactionState(status: $status, currentTransactionId: $currentTransactionId, transaction: $transaction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DetailTransactionStateCopyWith<$Res>  {
  factory $DetailTransactionStateCopyWith(DetailTransactionState value, $Res Function(DetailTransactionState) _then) = _$DetailTransactionStateCopyWithImpl;
@useResult
$Res call({
 TransactionStatus status, String? currentTransactionId, TransactionModel? transaction, String? errorMessage
});


$TransactionModelCopyWith<$Res>? get transaction;

}
/// @nodoc
class _$DetailTransactionStateCopyWithImpl<$Res>
    implements $DetailTransactionStateCopyWith<$Res> {
  _$DetailTransactionStateCopyWithImpl(this._self, this._then);

  final DetailTransactionState _self;
  final $Res Function(DetailTransactionState) _then;

/// Create a copy of DetailTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currentTransactionId = freezed,Object? transaction = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,currentTransactionId: freezed == currentTransactionId ? _self.currentTransactionId : currentTransactionId // ignore: cast_nullable_to_non_nullable
as String?,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DetailTransactionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res>? get transaction {
    if (_self.transaction == null) {
    return null;
  }

  return $TransactionModelCopyWith<$Res>(_self.transaction!, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}


/// @nodoc


class _DetailTransactionState extends DetailTransactionState {
  const _DetailTransactionState({this.status = TransactionStatus.initial, this.currentTransactionId, this.transaction, this.errorMessage}): super._();
  

@override@JsonKey() final  TransactionStatus status;
@override final  String? currentTransactionId;
@override final  TransactionModel? transaction;
@override final  String? errorMessage;

/// Create a copy of DetailTransactionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailTransactionStateCopyWith<_DetailTransactionState> get copyWith => __$DetailTransactionStateCopyWithImpl<_DetailTransactionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailTransactionState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentTransactionId, currentTransactionId) || other.currentTransactionId == currentTransactionId)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentTransactionId,transaction,errorMessage);

@override
String toString() {
  return 'DetailTransactionState(status: $status, currentTransactionId: $currentTransactionId, transaction: $transaction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DetailTransactionStateCopyWith<$Res> implements $DetailTransactionStateCopyWith<$Res> {
  factory _$DetailTransactionStateCopyWith(_DetailTransactionState value, $Res Function(_DetailTransactionState) _then) = __$DetailTransactionStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionStatus status, String? currentTransactionId, TransactionModel? transaction, String? errorMessage
});


@override $TransactionModelCopyWith<$Res>? get transaction;

}
/// @nodoc
class __$DetailTransactionStateCopyWithImpl<$Res>
    implements _$DetailTransactionStateCopyWith<$Res> {
  __$DetailTransactionStateCopyWithImpl(this._self, this._then);

  final _DetailTransactionState _self;
  final $Res Function(_DetailTransactionState) _then;

/// Create a copy of DetailTransactionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currentTransactionId = freezed,Object? transaction = freezed,Object? errorMessage = freezed,}) {
  return _then(_DetailTransactionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransactionStatus,currentTransactionId: freezed == currentTransactionId ? _self.currentTransactionId : currentTransactionId // ignore: cast_nullable_to_non_nullable
as String?,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DetailTransactionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res>? get transaction {
    if (_self.transaction == null) {
    return null;
  }

  return $TransactionModelCopyWith<$Res>(_self.transaction!, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}

// dart format on

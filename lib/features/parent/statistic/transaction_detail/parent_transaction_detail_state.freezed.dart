// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_transaction_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParentTransactionDetailState {

 ParentTransactionDetailStatus get status; TransactionModel? get transaction; String? get errorMessage;
/// Create a copy of ParentTransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentTransactionDetailStateCopyWith<ParentTransactionDetailState> get copyWith => _$ParentTransactionDetailStateCopyWithImpl<ParentTransactionDetailState>(this as ParentTransactionDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentTransactionDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,transaction,errorMessage);

@override
String toString() {
  return 'ParentTransactionDetailState(status: $status, transaction: $transaction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ParentTransactionDetailStateCopyWith<$Res>  {
  factory $ParentTransactionDetailStateCopyWith(ParentTransactionDetailState value, $Res Function(ParentTransactionDetailState) _then) = _$ParentTransactionDetailStateCopyWithImpl;
@useResult
$Res call({
 ParentTransactionDetailStatus status, TransactionModel? transaction, String? errorMessage
});


$TransactionModelCopyWith<$Res>? get transaction;

}
/// @nodoc
class _$ParentTransactionDetailStateCopyWithImpl<$Res>
    implements $ParentTransactionDetailStateCopyWith<$Res> {
  _$ParentTransactionDetailStateCopyWithImpl(this._self, this._then);

  final ParentTransactionDetailState _self;
  final $Res Function(ParentTransactionDetailState) _then;

/// Create a copy of ParentTransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? transaction = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentTransactionDetailStatus,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ParentTransactionDetailState
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


class _ParentTransactionDetailState extends ParentTransactionDetailState {
  const _ParentTransactionDetailState({this.status = ParentTransactionDetailStatus.initial, this.transaction, this.errorMessage}): super._();
  

@override@JsonKey() final  ParentTransactionDetailStatus status;
@override final  TransactionModel? transaction;
@override final  String? errorMessage;

/// Create a copy of ParentTransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentTransactionDetailStateCopyWith<_ParentTransactionDetailState> get copyWith => __$ParentTransactionDetailStateCopyWithImpl<_ParentTransactionDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentTransactionDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,transaction,errorMessage);

@override
String toString() {
  return 'ParentTransactionDetailState(status: $status, transaction: $transaction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ParentTransactionDetailStateCopyWith<$Res> implements $ParentTransactionDetailStateCopyWith<$Res> {
  factory _$ParentTransactionDetailStateCopyWith(_ParentTransactionDetailState value, $Res Function(_ParentTransactionDetailState) _then) = __$ParentTransactionDetailStateCopyWithImpl;
@override @useResult
$Res call({
 ParentTransactionDetailStatus status, TransactionModel? transaction, String? errorMessage
});


@override $TransactionModelCopyWith<$Res>? get transaction;

}
/// @nodoc
class __$ParentTransactionDetailStateCopyWithImpl<$Res>
    implements _$ParentTransactionDetailStateCopyWith<$Res> {
  __$ParentTransactionDetailStateCopyWithImpl(this._self, this._then);

  final _ParentTransactionDetailState _self;
  final $Res Function(_ParentTransactionDetailState) _then;

/// Create a copy of ParentTransactionDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? transaction = freezed,Object? errorMessage = freezed,}) {
  return _then(_ParentTransactionDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentTransactionDetailStatus,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ParentTransactionDetailState
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

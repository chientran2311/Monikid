// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_category_transactions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParentCategoryTransactionsState {

 ParentCategoryTransactionsStatus get status; List<TransactionModel> get transactions; String? get errorMessage;
/// Create a copy of ParentCategoryTransactionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentCategoryTransactionsStateCopyWith<ParentCategoryTransactionsState> get copyWith => _$ParentCategoryTransactionsStateCopyWithImpl<ParentCategoryTransactionsState>(this as ParentCategoryTransactionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentCategoryTransactionsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(transactions),errorMessage);

@override
String toString() {
  return 'ParentCategoryTransactionsState(status: $status, transactions: $transactions, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ParentCategoryTransactionsStateCopyWith<$Res>  {
  factory $ParentCategoryTransactionsStateCopyWith(ParentCategoryTransactionsState value, $Res Function(ParentCategoryTransactionsState) _then) = _$ParentCategoryTransactionsStateCopyWithImpl;
@useResult
$Res call({
 ParentCategoryTransactionsStatus status, List<TransactionModel> transactions, String? errorMessage
});




}
/// @nodoc
class _$ParentCategoryTransactionsStateCopyWithImpl<$Res>
    implements $ParentCategoryTransactionsStateCopyWith<$Res> {
  _$ParentCategoryTransactionsStateCopyWithImpl(this._self, this._then);

  final ParentCategoryTransactionsState _self;
  final $Res Function(ParentCategoryTransactionsState) _then;

/// Create a copy of ParentCategoryTransactionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? transactions = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentCategoryTransactionsStatus,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _ParentCategoryTransactionsState extends ParentCategoryTransactionsState {
  const _ParentCategoryTransactionsState({this.status = ParentCategoryTransactionsStatus.initial, final  List<TransactionModel> transactions = const [], this.errorMessage}): _transactions = transactions,super._();
  

@override@JsonKey() final  ParentCategoryTransactionsStatus status;
 final  List<TransactionModel> _transactions;
@override@JsonKey() List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override final  String? errorMessage;

/// Create a copy of ParentCategoryTransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentCategoryTransactionsStateCopyWith<_ParentCategoryTransactionsState> get copyWith => __$ParentCategoryTransactionsStateCopyWithImpl<_ParentCategoryTransactionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentCategoryTransactionsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_transactions),errorMessage);

@override
String toString() {
  return 'ParentCategoryTransactionsState(status: $status, transactions: $transactions, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ParentCategoryTransactionsStateCopyWith<$Res> implements $ParentCategoryTransactionsStateCopyWith<$Res> {
  factory _$ParentCategoryTransactionsStateCopyWith(_ParentCategoryTransactionsState value, $Res Function(_ParentCategoryTransactionsState) _then) = __$ParentCategoryTransactionsStateCopyWithImpl;
@override @useResult
$Res call({
 ParentCategoryTransactionsStatus status, List<TransactionModel> transactions, String? errorMessage
});




}
/// @nodoc
class __$ParentCategoryTransactionsStateCopyWithImpl<$Res>
    implements _$ParentCategoryTransactionsStateCopyWith<$Res> {
  __$ParentCategoryTransactionsStateCopyWithImpl(this._self, this._then);

  final _ParentCategoryTransactionsState _self;
  final $Res Function(_ParentCategoryTransactionsState) _then;

/// Create a copy of ParentCategoryTransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? transactions = null,Object? errorMessage = freezed,}) {
  return _then(_ParentCategoryTransactionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentCategoryTransactionsStatus,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

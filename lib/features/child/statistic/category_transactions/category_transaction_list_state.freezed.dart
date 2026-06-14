// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_transaction_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryTransactionListState {

 CategoryTransactionListStatus get status; List<TransactionModel> get transactions; String? get errorMessage;
/// Create a copy of CategoryTransactionListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryTransactionListStateCopyWith<CategoryTransactionListState> get copyWith => _$CategoryTransactionListStateCopyWithImpl<CategoryTransactionListState>(this as CategoryTransactionListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryTransactionListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(transactions),errorMessage);

@override
String toString() {
  return 'CategoryTransactionListState(status: $status, transactions: $transactions, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CategoryTransactionListStateCopyWith<$Res>  {
  factory $CategoryTransactionListStateCopyWith(CategoryTransactionListState value, $Res Function(CategoryTransactionListState) _then) = _$CategoryTransactionListStateCopyWithImpl;
@useResult
$Res call({
 CategoryTransactionListStatus status, List<TransactionModel> transactions, String? errorMessage
});




}
/// @nodoc
class _$CategoryTransactionListStateCopyWithImpl<$Res>
    implements $CategoryTransactionListStateCopyWith<$Res> {
  _$CategoryTransactionListStateCopyWithImpl(this._self, this._then);

  final CategoryTransactionListState _self;
  final $Res Function(CategoryTransactionListState) _then;

/// Create a copy of CategoryTransactionListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? transactions = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryTransactionListStatus,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _CategoryTransactionListState extends CategoryTransactionListState {
  const _CategoryTransactionListState({this.status = CategoryTransactionListStatus.initial, final  List<TransactionModel> transactions = const [], this.errorMessage}): _transactions = transactions,super._();
  

@override@JsonKey() final  CategoryTransactionListStatus status;
 final  List<TransactionModel> _transactions;
@override@JsonKey() List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override final  String? errorMessage;

/// Create a copy of CategoryTransactionListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryTransactionListStateCopyWith<_CategoryTransactionListState> get copyWith => __$CategoryTransactionListStateCopyWithImpl<_CategoryTransactionListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryTransactionListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_transactions),errorMessage);

@override
String toString() {
  return 'CategoryTransactionListState(status: $status, transactions: $transactions, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CategoryTransactionListStateCopyWith<$Res> implements $CategoryTransactionListStateCopyWith<$Res> {
  factory _$CategoryTransactionListStateCopyWith(_CategoryTransactionListState value, $Res Function(_CategoryTransactionListState) _then) = __$CategoryTransactionListStateCopyWithImpl;
@override @useResult
$Res call({
 CategoryTransactionListStatus status, List<TransactionModel> transactions, String? errorMessage
});




}
/// @nodoc
class __$CategoryTransactionListStateCopyWithImpl<$Res>
    implements _$CategoryTransactionListStateCopyWith<$Res> {
  __$CategoryTransactionListStateCopyWithImpl(this._self, this._then);

  final _CategoryTransactionListState _self;
  final $Res Function(_CategoryTransactionListState) _then;

/// Create a copy of CategoryTransactionListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? transactions = null,Object? errorMessage = freezed,}) {
  return _then(_CategoryTransactionListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryTransactionListStatus,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

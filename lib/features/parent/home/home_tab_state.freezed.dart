// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeTabState {

 List<TransactionModel> get transactions; bool get isLoading;
/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeTabStateCopyWith<HomeTabState> get copyWith => _$HomeTabStateCopyWithImpl<HomeTabState>(this as HomeTabState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTabState&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions),isLoading);

@override
String toString() {
  return 'HomeTabState(transactions: $transactions, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $HomeTabStateCopyWith<$Res>  {
  factory $HomeTabStateCopyWith(HomeTabState value, $Res Function(HomeTabState) _then) = _$HomeTabStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionModel> transactions, bool isLoading
});




}
/// @nodoc
class _$HomeTabStateCopyWithImpl<$Res>
    implements $HomeTabStateCopyWith<$Res> {
  _$HomeTabStateCopyWithImpl(this._self, this._then);

  final HomeTabState _self;
  final $Res Function(HomeTabState) _then;

/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _HomeTabState extends HomeTabState {
  const _HomeTabState({required final  List<TransactionModel> transactions, this.isLoading = false}): _transactions = transactions,super._();
  

 final  List<TransactionModel> _transactions;
@override List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeTabStateCopyWith<_HomeTabState> get copyWith => __$HomeTabStateCopyWithImpl<_HomeTabState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeTabState&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),isLoading);

@override
String toString() {
  return 'HomeTabState(transactions: $transactions, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$HomeTabStateCopyWith<$Res> implements $HomeTabStateCopyWith<$Res> {
  factory _$HomeTabStateCopyWith(_HomeTabState value, $Res Function(_HomeTabState) _then) = __$HomeTabStateCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionModel> transactions, bool isLoading
});




}
/// @nodoc
class __$HomeTabStateCopyWithImpl<$Res>
    implements _$HomeTabStateCopyWith<$Res> {
  __$HomeTabStateCopyWithImpl(this._self, this._then);

  final _HomeTabState _self;
  final $Res Function(_HomeTabState) _then;

/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? isLoading = null,}) {
  return _then(_HomeTabState(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

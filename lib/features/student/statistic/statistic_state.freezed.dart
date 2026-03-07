// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatisticState {

 List<TransactionModel> get transactions; List<TransactionModel> get previousMonthTransactions; bool get isLoading; bool get isLoadingMore; bool get isRefreshing; bool get hasMore; int get monthLimit;/// 0: Tháng trước, 1: Tháng này
 int get selectedMonthIndex; double get totalExpense; double get previousMonthTotalExpense; String? get errorMessage;
/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticStateCopyWith<StatisticState> get copyWith => _$StatisticStateCopyWithImpl<StatisticState>(this as StatisticState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticState&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.previousMonthTransactions, previousMonthTransactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.monthLimit, monthLimit) || other.monthLimit == monthLimit)&&(identical(other.selectedMonthIndex, selectedMonthIndex) || other.selectedMonthIndex == selectedMonthIndex)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.previousMonthTotalExpense, previousMonthTotalExpense) || other.previousMonthTotalExpense == previousMonthTotalExpense)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(previousMonthTransactions),isLoading,isLoadingMore,isRefreshing,hasMore,monthLimit,selectedMonthIndex,totalExpense,previousMonthTotalExpense,errorMessage);

@override
String toString() {
  return 'StatisticState(transactions: $transactions, previousMonthTransactions: $previousMonthTransactions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, hasMore: $hasMore, monthLimit: $monthLimit, selectedMonthIndex: $selectedMonthIndex, totalExpense: $totalExpense, previousMonthTotalExpense: $previousMonthTotalExpense, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StatisticStateCopyWith<$Res>  {
  factory $StatisticStateCopyWith(StatisticState value, $Res Function(StatisticState) _then) = _$StatisticStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionModel> transactions, List<TransactionModel> previousMonthTransactions, bool isLoading, bool isLoadingMore, bool isRefreshing, bool hasMore, int monthLimit, int selectedMonthIndex, double totalExpense, double previousMonthTotalExpense, String? errorMessage
});




}
/// @nodoc
class _$StatisticStateCopyWithImpl<$Res>
    implements $StatisticStateCopyWith<$Res> {
  _$StatisticStateCopyWithImpl(this._self, this._then);

  final StatisticState _self;
  final $Res Function(StatisticState) _then;

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? previousMonthTransactions = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? hasMore = null,Object? monthLimit = null,Object? selectedMonthIndex = null,Object? totalExpense = null,Object? previousMonthTotalExpense = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,previousMonthTransactions: null == previousMonthTransactions ? _self.previousMonthTransactions : previousMonthTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,monthLimit: null == monthLimit ? _self.monthLimit : monthLimit // ignore: cast_nullable_to_non_nullable
as int,selectedMonthIndex: null == selectedMonthIndex ? _self.selectedMonthIndex : selectedMonthIndex // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,previousMonthTotalExpense: null == previousMonthTotalExpense ? _self.previousMonthTotalExpense : previousMonthTotalExpense // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _StatisticState implements StatisticState {
  const _StatisticState({final  List<TransactionModel> transactions = const [], final  List<TransactionModel> previousMonthTransactions = const [], this.isLoading = true, this.isLoadingMore = false, this.isRefreshing = false, this.hasMore = true, this.monthLimit = 8, this.selectedMonthIndex = 1, this.totalExpense = 0.0, this.previousMonthTotalExpense = 0.0, this.errorMessage}): _transactions = transactions,_previousMonthTransactions = previousMonthTransactions;
  

 final  List<TransactionModel> _transactions;
@override@JsonKey() List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<TransactionModel> _previousMonthTransactions;
@override@JsonKey() List<TransactionModel> get previousMonthTransactions {
  if (_previousMonthTransactions is EqualUnmodifiableListView) return _previousMonthTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousMonthTransactions);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int monthLimit;
/// 0: Tháng trước, 1: Tháng này
@override@JsonKey() final  int selectedMonthIndex;
@override@JsonKey() final  double totalExpense;
@override@JsonKey() final  double previousMonthTotalExpense;
@override final  String? errorMessage;

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticStateCopyWith<_StatisticState> get copyWith => __$StatisticStateCopyWithImpl<_StatisticState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticState&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._previousMonthTransactions, _previousMonthTransactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.monthLimit, monthLimit) || other.monthLimit == monthLimit)&&(identical(other.selectedMonthIndex, selectedMonthIndex) || other.selectedMonthIndex == selectedMonthIndex)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.previousMonthTotalExpense, previousMonthTotalExpense) || other.previousMonthTotalExpense == previousMonthTotalExpense)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_previousMonthTransactions),isLoading,isLoadingMore,isRefreshing,hasMore,monthLimit,selectedMonthIndex,totalExpense,previousMonthTotalExpense,errorMessage);

@override
String toString() {
  return 'StatisticState(transactions: $transactions, previousMonthTransactions: $previousMonthTransactions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, hasMore: $hasMore, monthLimit: $monthLimit, selectedMonthIndex: $selectedMonthIndex, totalExpense: $totalExpense, previousMonthTotalExpense: $previousMonthTotalExpense, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StatisticStateCopyWith<$Res> implements $StatisticStateCopyWith<$Res> {
  factory _$StatisticStateCopyWith(_StatisticState value, $Res Function(_StatisticState) _then) = __$StatisticStateCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionModel> transactions, List<TransactionModel> previousMonthTransactions, bool isLoading, bool isLoadingMore, bool isRefreshing, bool hasMore, int monthLimit, int selectedMonthIndex, double totalExpense, double previousMonthTotalExpense, String? errorMessage
});




}
/// @nodoc
class __$StatisticStateCopyWithImpl<$Res>
    implements _$StatisticStateCopyWith<$Res> {
  __$StatisticStateCopyWithImpl(this._self, this._then);

  final _StatisticState _self;
  final $Res Function(_StatisticState) _then;

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? previousMonthTransactions = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? hasMore = null,Object? monthLimit = null,Object? selectedMonthIndex = null,Object? totalExpense = null,Object? previousMonthTotalExpense = null,Object? errorMessage = freezed,}) {
  return _then(_StatisticState(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,previousMonthTransactions: null == previousMonthTransactions ? _self._previousMonthTransactions : previousMonthTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,monthLimit: null == monthLimit ? _self.monthLimit : monthLimit // ignore: cast_nullable_to_non_nullable
as int,selectedMonthIndex: null == selectedMonthIndex ? _self.selectedMonthIndex : selectedMonthIndex // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,previousMonthTotalExpense: null == previousMonthTotalExpense ? _self.previousMonthTotalExpense : previousMonthTotalExpense // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

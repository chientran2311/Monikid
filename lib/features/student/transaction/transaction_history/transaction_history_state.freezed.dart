// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionHistoryState {

 List<TransactionModel> get transactions; bool get isLoading; bool get isLoadingMore; bool get isRefreshing; bool get isListLoading; bool get hasMore; DateTime? get selectedDate; String? get selectedCategory;// Mặc định là 'expense' hoặc 'income', không còn null
 String get transactionTypeFilter; int get monthLimit; String? get errorMessage;
/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionHistoryStateCopyWith<TransactionHistoryState> get copyWith => _$TransactionHistoryStateCopyWithImpl<TransactionHistoryState>(this as TransactionHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionHistoryState&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isListLoading, isListLoading) || other.isListLoading == isListLoading)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.transactionTypeFilter, transactionTypeFilter) || other.transactionTypeFilter == transactionTypeFilter)&&(identical(other.monthLimit, monthLimit) || other.monthLimit == monthLimit)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions),isLoading,isLoadingMore,isRefreshing,isListLoading,hasMore,selectedDate,selectedCategory,transactionTypeFilter,monthLimit,errorMessage);

@override
String toString() {
  return 'TransactionHistoryState(transactions: $transactions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, isListLoading: $isListLoading, hasMore: $hasMore, selectedDate: $selectedDate, selectedCategory: $selectedCategory, transactionTypeFilter: $transactionTypeFilter, monthLimit: $monthLimit, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TransactionHistoryStateCopyWith<$Res>  {
  factory $TransactionHistoryStateCopyWith(TransactionHistoryState value, $Res Function(TransactionHistoryState) _then) = _$TransactionHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionModel> transactions, bool isLoading, bool isLoadingMore, bool isRefreshing, bool isListLoading, bool hasMore, DateTime? selectedDate, String? selectedCategory, String transactionTypeFilter, int monthLimit, String? errorMessage
});




}
/// @nodoc
class _$TransactionHistoryStateCopyWithImpl<$Res>
    implements $TransactionHistoryStateCopyWith<$Res> {
  _$TransactionHistoryStateCopyWithImpl(this._self, this._then);

  final TransactionHistoryState _self;
  final $Res Function(TransactionHistoryState) _then;

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? isListLoading = null,Object? hasMore = null,Object? selectedDate = freezed,Object? selectedCategory = freezed,Object? transactionTypeFilter = null,Object? monthLimit = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,transactionTypeFilter: null == transactionTypeFilter ? _self.transactionTypeFilter : transactionTypeFilter // ignore: cast_nullable_to_non_nullable
as String,monthLimit: null == monthLimit ? _self.monthLimit : monthLimit // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _TransactionHistoryState implements TransactionHistoryState {
  const _TransactionHistoryState({final  List<TransactionModel> transactions = const [], this.isLoading = true, this.isLoadingMore = false, this.isRefreshing = false, this.isListLoading = false, this.hasMore = true, this.selectedDate, this.selectedCategory, this.transactionTypeFilter = 'expense', this.monthLimit = 8, this.errorMessage}): _transactions = transactions;
  

 final  List<TransactionModel> _transactions;
@override@JsonKey() List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isListLoading;
@override@JsonKey() final  bool hasMore;
@override final  DateTime? selectedDate;
@override final  String? selectedCategory;
// Mặc định là 'expense' hoặc 'income', không còn null
@override@JsonKey() final  String transactionTypeFilter;
@override@JsonKey() final  int monthLimit;
@override final  String? errorMessage;

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionHistoryStateCopyWith<_TransactionHistoryState> get copyWith => __$TransactionHistoryStateCopyWithImpl<_TransactionHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionHistoryState&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isListLoading, isListLoading) || other.isListLoading == isListLoading)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.transactionTypeFilter, transactionTypeFilter) || other.transactionTypeFilter == transactionTypeFilter)&&(identical(other.monthLimit, monthLimit) || other.monthLimit == monthLimit)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),isLoading,isLoadingMore,isRefreshing,isListLoading,hasMore,selectedDate,selectedCategory,transactionTypeFilter,monthLimit,errorMessage);

@override
String toString() {
  return 'TransactionHistoryState(transactions: $transactions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, isListLoading: $isListLoading, hasMore: $hasMore, selectedDate: $selectedDate, selectedCategory: $selectedCategory, transactionTypeFilter: $transactionTypeFilter, monthLimit: $monthLimit, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TransactionHistoryStateCopyWith<$Res> implements $TransactionHistoryStateCopyWith<$Res> {
  factory _$TransactionHistoryStateCopyWith(_TransactionHistoryState value, $Res Function(_TransactionHistoryState) _then) = __$TransactionHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionModel> transactions, bool isLoading, bool isLoadingMore, bool isRefreshing, bool isListLoading, bool hasMore, DateTime? selectedDate, String? selectedCategory, String transactionTypeFilter, int monthLimit, String? errorMessage
});




}
/// @nodoc
class __$TransactionHistoryStateCopyWithImpl<$Res>
    implements _$TransactionHistoryStateCopyWith<$Res> {
  __$TransactionHistoryStateCopyWithImpl(this._self, this._then);

  final _TransactionHistoryState _self;
  final $Res Function(_TransactionHistoryState) _then;

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? isLoading = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? isListLoading = null,Object? hasMore = null,Object? selectedDate = freezed,Object? selectedCategory = freezed,Object? transactionTypeFilter = null,Object? monthLimit = null,Object? errorMessage = freezed,}) {
  return _then(_TransactionHistoryState(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,transactionTypeFilter: null == transactionTypeFilter ? _self.transactionTypeFilter : transactionTypeFilter // ignore: cast_nullable_to_non_nullable
as String,monthLimit: null == monthLimit ? _self.monthLimit : monthLimit // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

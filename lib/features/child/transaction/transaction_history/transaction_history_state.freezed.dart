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

 List<TransactionModel> get monthlyTransactions; List<TransactionModel> get transactions; TransactionHistorySharedStatus get sharedStatus; bool get isLoading; bool get isListLoading; bool get isLoadingMore; bool get hasMore; int get monthLimit; String? get sharedErrorMessage; String? get errorMessage;// Legacy state properties kept for backward compatibility
 DateTime? get selectedDate; String? get transactionTypeFilter; String? get selectedCategoryKey; TransactionModel? get selectedTransaction; String? get selectedTransactionId; String? get selectionErrorMessage;
/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionHistoryStateCopyWith<TransactionHistoryState> get copyWith => _$TransactionHistoryStateCopyWithImpl<TransactionHistoryState>(this as TransactionHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionHistoryState&&const DeepCollectionEquality().equals(other.monthlyTransactions, monthlyTransactions)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.sharedStatus, sharedStatus) || other.sharedStatus == sharedStatus)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isListLoading, isListLoading) || other.isListLoading == isListLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.monthLimit, monthLimit) || other.monthLimit == monthLimit)&&(identical(other.sharedErrorMessage, sharedErrorMessage) || other.sharedErrorMessage == sharedErrorMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.transactionTypeFilter, transactionTypeFilter) || other.transactionTypeFilter == transactionTypeFilter)&&(identical(other.selectedCategoryKey, selectedCategoryKey) || other.selectedCategoryKey == selectedCategoryKey)&&(identical(other.selectedTransaction, selectedTransaction) || other.selectedTransaction == selectedTransaction)&&(identical(other.selectedTransactionId, selectedTransactionId) || other.selectedTransactionId == selectedTransactionId)&&(identical(other.selectionErrorMessage, selectionErrorMessage) || other.selectionErrorMessage == selectionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(monthlyTransactions),const DeepCollectionEquality().hash(transactions),sharedStatus,isLoading,isListLoading,isLoadingMore,hasMore,monthLimit,sharedErrorMessage,errorMessage,selectedDate,transactionTypeFilter,selectedCategoryKey,selectedTransaction,selectedTransactionId,selectionErrorMessage);

@override
String toString() {
  return 'TransactionHistoryState(monthlyTransactions: $monthlyTransactions, transactions: $transactions, sharedStatus: $sharedStatus, isLoading: $isLoading, isListLoading: $isListLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, monthLimit: $monthLimit, sharedErrorMessage: $sharedErrorMessage, errorMessage: $errorMessage, selectedDate: $selectedDate, transactionTypeFilter: $transactionTypeFilter, selectedCategoryKey: $selectedCategoryKey, selectedTransaction: $selectedTransaction, selectedTransactionId: $selectedTransactionId, selectionErrorMessage: $selectionErrorMessage)';
}


}

/// @nodoc
abstract mixin class $TransactionHistoryStateCopyWith<$Res>  {
  factory $TransactionHistoryStateCopyWith(TransactionHistoryState value, $Res Function(TransactionHistoryState) _then) = _$TransactionHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionModel> monthlyTransactions, List<TransactionModel> transactions, TransactionHistorySharedStatus sharedStatus, bool isLoading, bool isListLoading, bool isLoadingMore, bool hasMore, int monthLimit, String? sharedErrorMessage, String? errorMessage, DateTime? selectedDate, String? transactionTypeFilter, String? selectedCategoryKey, TransactionModel? selectedTransaction, String? selectedTransactionId, String? selectionErrorMessage
});


$TransactionModelCopyWith<$Res>? get selectedTransaction;

}
/// @nodoc
class _$TransactionHistoryStateCopyWithImpl<$Res>
    implements $TransactionHistoryStateCopyWith<$Res> {
  _$TransactionHistoryStateCopyWithImpl(this._self, this._then);

  final TransactionHistoryState _self;
  final $Res Function(TransactionHistoryState) _then;

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? monthlyTransactions = null,Object? transactions = null,Object? sharedStatus = null,Object? isLoading = null,Object? isListLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? monthLimit = null,Object? sharedErrorMessage = freezed,Object? errorMessage = freezed,Object? selectedDate = freezed,Object? transactionTypeFilter = freezed,Object? selectedCategoryKey = freezed,Object? selectedTransaction = freezed,Object? selectedTransactionId = freezed,Object? selectionErrorMessage = freezed,}) {
  return _then(_self.copyWith(
monthlyTransactions: null == monthlyTransactions ? _self.monthlyTransactions : monthlyTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,sharedStatus: null == sharedStatus ? _self.sharedStatus : sharedStatus // ignore: cast_nullable_to_non_nullable
as TransactionHistorySharedStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,monthLimit: null == monthLimit ? _self.monthLimit : monthLimit // ignore: cast_nullable_to_non_nullable
as int,sharedErrorMessage: freezed == sharedErrorMessage ? _self.sharedErrorMessage : sharedErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionTypeFilter: freezed == transactionTypeFilter ? _self.transactionTypeFilter : transactionTypeFilter // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryKey: freezed == selectedCategoryKey ? _self.selectedCategoryKey : selectedCategoryKey // ignore: cast_nullable_to_non_nullable
as String?,selectedTransaction: freezed == selectedTransaction ? _self.selectedTransaction : selectedTransaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,selectedTransactionId: freezed == selectedTransactionId ? _self.selectedTransactionId : selectedTransactionId // ignore: cast_nullable_to_non_nullable
as String?,selectionErrorMessage: freezed == selectionErrorMessage ? _self.selectionErrorMessage : selectionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res>? get selectedTransaction {
    if (_self.selectedTransaction == null) {
    return null;
  }

  return $TransactionModelCopyWith<$Res>(_self.selectedTransaction!, (value) {
    return _then(_self.copyWith(selectedTransaction: value));
  });
}
}


/// @nodoc


class _TransactionHistoryState extends TransactionHistoryState {
  const _TransactionHistoryState({final  List<TransactionModel> monthlyTransactions = const [], final  List<TransactionModel> transactions = const [], this.sharedStatus = TransactionHistorySharedStatus.initial, this.isLoading = true, this.isListLoading = false, this.isLoadingMore = false, this.hasMore = true, this.monthLimit = 8, this.sharedErrorMessage, this.errorMessage, this.selectedDate, this.transactionTypeFilter, this.selectedCategoryKey, this.selectedTransaction, this.selectedTransactionId, this.selectionErrorMessage}): _monthlyTransactions = monthlyTransactions,_transactions = transactions,super._();
  

 final  List<TransactionModel> _monthlyTransactions;
@override@JsonKey() List<TransactionModel> get monthlyTransactions {
  if (_monthlyTransactions is EqualUnmodifiableListView) return _monthlyTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyTransactions);
}

 final  List<TransactionModel> _transactions;
@override@JsonKey() List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override@JsonKey() final  TransactionHistorySharedStatus sharedStatus;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isListLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int monthLimit;
@override final  String? sharedErrorMessage;
@override final  String? errorMessage;
// Legacy state properties kept for backward compatibility
@override final  DateTime? selectedDate;
@override final  String? transactionTypeFilter;
@override final  String? selectedCategoryKey;
@override final  TransactionModel? selectedTransaction;
@override final  String? selectedTransactionId;
@override final  String? selectionErrorMessage;

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionHistoryStateCopyWith<_TransactionHistoryState> get copyWith => __$TransactionHistoryStateCopyWithImpl<_TransactionHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionHistoryState&&const DeepCollectionEquality().equals(other._monthlyTransactions, _monthlyTransactions)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.sharedStatus, sharedStatus) || other.sharedStatus == sharedStatus)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isListLoading, isListLoading) || other.isListLoading == isListLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.monthLimit, monthLimit) || other.monthLimit == monthLimit)&&(identical(other.sharedErrorMessage, sharedErrorMessage) || other.sharedErrorMessage == sharedErrorMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.transactionTypeFilter, transactionTypeFilter) || other.transactionTypeFilter == transactionTypeFilter)&&(identical(other.selectedCategoryKey, selectedCategoryKey) || other.selectedCategoryKey == selectedCategoryKey)&&(identical(other.selectedTransaction, selectedTransaction) || other.selectedTransaction == selectedTransaction)&&(identical(other.selectedTransactionId, selectedTransactionId) || other.selectedTransactionId == selectedTransactionId)&&(identical(other.selectionErrorMessage, selectionErrorMessage) || other.selectionErrorMessage == selectionErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_monthlyTransactions),const DeepCollectionEquality().hash(_transactions),sharedStatus,isLoading,isListLoading,isLoadingMore,hasMore,monthLimit,sharedErrorMessage,errorMessage,selectedDate,transactionTypeFilter,selectedCategoryKey,selectedTransaction,selectedTransactionId,selectionErrorMessage);

@override
String toString() {
  return 'TransactionHistoryState(monthlyTransactions: $monthlyTransactions, transactions: $transactions, sharedStatus: $sharedStatus, isLoading: $isLoading, isListLoading: $isListLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, monthLimit: $monthLimit, sharedErrorMessage: $sharedErrorMessage, errorMessage: $errorMessage, selectedDate: $selectedDate, transactionTypeFilter: $transactionTypeFilter, selectedCategoryKey: $selectedCategoryKey, selectedTransaction: $selectedTransaction, selectedTransactionId: $selectedTransactionId, selectionErrorMessage: $selectionErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$TransactionHistoryStateCopyWith<$Res> implements $TransactionHistoryStateCopyWith<$Res> {
  factory _$TransactionHistoryStateCopyWith(_TransactionHistoryState value, $Res Function(_TransactionHistoryState) _then) = __$TransactionHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionModel> monthlyTransactions, List<TransactionModel> transactions, TransactionHistorySharedStatus sharedStatus, bool isLoading, bool isListLoading, bool isLoadingMore, bool hasMore, int monthLimit, String? sharedErrorMessage, String? errorMessage, DateTime? selectedDate, String? transactionTypeFilter, String? selectedCategoryKey, TransactionModel? selectedTransaction, String? selectedTransactionId, String? selectionErrorMessage
});


@override $TransactionModelCopyWith<$Res>? get selectedTransaction;

}
/// @nodoc
class __$TransactionHistoryStateCopyWithImpl<$Res>
    implements _$TransactionHistoryStateCopyWith<$Res> {
  __$TransactionHistoryStateCopyWithImpl(this._self, this._then);

  final _TransactionHistoryState _self;
  final $Res Function(_TransactionHistoryState) _then;

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? monthlyTransactions = null,Object? transactions = null,Object? sharedStatus = null,Object? isLoading = null,Object? isListLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? monthLimit = null,Object? sharedErrorMessage = freezed,Object? errorMessage = freezed,Object? selectedDate = freezed,Object? transactionTypeFilter = freezed,Object? selectedCategoryKey = freezed,Object? selectedTransaction = freezed,Object? selectedTransactionId = freezed,Object? selectionErrorMessage = freezed,}) {
  return _then(_TransactionHistoryState(
monthlyTransactions: null == monthlyTransactions ? _self._monthlyTransactions : monthlyTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,sharedStatus: null == sharedStatus ? _self.sharedStatus : sharedStatus // ignore: cast_nullable_to_non_nullable
as TransactionHistorySharedStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,monthLimit: null == monthLimit ? _self.monthLimit : monthLimit // ignore: cast_nullable_to_non_nullable
as int,sharedErrorMessage: freezed == sharedErrorMessage ? _self.sharedErrorMessage : sharedErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionTypeFilter: freezed == transactionTypeFilter ? _self.transactionTypeFilter : transactionTypeFilter // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryKey: freezed == selectedCategoryKey ? _self.selectedCategoryKey : selectedCategoryKey // ignore: cast_nullable_to_non_nullable
as String?,selectedTransaction: freezed == selectedTransaction ? _self.selectedTransaction : selectedTransaction // ignore: cast_nullable_to_non_nullable
as TransactionModel?,selectedTransactionId: freezed == selectedTransactionId ? _self.selectedTransactionId : selectedTransactionId // ignore: cast_nullable_to_non_nullable
as String?,selectionErrorMessage: freezed == selectionErrorMessage ? _self.selectionErrorMessage : selectionErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TransactionHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<$Res>? get selectedTransaction {
    if (_self.selectedTransaction == null) {
    return null;
  }

  return $TransactionModelCopyWith<$Res>(_self.selectedTransaction!, (value) {
    return _then(_self.copyWith(selectedTransaction: value));
  });
}
}

// dart format on

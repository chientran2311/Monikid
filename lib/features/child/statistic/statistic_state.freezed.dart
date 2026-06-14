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

 List<TransactionModel> get transactions; List<TransactionModel> get previousPeriodTransactions; List<TransactionModel> get visibleTransactions; bool get isLoadingMore; bool get isRefreshing; bool get hasMore; int get pageLimit;/// 0: by week, 1: by month, 2: by year
 int get selectedTabIndex; DateTime? get selectedDate; double get totalExpense; double get previousPeriodTotalExpense; StatisticStatus get status; StatisticPeriodOverview? get currentOverview; StatisticPeriodOverview? get previousOverview; StatisticBudgetOverview? get budgetOverview; String? get errorMessage;
/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticStateCopyWith<StatisticState> get copyWith => _$StatisticStateCopyWithImpl<StatisticState>(this as StatisticState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticState&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.previousPeriodTransactions, previousPeriodTransactions)&&const DeepCollectionEquality().equals(other.visibleTransactions, visibleTransactions)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.pageLimit, pageLimit) || other.pageLimit == pageLimit)&&(identical(other.selectedTabIndex, selectedTabIndex) || other.selectedTabIndex == selectedTabIndex)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.previousPeriodTotalExpense, previousPeriodTotalExpense) || other.previousPeriodTotalExpense == previousPeriodTotalExpense)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentOverview, currentOverview) || other.currentOverview == currentOverview)&&(identical(other.previousOverview, previousOverview) || other.previousOverview == previousOverview)&&(identical(other.budgetOverview, budgetOverview) || other.budgetOverview == budgetOverview)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(previousPeriodTransactions),const DeepCollectionEquality().hash(visibleTransactions),isLoadingMore,isRefreshing,hasMore,pageLimit,selectedTabIndex,selectedDate,totalExpense,previousPeriodTotalExpense,status,currentOverview,previousOverview,budgetOverview,errorMessage);

@override
String toString() {
  return 'StatisticState(transactions: $transactions, previousPeriodTransactions: $previousPeriodTransactions, visibleTransactions: $visibleTransactions, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, hasMore: $hasMore, pageLimit: $pageLimit, selectedTabIndex: $selectedTabIndex, selectedDate: $selectedDate, totalExpense: $totalExpense, previousPeriodTotalExpense: $previousPeriodTotalExpense, status: $status, currentOverview: $currentOverview, previousOverview: $previousOverview, budgetOverview: $budgetOverview, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StatisticStateCopyWith<$Res>  {
  factory $StatisticStateCopyWith(StatisticState value, $Res Function(StatisticState) _then) = _$StatisticStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionModel> transactions, List<TransactionModel> previousPeriodTransactions, List<TransactionModel> visibleTransactions, bool isLoadingMore, bool isRefreshing, bool hasMore, int pageLimit, int selectedTabIndex, DateTime? selectedDate, double totalExpense, double previousPeriodTotalExpense, StatisticStatus status, StatisticPeriodOverview? currentOverview, StatisticPeriodOverview? previousOverview, StatisticBudgetOverview? budgetOverview, String? errorMessage
});


$StatisticPeriodOverviewCopyWith<$Res>? get currentOverview;$StatisticPeriodOverviewCopyWith<$Res>? get previousOverview;$StatisticBudgetOverviewCopyWith<$Res>? get budgetOverview;

}
/// @nodoc
class _$StatisticStateCopyWithImpl<$Res>
    implements $StatisticStateCopyWith<$Res> {
  _$StatisticStateCopyWithImpl(this._self, this._then);

  final StatisticState _self;
  final $Res Function(StatisticState) _then;

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? previousPeriodTransactions = null,Object? visibleTransactions = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? hasMore = null,Object? pageLimit = null,Object? selectedTabIndex = null,Object? selectedDate = freezed,Object? totalExpense = null,Object? previousPeriodTotalExpense = null,Object? status = null,Object? currentOverview = freezed,Object? previousOverview = freezed,Object? budgetOverview = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,previousPeriodTransactions: null == previousPeriodTransactions ? _self.previousPeriodTransactions : previousPeriodTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,visibleTransactions: null == visibleTransactions ? _self.visibleTransactions : visibleTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,pageLimit: null == pageLimit ? _self.pageLimit : pageLimit // ignore: cast_nullable_to_non_nullable
as int,selectedTabIndex: null == selectedTabIndex ? _self.selectedTabIndex : selectedTabIndex // ignore: cast_nullable_to_non_nullable
as int,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,previousPeriodTotalExpense: null == previousPeriodTotalExpense ? _self.previousPeriodTotalExpense : previousPeriodTotalExpense // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatisticStatus,currentOverview: freezed == currentOverview ? _self.currentOverview : currentOverview // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview?,previousOverview: freezed == previousOverview ? _self.previousOverview : previousOverview // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview?,budgetOverview: freezed == budgetOverview ? _self.budgetOverview : budgetOverview // ignore: cast_nullable_to_non_nullable
as StatisticBudgetOverview?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res>? get currentOverview {
    if (_self.currentOverview == null) {
    return null;
  }

  return $StatisticPeriodOverviewCopyWith<$Res>(_self.currentOverview!, (value) {
    return _then(_self.copyWith(currentOverview: value));
  });
}/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res>? get previousOverview {
    if (_self.previousOverview == null) {
    return null;
  }

  return $StatisticPeriodOverviewCopyWith<$Res>(_self.previousOverview!, (value) {
    return _then(_self.copyWith(previousOverview: value));
  });
}/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticBudgetOverviewCopyWith<$Res>? get budgetOverview {
    if (_self.budgetOverview == null) {
    return null;
  }

  return $StatisticBudgetOverviewCopyWith<$Res>(_self.budgetOverview!, (value) {
    return _then(_self.copyWith(budgetOverview: value));
  });
}
}


/// @nodoc


class _StatisticState extends StatisticState {
  const _StatisticState({final  List<TransactionModel> transactions = const [], final  List<TransactionModel> previousPeriodTransactions = const [], final  List<TransactionModel> visibleTransactions = const [], this.isLoadingMore = false, this.isRefreshing = false, this.hasMore = true, this.pageLimit = 8, this.selectedTabIndex = 1, this.selectedDate, this.totalExpense = 0.0, this.previousPeriodTotalExpense = 0.0, this.status = StatisticStatus.initial, this.currentOverview, this.previousOverview, this.budgetOverview, this.errorMessage}): _transactions = transactions,_previousPeriodTransactions = previousPeriodTransactions,_visibleTransactions = visibleTransactions,super._();
  

 final  List<TransactionModel> _transactions;
@override@JsonKey() List<TransactionModel> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<TransactionModel> _previousPeriodTransactions;
@override@JsonKey() List<TransactionModel> get previousPeriodTransactions {
  if (_previousPeriodTransactions is EqualUnmodifiableListView) return _previousPeriodTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousPeriodTransactions);
}

 final  List<TransactionModel> _visibleTransactions;
@override@JsonKey() List<TransactionModel> get visibleTransactions {
  if (_visibleTransactions is EqualUnmodifiableListView) return _visibleTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleTransactions);
}

@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int pageLimit;
/// 0: by week, 1: by month, 2: by year
@override@JsonKey() final  int selectedTabIndex;
@override final  DateTime? selectedDate;
@override@JsonKey() final  double totalExpense;
@override@JsonKey() final  double previousPeriodTotalExpense;
@override@JsonKey() final  StatisticStatus status;
@override final  StatisticPeriodOverview? currentOverview;
@override final  StatisticPeriodOverview? previousOverview;
@override final  StatisticBudgetOverview? budgetOverview;
@override final  String? errorMessage;

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticStateCopyWith<_StatisticState> get copyWith => __$StatisticStateCopyWithImpl<_StatisticState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticState&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._previousPeriodTransactions, _previousPeriodTransactions)&&const DeepCollectionEquality().equals(other._visibleTransactions, _visibleTransactions)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.pageLimit, pageLimit) || other.pageLimit == pageLimit)&&(identical(other.selectedTabIndex, selectedTabIndex) || other.selectedTabIndex == selectedTabIndex)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.previousPeriodTotalExpense, previousPeriodTotalExpense) || other.previousPeriodTotalExpense == previousPeriodTotalExpense)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentOverview, currentOverview) || other.currentOverview == currentOverview)&&(identical(other.previousOverview, previousOverview) || other.previousOverview == previousOverview)&&(identical(other.budgetOverview, budgetOverview) || other.budgetOverview == budgetOverview)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_previousPeriodTransactions),const DeepCollectionEquality().hash(_visibleTransactions),isLoadingMore,isRefreshing,hasMore,pageLimit,selectedTabIndex,selectedDate,totalExpense,previousPeriodTotalExpense,status,currentOverview,previousOverview,budgetOverview,errorMessage);

@override
String toString() {
  return 'StatisticState(transactions: $transactions, previousPeriodTransactions: $previousPeriodTransactions, visibleTransactions: $visibleTransactions, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, hasMore: $hasMore, pageLimit: $pageLimit, selectedTabIndex: $selectedTabIndex, selectedDate: $selectedDate, totalExpense: $totalExpense, previousPeriodTotalExpense: $previousPeriodTotalExpense, status: $status, currentOverview: $currentOverview, previousOverview: $previousOverview, budgetOverview: $budgetOverview, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StatisticStateCopyWith<$Res> implements $StatisticStateCopyWith<$Res> {
  factory _$StatisticStateCopyWith(_StatisticState value, $Res Function(_StatisticState) _then) = __$StatisticStateCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionModel> transactions, List<TransactionModel> previousPeriodTransactions, List<TransactionModel> visibleTransactions, bool isLoadingMore, bool isRefreshing, bool hasMore, int pageLimit, int selectedTabIndex, DateTime? selectedDate, double totalExpense, double previousPeriodTotalExpense, StatisticStatus status, StatisticPeriodOverview? currentOverview, StatisticPeriodOverview? previousOverview, StatisticBudgetOverview? budgetOverview, String? errorMessage
});


@override $StatisticPeriodOverviewCopyWith<$Res>? get currentOverview;@override $StatisticPeriodOverviewCopyWith<$Res>? get previousOverview;@override $StatisticBudgetOverviewCopyWith<$Res>? get budgetOverview;

}
/// @nodoc
class __$StatisticStateCopyWithImpl<$Res>
    implements _$StatisticStateCopyWith<$Res> {
  __$StatisticStateCopyWithImpl(this._self, this._then);

  final _StatisticState _self;
  final $Res Function(_StatisticState) _then;

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? previousPeriodTransactions = null,Object? visibleTransactions = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? hasMore = null,Object? pageLimit = null,Object? selectedTabIndex = null,Object? selectedDate = freezed,Object? totalExpense = null,Object? previousPeriodTotalExpense = null,Object? status = null,Object? currentOverview = freezed,Object? previousOverview = freezed,Object? budgetOverview = freezed,Object? errorMessage = freezed,}) {
  return _then(_StatisticState(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,previousPeriodTransactions: null == previousPeriodTransactions ? _self._previousPeriodTransactions : previousPeriodTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,visibleTransactions: null == visibleTransactions ? _self._visibleTransactions : visibleTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,pageLimit: null == pageLimit ? _self.pageLimit : pageLimit // ignore: cast_nullable_to_non_nullable
as int,selectedTabIndex: null == selectedTabIndex ? _self.selectedTabIndex : selectedTabIndex // ignore: cast_nullable_to_non_nullable
as int,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,previousPeriodTotalExpense: null == previousPeriodTotalExpense ? _self.previousPeriodTotalExpense : previousPeriodTotalExpense // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatisticStatus,currentOverview: freezed == currentOverview ? _self.currentOverview : currentOverview // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview?,previousOverview: freezed == previousOverview ? _self.previousOverview : previousOverview // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview?,budgetOverview: freezed == budgetOverview ? _self.budgetOverview : budgetOverview // ignore: cast_nullable_to_non_nullable
as StatisticBudgetOverview?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res>? get currentOverview {
    if (_self.currentOverview == null) {
    return null;
  }

  return $StatisticPeriodOverviewCopyWith<$Res>(_self.currentOverview!, (value) {
    return _then(_self.copyWith(currentOverview: value));
  });
}/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res>? get previousOverview {
    if (_self.previousOverview == null) {
    return null;
  }

  return $StatisticPeriodOverviewCopyWith<$Res>(_self.previousOverview!, (value) {
    return _then(_self.copyWith(previousOverview: value));
  });
}/// Create a copy of StatisticState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticBudgetOverviewCopyWith<$Res>? get budgetOverview {
    if (_self.budgetOverview == null) {
    return null;
  }

  return $StatisticBudgetOverviewCopyWith<$Res>(_self.budgetOverview!, (value) {
    return _then(_self.copyWith(budgetOverview: value));
  });
}
}

// dart format on

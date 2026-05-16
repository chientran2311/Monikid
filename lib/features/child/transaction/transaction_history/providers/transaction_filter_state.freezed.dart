// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionFilterState {

 DateTime? get selectedDate; String? get selectedCategoryKey;// 'all' | 'income' | 'expense'
 String get transactionTypeFilter;
/// Create a copy of TransactionFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFilterStateCopyWith<TransactionFilterState> get copyWith => _$TransactionFilterStateCopyWithImpl<TransactionFilterState>(this as TransactionFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFilterState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedCategoryKey, selectedCategoryKey) || other.selectedCategoryKey == selectedCategoryKey)&&(identical(other.transactionTypeFilter, transactionTypeFilter) || other.transactionTypeFilter == transactionTypeFilter));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate,selectedCategoryKey,transactionTypeFilter);

@override
String toString() {
  return 'TransactionFilterState(selectedDate: $selectedDate, selectedCategoryKey: $selectedCategoryKey, transactionTypeFilter: $transactionTypeFilter)';
}


}

/// @nodoc
abstract mixin class $TransactionFilterStateCopyWith<$Res>  {
  factory $TransactionFilterStateCopyWith(TransactionFilterState value, $Res Function(TransactionFilterState) _then) = _$TransactionFilterStateCopyWithImpl;
@useResult
$Res call({
 DateTime? selectedDate, String? selectedCategoryKey, String transactionTypeFilter
});




}
/// @nodoc
class _$TransactionFilterStateCopyWithImpl<$Res>
    implements $TransactionFilterStateCopyWith<$Res> {
  _$TransactionFilterStateCopyWithImpl(this._self, this._then);

  final TransactionFilterState _self;
  final $Res Function(TransactionFilterState) _then;

/// Create a copy of TransactionFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedDate = freezed,Object? selectedCategoryKey = freezed,Object? transactionTypeFilter = null,}) {
  return _then(_self.copyWith(
selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedCategoryKey: freezed == selectedCategoryKey ? _self.selectedCategoryKey : selectedCategoryKey // ignore: cast_nullable_to_non_nullable
as String?,transactionTypeFilter: null == transactionTypeFilter ? _self.transactionTypeFilter : transactionTypeFilter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _TransactionFilterState extends TransactionFilterState {
  const _TransactionFilterState({this.selectedDate, this.selectedCategoryKey, this.transactionTypeFilter = 'all'}): super._();
  

@override final  DateTime? selectedDate;
@override final  String? selectedCategoryKey;
// 'all' | 'income' | 'expense'
@override@JsonKey() final  String transactionTypeFilter;

/// Create a copy of TransactionFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFilterStateCopyWith<_TransactionFilterState> get copyWith => __$TransactionFilterStateCopyWithImpl<_TransactionFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFilterState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedCategoryKey, selectedCategoryKey) || other.selectedCategoryKey == selectedCategoryKey)&&(identical(other.transactionTypeFilter, transactionTypeFilter) || other.transactionTypeFilter == transactionTypeFilter));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate,selectedCategoryKey,transactionTypeFilter);

@override
String toString() {
  return 'TransactionFilterState(selectedDate: $selectedDate, selectedCategoryKey: $selectedCategoryKey, transactionTypeFilter: $transactionTypeFilter)';
}


}

/// @nodoc
abstract mixin class _$TransactionFilterStateCopyWith<$Res> implements $TransactionFilterStateCopyWith<$Res> {
  factory _$TransactionFilterStateCopyWith(_TransactionFilterState value, $Res Function(_TransactionFilterState) _then) = __$TransactionFilterStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? selectedDate, String? selectedCategoryKey, String transactionTypeFilter
});




}
/// @nodoc
class __$TransactionFilterStateCopyWithImpl<$Res>
    implements _$TransactionFilterStateCopyWith<$Res> {
  __$TransactionFilterStateCopyWithImpl(this._self, this._then);

  final _TransactionFilterState _self;
  final $Res Function(_TransactionFilterState) _then;

/// Create a copy of TransactionFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedDate = freezed,Object? selectedCategoryKey = freezed,Object? transactionTypeFilter = null,}) {
  return _then(_TransactionFilterState(
selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedCategoryKey: freezed == selectedCategoryKey ? _self.selectedCategoryKey : selectedCategoryKey // ignore: cast_nullable_to_non_nullable
as String?,transactionTypeFilter: null == transactionTypeFilter ? _self.transactionTypeFilter : transactionTypeFilter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_statistic_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParentStatisticState {

 ParentStatisticPeriod get period; ParentStatisticStatus get status; String get selectedChildId; int get totalExpenseMinor; int get prevTotalExpenseMinor; List<StatisticDailyExpenseData> get dailyData; List<StatisticCategoryData> get topCategories; String? get errorMessage;
/// Create a copy of ParentStatisticState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentStatisticStateCopyWith<ParentStatisticState> get copyWith => _$ParentStatisticStateCopyWithImpl<ParentStatisticState>(this as ParentStatisticState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentStatisticState&&(identical(other.period, period) || other.period == period)&&(identical(other.status, status) || other.status == status)&&(identical(other.selectedChildId, selectedChildId) || other.selectedChildId == selectedChildId)&&(identical(other.totalExpenseMinor, totalExpenseMinor) || other.totalExpenseMinor == totalExpenseMinor)&&(identical(other.prevTotalExpenseMinor, prevTotalExpenseMinor) || other.prevTotalExpenseMinor == prevTotalExpenseMinor)&&const DeepCollectionEquality().equals(other.dailyData, dailyData)&&const DeepCollectionEquality().equals(other.topCategories, topCategories)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,period,status,selectedChildId,totalExpenseMinor,prevTotalExpenseMinor,const DeepCollectionEquality().hash(dailyData),const DeepCollectionEquality().hash(topCategories),errorMessage);

@override
String toString() {
  return 'ParentStatisticState(period: $period, status: $status, selectedChildId: $selectedChildId, totalExpenseMinor: $totalExpenseMinor, prevTotalExpenseMinor: $prevTotalExpenseMinor, dailyData: $dailyData, topCategories: $topCategories, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ParentStatisticStateCopyWith<$Res>  {
  factory $ParentStatisticStateCopyWith(ParentStatisticState value, $Res Function(ParentStatisticState) _then) = _$ParentStatisticStateCopyWithImpl;
@useResult
$Res call({
 ParentStatisticPeriod period, ParentStatisticStatus status, String selectedChildId, int totalExpenseMinor, int prevTotalExpenseMinor, List<StatisticDailyExpenseData> dailyData, List<StatisticCategoryData> topCategories, String? errorMessage
});




}
/// @nodoc
class _$ParentStatisticStateCopyWithImpl<$Res>
    implements $ParentStatisticStateCopyWith<$Res> {
  _$ParentStatisticStateCopyWithImpl(this._self, this._then);

  final ParentStatisticState _self;
  final $Res Function(ParentStatisticState) _then;

/// Create a copy of ParentStatisticState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? status = null,Object? selectedChildId = null,Object? totalExpenseMinor = null,Object? prevTotalExpenseMinor = null,Object? dailyData = null,Object? topCategories = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ParentStatisticPeriod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentStatisticStatus,selectedChildId: null == selectedChildId ? _self.selectedChildId : selectedChildId // ignore: cast_nullable_to_non_nullable
as String,totalExpenseMinor: null == totalExpenseMinor ? _self.totalExpenseMinor : totalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,prevTotalExpenseMinor: null == prevTotalExpenseMinor ? _self.prevTotalExpenseMinor : prevTotalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,dailyData: null == dailyData ? _self.dailyData : dailyData // ignore: cast_nullable_to_non_nullable
as List<StatisticDailyExpenseData>,topCategories: null == topCategories ? _self.topCategories : topCategories // ignore: cast_nullable_to_non_nullable
as List<StatisticCategoryData>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _ParentStatisticState extends ParentStatisticState {
  const _ParentStatisticState({this.period = ParentStatisticPeriod.month, this.status = ParentStatisticStatus.initial, this.selectedChildId = '', this.totalExpenseMinor = 0, this.prevTotalExpenseMinor = 0, final  List<StatisticDailyExpenseData> dailyData = const [], final  List<StatisticCategoryData> topCategories = const [], this.errorMessage}): _dailyData = dailyData,_topCategories = topCategories,super._();
  

@override@JsonKey() final  ParentStatisticPeriod period;
@override@JsonKey() final  ParentStatisticStatus status;
@override@JsonKey() final  String selectedChildId;
@override@JsonKey() final  int totalExpenseMinor;
@override@JsonKey() final  int prevTotalExpenseMinor;
 final  List<StatisticDailyExpenseData> _dailyData;
@override@JsonKey() List<StatisticDailyExpenseData> get dailyData {
  if (_dailyData is EqualUnmodifiableListView) return _dailyData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyData);
}

 final  List<StatisticCategoryData> _topCategories;
@override@JsonKey() List<StatisticCategoryData> get topCategories {
  if (_topCategories is EqualUnmodifiableListView) return _topCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topCategories);
}

@override final  String? errorMessage;

/// Create a copy of ParentStatisticState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentStatisticStateCopyWith<_ParentStatisticState> get copyWith => __$ParentStatisticStateCopyWithImpl<_ParentStatisticState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentStatisticState&&(identical(other.period, period) || other.period == period)&&(identical(other.status, status) || other.status == status)&&(identical(other.selectedChildId, selectedChildId) || other.selectedChildId == selectedChildId)&&(identical(other.totalExpenseMinor, totalExpenseMinor) || other.totalExpenseMinor == totalExpenseMinor)&&(identical(other.prevTotalExpenseMinor, prevTotalExpenseMinor) || other.prevTotalExpenseMinor == prevTotalExpenseMinor)&&const DeepCollectionEquality().equals(other._dailyData, _dailyData)&&const DeepCollectionEquality().equals(other._topCategories, _topCategories)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,period,status,selectedChildId,totalExpenseMinor,prevTotalExpenseMinor,const DeepCollectionEquality().hash(_dailyData),const DeepCollectionEquality().hash(_topCategories),errorMessage);

@override
String toString() {
  return 'ParentStatisticState(period: $period, status: $status, selectedChildId: $selectedChildId, totalExpenseMinor: $totalExpenseMinor, prevTotalExpenseMinor: $prevTotalExpenseMinor, dailyData: $dailyData, topCategories: $topCategories, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ParentStatisticStateCopyWith<$Res> implements $ParentStatisticStateCopyWith<$Res> {
  factory _$ParentStatisticStateCopyWith(_ParentStatisticState value, $Res Function(_ParentStatisticState) _then) = __$ParentStatisticStateCopyWithImpl;
@override @useResult
$Res call({
 ParentStatisticPeriod period, ParentStatisticStatus status, String selectedChildId, int totalExpenseMinor, int prevTotalExpenseMinor, List<StatisticDailyExpenseData> dailyData, List<StatisticCategoryData> topCategories, String? errorMessage
});




}
/// @nodoc
class __$ParentStatisticStateCopyWithImpl<$Res>
    implements _$ParentStatisticStateCopyWith<$Res> {
  __$ParentStatisticStateCopyWithImpl(this._self, this._then);

  final _ParentStatisticState _self;
  final $Res Function(_ParentStatisticState) _then;

/// Create a copy of ParentStatisticState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? status = null,Object? selectedChildId = null,Object? totalExpenseMinor = null,Object? prevTotalExpenseMinor = null,Object? dailyData = null,Object? topCategories = null,Object? errorMessage = freezed,}) {
  return _then(_ParentStatisticState(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ParentStatisticPeriod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentStatisticStatus,selectedChildId: null == selectedChildId ? _self.selectedChildId : selectedChildId // ignore: cast_nullable_to_non_nullable
as String,totalExpenseMinor: null == totalExpenseMinor ? _self.totalExpenseMinor : totalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,prevTotalExpenseMinor: null == prevTotalExpenseMinor ? _self.prevTotalExpenseMinor : prevTotalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,dailyData: null == dailyData ? _self._dailyData : dailyData // ignore: cast_nullable_to_non_nullable
as List<StatisticDailyExpenseData>,topCategories: null == topCategories ? _self._topCategories : topCategories // ignore: cast_nullable_to_non_nullable
as List<StatisticCategoryData>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatisticDateRange {

 DateTime get start; DateTime get end;
/// Create a copy of StatisticDateRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticDateRangeCopyWith<StatisticDateRange> get copyWith => _$StatisticDateRangeCopyWithImpl<StatisticDateRange>(this as StatisticDateRange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticDateRange&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'StatisticDateRange(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $StatisticDateRangeCopyWith<$Res>  {
  factory $StatisticDateRangeCopyWith(StatisticDateRange value, $Res Function(StatisticDateRange) _then) = _$StatisticDateRangeCopyWithImpl;
@useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class _$StatisticDateRangeCopyWithImpl<$Res>
    implements $StatisticDateRangeCopyWith<$Res> {
  _$StatisticDateRangeCopyWithImpl(this._self, this._then);

  final StatisticDateRange _self;
  final $Res Function(StatisticDateRange) _then;

/// Create a copy of StatisticDateRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _StatisticDateRange implements StatisticDateRange {
  const _StatisticDateRange({required this.start, required this.end});
  

@override final  DateTime start;
@override final  DateTime end;

/// Create a copy of StatisticDateRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticDateRangeCopyWith<_StatisticDateRange> get copyWith => __$StatisticDateRangeCopyWithImpl<_StatisticDateRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticDateRange&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'StatisticDateRange(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$StatisticDateRangeCopyWith<$Res> implements $StatisticDateRangeCopyWith<$Res> {
  factory _$StatisticDateRangeCopyWith(_StatisticDateRange value, $Res Function(_StatisticDateRange) _then) = __$StatisticDateRangeCopyWithImpl;
@override @useResult
$Res call({
 DateTime start, DateTime end
});




}
/// @nodoc
class __$StatisticDateRangeCopyWithImpl<$Res>
    implements _$StatisticDateRangeCopyWith<$Res> {
  __$StatisticDateRangeCopyWithImpl(this._self, this._then);

  final _StatisticDateRange _self;
  final $Res Function(_StatisticDateRange) _then;

/// Create a copy of StatisticDateRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_StatisticDateRange(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$StatisticDailyExpenseData {

 DateTime get date; int get amountMinor;
/// Create a copy of StatisticDailyExpenseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticDailyExpenseDataCopyWith<StatisticDailyExpenseData> get copyWith => _$StatisticDailyExpenseDataCopyWithImpl<StatisticDailyExpenseData>(this as StatisticDailyExpenseData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticDailyExpenseData&&(identical(other.date, date) || other.date == date)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}


@override
int get hashCode => Object.hash(runtimeType,date,amountMinor);

@override
String toString() {
  return 'StatisticDailyExpenseData(date: $date, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class $StatisticDailyExpenseDataCopyWith<$Res>  {
  factory $StatisticDailyExpenseDataCopyWith(StatisticDailyExpenseData value, $Res Function(StatisticDailyExpenseData) _then) = _$StatisticDailyExpenseDataCopyWithImpl;
@useResult
$Res call({
 DateTime date, int amountMinor
});




}
/// @nodoc
class _$StatisticDailyExpenseDataCopyWithImpl<$Res>
    implements $StatisticDailyExpenseDataCopyWith<$Res> {
  _$StatisticDailyExpenseDataCopyWithImpl(this._self, this._then);

  final StatisticDailyExpenseData _self;
  final $Res Function(StatisticDailyExpenseData) _then;

/// Create a copy of StatisticDailyExpenseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? amountMinor = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _StatisticDailyExpenseData implements StatisticDailyExpenseData {
  const _StatisticDailyExpenseData({required this.date, required this.amountMinor});
  

@override final  DateTime date;
@override final  int amountMinor;

/// Create a copy of StatisticDailyExpenseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticDailyExpenseDataCopyWith<_StatisticDailyExpenseData> get copyWith => __$StatisticDailyExpenseDataCopyWithImpl<_StatisticDailyExpenseData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticDailyExpenseData&&(identical(other.date, date) || other.date == date)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}


@override
int get hashCode => Object.hash(runtimeType,date,amountMinor);

@override
String toString() {
  return 'StatisticDailyExpenseData(date: $date, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class _$StatisticDailyExpenseDataCopyWith<$Res> implements $StatisticDailyExpenseDataCopyWith<$Res> {
  factory _$StatisticDailyExpenseDataCopyWith(_StatisticDailyExpenseData value, $Res Function(_StatisticDailyExpenseData) _then) = __$StatisticDailyExpenseDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int amountMinor
});




}
/// @nodoc
class __$StatisticDailyExpenseDataCopyWithImpl<$Res>
    implements _$StatisticDailyExpenseDataCopyWith<$Res> {
  __$StatisticDailyExpenseDataCopyWithImpl(this._self, this._then);

  final _StatisticDailyExpenseData _self;
  final $Res Function(_StatisticDailyExpenseData) _then;

/// Create a copy of StatisticDailyExpenseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? amountMinor = null,}) {
  return _then(_StatisticDailyExpenseData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StatisticCategoryData {

 String get categoryKey; String get categoryLabel; String? get categoryIcon; int get amountMinor; int get transactionCount; double get shareRatio; StatisticTrendDirection get trendDirection; double? get changePercent; String? get trendLabel;
/// Create a copy of StatisticCategoryData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticCategoryDataCopyWith<StatisticCategoryData> get copyWith => _$StatisticCategoryDataCopyWithImpl<StatisticCategoryData>(this as StatisticCategoryData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticCategoryData&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.shareRatio, shareRatio) || other.shareRatio == shareRatio)&&(identical(other.trendDirection, trendDirection) || other.trendDirection == trendDirection)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.trendLabel, trendLabel) || other.trendLabel == trendLabel));
}


@override
int get hashCode => Object.hash(runtimeType,categoryKey,categoryLabel,categoryIcon,amountMinor,transactionCount,shareRatio,trendDirection,changePercent,trendLabel);

@override
String toString() {
  return 'StatisticCategoryData(categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, amountMinor: $amountMinor, transactionCount: $transactionCount, shareRatio: $shareRatio, trendDirection: $trendDirection, changePercent: $changePercent, trendLabel: $trendLabel)';
}


}

/// @nodoc
abstract mixin class $StatisticCategoryDataCopyWith<$Res>  {
  factory $StatisticCategoryDataCopyWith(StatisticCategoryData value, $Res Function(StatisticCategoryData) _then) = _$StatisticCategoryDataCopyWithImpl;
@useResult
$Res call({
 String categoryKey, String categoryLabel, String? categoryIcon, int amountMinor, int transactionCount, double shareRatio, StatisticTrendDirection trendDirection, double? changePercent, String? trendLabel
});




}
/// @nodoc
class _$StatisticCategoryDataCopyWithImpl<$Res>
    implements $StatisticCategoryDataCopyWith<$Res> {
  _$StatisticCategoryDataCopyWithImpl(this._self, this._then);

  final StatisticCategoryData _self;
  final $Res Function(StatisticCategoryData) _then;

/// Create a copy of StatisticCategoryData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? amountMinor = null,Object? transactionCount = null,Object? shareRatio = null,Object? trendDirection = null,Object? changePercent = freezed,Object? trendLabel = freezed,}) {
  return _then(_self.copyWith(
categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,shareRatio: null == shareRatio ? _self.shareRatio : shareRatio // ignore: cast_nullable_to_non_nullable
as double,trendDirection: null == trendDirection ? _self.trendDirection : trendDirection // ignore: cast_nullable_to_non_nullable
as StatisticTrendDirection,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,trendLabel: freezed == trendLabel ? _self.trendLabel : trendLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _StatisticCategoryData implements StatisticCategoryData {
  const _StatisticCategoryData({required this.categoryKey, required this.categoryLabel, this.categoryIcon, required this.amountMinor, required this.transactionCount, required this.shareRatio, this.trendDirection = StatisticTrendDirection.none, this.changePercent, this.trendLabel});
  

@override final  String categoryKey;
@override final  String categoryLabel;
@override final  String? categoryIcon;
@override final  int amountMinor;
@override final  int transactionCount;
@override final  double shareRatio;
@override@JsonKey() final  StatisticTrendDirection trendDirection;
@override final  double? changePercent;
@override final  String? trendLabel;

/// Create a copy of StatisticCategoryData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticCategoryDataCopyWith<_StatisticCategoryData> get copyWith => __$StatisticCategoryDataCopyWithImpl<_StatisticCategoryData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticCategoryData&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&(identical(other.shareRatio, shareRatio) || other.shareRatio == shareRatio)&&(identical(other.trendDirection, trendDirection) || other.trendDirection == trendDirection)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.trendLabel, trendLabel) || other.trendLabel == trendLabel));
}


@override
int get hashCode => Object.hash(runtimeType,categoryKey,categoryLabel,categoryIcon,amountMinor,transactionCount,shareRatio,trendDirection,changePercent,trendLabel);

@override
String toString() {
  return 'StatisticCategoryData(categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, amountMinor: $amountMinor, transactionCount: $transactionCount, shareRatio: $shareRatio, trendDirection: $trendDirection, changePercent: $changePercent, trendLabel: $trendLabel)';
}


}

/// @nodoc
abstract mixin class _$StatisticCategoryDataCopyWith<$Res> implements $StatisticCategoryDataCopyWith<$Res> {
  factory _$StatisticCategoryDataCopyWith(_StatisticCategoryData value, $Res Function(_StatisticCategoryData) _then) = __$StatisticCategoryDataCopyWithImpl;
@override @useResult
$Res call({
 String categoryKey, String categoryLabel, String? categoryIcon, int amountMinor, int transactionCount, double shareRatio, StatisticTrendDirection trendDirection, double? changePercent, String? trendLabel
});




}
/// @nodoc
class __$StatisticCategoryDataCopyWithImpl<$Res>
    implements _$StatisticCategoryDataCopyWith<$Res> {
  __$StatisticCategoryDataCopyWithImpl(this._self, this._then);

  final _StatisticCategoryData _self;
  final $Res Function(_StatisticCategoryData) _then;

/// Create a copy of StatisticCategoryData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? amountMinor = null,Object? transactionCount = null,Object? shareRatio = null,Object? trendDirection = null,Object? changePercent = freezed,Object? trendLabel = freezed,}) {
  return _then(_StatisticCategoryData(
categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,shareRatio: null == shareRatio ? _self.shareRatio : shareRatio // ignore: cast_nullable_to_non_nullable
as double,trendDirection: null == trendDirection ? _self.trendDirection : trendDirection // ignore: cast_nullable_to_non_nullable
as StatisticTrendDirection,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,trendLabel: freezed == trendLabel ? _self.trendLabel : trendLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$StatisticInsightData {

 String get categoryKey; String get categoryLabel; String? get categoryIcon; StatisticTrendDirection get direction; double get changePercent;
/// Create a copy of StatisticInsightData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<StatisticInsightData> get copyWith => _$StatisticInsightDataCopyWithImpl<StatisticInsightData>(this as StatisticInsightData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticInsightData&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}


@override
int get hashCode => Object.hash(runtimeType,categoryKey,categoryLabel,categoryIcon,direction,changePercent);

@override
String toString() {
  return 'StatisticInsightData(categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, direction: $direction, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class $StatisticInsightDataCopyWith<$Res>  {
  factory $StatisticInsightDataCopyWith(StatisticInsightData value, $Res Function(StatisticInsightData) _then) = _$StatisticInsightDataCopyWithImpl;
@useResult
$Res call({
 String categoryKey, String categoryLabel, String? categoryIcon, StatisticTrendDirection direction, double changePercent
});




}
/// @nodoc
class _$StatisticInsightDataCopyWithImpl<$Res>
    implements $StatisticInsightDataCopyWith<$Res> {
  _$StatisticInsightDataCopyWithImpl(this._self, this._then);

  final StatisticInsightData _self;
  final $Res Function(StatisticInsightData) _then;

/// Create a copy of StatisticInsightData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? direction = null,Object? changePercent = null,}) {
  return _then(_self.copyWith(
categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as StatisticTrendDirection,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _StatisticInsightData implements StatisticInsightData {
  const _StatisticInsightData({required this.categoryKey, required this.categoryLabel, this.categoryIcon, required this.direction, required this.changePercent});
  

@override final  String categoryKey;
@override final  String categoryLabel;
@override final  String? categoryIcon;
@override final  StatisticTrendDirection direction;
@override final  double changePercent;

/// Create a copy of StatisticInsightData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticInsightDataCopyWith<_StatisticInsightData> get copyWith => __$StatisticInsightDataCopyWithImpl<_StatisticInsightData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticInsightData&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.categoryIcon, categoryIcon) || other.categoryIcon == categoryIcon)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}


@override
int get hashCode => Object.hash(runtimeType,categoryKey,categoryLabel,categoryIcon,direction,changePercent);

@override
String toString() {
  return 'StatisticInsightData(categoryKey: $categoryKey, categoryLabel: $categoryLabel, categoryIcon: $categoryIcon, direction: $direction, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class _$StatisticInsightDataCopyWith<$Res> implements $StatisticInsightDataCopyWith<$Res> {
  factory _$StatisticInsightDataCopyWith(_StatisticInsightData value, $Res Function(_StatisticInsightData) _then) = __$StatisticInsightDataCopyWithImpl;
@override @useResult
$Res call({
 String categoryKey, String categoryLabel, String? categoryIcon, StatisticTrendDirection direction, double changePercent
});




}
/// @nodoc
class __$StatisticInsightDataCopyWithImpl<$Res>
    implements _$StatisticInsightDataCopyWith<$Res> {
  __$StatisticInsightDataCopyWithImpl(this._self, this._then);

  final _StatisticInsightData _self;
  final $Res Function(_StatisticInsightData) _then;

/// Create a copy of StatisticInsightData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryKey = null,Object? categoryLabel = null,Object? categoryIcon = freezed,Object? direction = null,Object? changePercent = null,}) {
  return _then(_StatisticInsightData(
categoryKey: null == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,categoryIcon: freezed == categoryIcon ? _self.categoryIcon : categoryIcon // ignore: cast_nullable_to_non_nullable
as String?,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as StatisticTrendDirection,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$StatisticBudgetOverview {

 int? get limitMinor; int? get remainingMinor; int get spentMinor; double get usageRatio; StatisticBudgetStatus get status; StatisticTrendDirection get comparisonDirection; double? get comparisonPercent;
/// Create a copy of StatisticBudgetOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticBudgetOverviewCopyWith<StatisticBudgetOverview> get copyWith => _$StatisticBudgetOverviewCopyWithImpl<StatisticBudgetOverview>(this as StatisticBudgetOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticBudgetOverview&&(identical(other.limitMinor, limitMinor) || other.limitMinor == limitMinor)&&(identical(other.remainingMinor, remainingMinor) || other.remainingMinor == remainingMinor)&&(identical(other.spentMinor, spentMinor) || other.spentMinor == spentMinor)&&(identical(other.usageRatio, usageRatio) || other.usageRatio == usageRatio)&&(identical(other.status, status) || other.status == status)&&(identical(other.comparisonDirection, comparisonDirection) || other.comparisonDirection == comparisonDirection)&&(identical(other.comparisonPercent, comparisonPercent) || other.comparisonPercent == comparisonPercent));
}


@override
int get hashCode => Object.hash(runtimeType,limitMinor,remainingMinor,spentMinor,usageRatio,status,comparisonDirection,comparisonPercent);

@override
String toString() {
  return 'StatisticBudgetOverview(limitMinor: $limitMinor, remainingMinor: $remainingMinor, spentMinor: $spentMinor, usageRatio: $usageRatio, status: $status, comparisonDirection: $comparisonDirection, comparisonPercent: $comparisonPercent)';
}


}

/// @nodoc
abstract mixin class $StatisticBudgetOverviewCopyWith<$Res>  {
  factory $StatisticBudgetOverviewCopyWith(StatisticBudgetOverview value, $Res Function(StatisticBudgetOverview) _then) = _$StatisticBudgetOverviewCopyWithImpl;
@useResult
$Res call({
 int? limitMinor, int? remainingMinor, int spentMinor, double usageRatio, StatisticBudgetStatus status, StatisticTrendDirection comparisonDirection, double? comparisonPercent
});




}
/// @nodoc
class _$StatisticBudgetOverviewCopyWithImpl<$Res>
    implements $StatisticBudgetOverviewCopyWith<$Res> {
  _$StatisticBudgetOverviewCopyWithImpl(this._self, this._then);

  final StatisticBudgetOverview _self;
  final $Res Function(StatisticBudgetOverview) _then;

/// Create a copy of StatisticBudgetOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limitMinor = freezed,Object? remainingMinor = freezed,Object? spentMinor = null,Object? usageRatio = null,Object? status = null,Object? comparisonDirection = null,Object? comparisonPercent = freezed,}) {
  return _then(_self.copyWith(
limitMinor: freezed == limitMinor ? _self.limitMinor : limitMinor // ignore: cast_nullable_to_non_nullable
as int?,remainingMinor: freezed == remainingMinor ? _self.remainingMinor : remainingMinor // ignore: cast_nullable_to_non_nullable
as int?,spentMinor: null == spentMinor ? _self.spentMinor : spentMinor // ignore: cast_nullable_to_non_nullable
as int,usageRatio: null == usageRatio ? _self.usageRatio : usageRatio // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatisticBudgetStatus,comparisonDirection: null == comparisonDirection ? _self.comparisonDirection : comparisonDirection // ignore: cast_nullable_to_non_nullable
as StatisticTrendDirection,comparisonPercent: freezed == comparisonPercent ? _self.comparisonPercent : comparisonPercent // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc


class _StatisticBudgetOverview implements StatisticBudgetOverview {
  const _StatisticBudgetOverview({this.limitMinor, this.remainingMinor, this.spentMinor = 0, this.usageRatio = 0, this.status = StatisticBudgetStatus.noLimit, this.comparisonDirection = StatisticTrendDirection.none, this.comparisonPercent});
  

@override final  int? limitMinor;
@override final  int? remainingMinor;
@override@JsonKey() final  int spentMinor;
@override@JsonKey() final  double usageRatio;
@override@JsonKey() final  StatisticBudgetStatus status;
@override@JsonKey() final  StatisticTrendDirection comparisonDirection;
@override final  double? comparisonPercent;

/// Create a copy of StatisticBudgetOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticBudgetOverviewCopyWith<_StatisticBudgetOverview> get copyWith => __$StatisticBudgetOverviewCopyWithImpl<_StatisticBudgetOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticBudgetOverview&&(identical(other.limitMinor, limitMinor) || other.limitMinor == limitMinor)&&(identical(other.remainingMinor, remainingMinor) || other.remainingMinor == remainingMinor)&&(identical(other.spentMinor, spentMinor) || other.spentMinor == spentMinor)&&(identical(other.usageRatio, usageRatio) || other.usageRatio == usageRatio)&&(identical(other.status, status) || other.status == status)&&(identical(other.comparisonDirection, comparisonDirection) || other.comparisonDirection == comparisonDirection)&&(identical(other.comparisonPercent, comparisonPercent) || other.comparisonPercent == comparisonPercent));
}


@override
int get hashCode => Object.hash(runtimeType,limitMinor,remainingMinor,spentMinor,usageRatio,status,comparisonDirection,comparisonPercent);

@override
String toString() {
  return 'StatisticBudgetOverview(limitMinor: $limitMinor, remainingMinor: $remainingMinor, spentMinor: $spentMinor, usageRatio: $usageRatio, status: $status, comparisonDirection: $comparisonDirection, comparisonPercent: $comparisonPercent)';
}


}

/// @nodoc
abstract mixin class _$StatisticBudgetOverviewCopyWith<$Res> implements $StatisticBudgetOverviewCopyWith<$Res> {
  factory _$StatisticBudgetOverviewCopyWith(_StatisticBudgetOverview value, $Res Function(_StatisticBudgetOverview) _then) = __$StatisticBudgetOverviewCopyWithImpl;
@override @useResult
$Res call({
 int? limitMinor, int? remainingMinor, int spentMinor, double usageRatio, StatisticBudgetStatus status, StatisticTrendDirection comparisonDirection, double? comparisonPercent
});




}
/// @nodoc
class __$StatisticBudgetOverviewCopyWithImpl<$Res>
    implements _$StatisticBudgetOverviewCopyWith<$Res> {
  __$StatisticBudgetOverviewCopyWithImpl(this._self, this._then);

  final _StatisticBudgetOverview _self;
  final $Res Function(_StatisticBudgetOverview) _then;

/// Create a copy of StatisticBudgetOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limitMinor = freezed,Object? remainingMinor = freezed,Object? spentMinor = null,Object? usageRatio = null,Object? status = null,Object? comparisonDirection = null,Object? comparisonPercent = freezed,}) {
  return _then(_StatisticBudgetOverview(
limitMinor: freezed == limitMinor ? _self.limitMinor : limitMinor // ignore: cast_nullable_to_non_nullable
as int?,remainingMinor: freezed == remainingMinor ? _self.remainingMinor : remainingMinor // ignore: cast_nullable_to_non_nullable
as int?,spentMinor: null == spentMinor ? _self.spentMinor : spentMinor // ignore: cast_nullable_to_non_nullable
as int,usageRatio: null == usageRatio ? _self.usageRatio : usageRatio // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatisticBudgetStatus,comparisonDirection: null == comparisonDirection ? _self.comparisonDirection : comparisonDirection // ignore: cast_nullable_to_non_nullable
as StatisticTrendDirection,comparisonPercent: freezed == comparisonPercent ? _self.comparisonPercent : comparisonPercent // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$StatisticPeriodOverview {

 StatisticDateRange get range; int get totalExpenseMinor; int get transactionCount; List<StatisticDailyExpenseData> get dailyExpenses; List<StatisticCategoryData> get categories; StatisticInsightData? get smartInsight; StatisticInsightData? get strongestIncrease; StatisticInsightData? get strongestDecrease;
/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<StatisticPeriodOverview> get copyWith => _$StatisticPeriodOverviewCopyWithImpl<StatisticPeriodOverview>(this as StatisticPeriodOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticPeriodOverview&&(identical(other.range, range) || other.range == range)&&(identical(other.totalExpenseMinor, totalExpenseMinor) || other.totalExpenseMinor == totalExpenseMinor)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&const DeepCollectionEquality().equals(other.dailyExpenses, dailyExpenses)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.smartInsight, smartInsight) || other.smartInsight == smartInsight)&&(identical(other.strongestIncrease, strongestIncrease) || other.strongestIncrease == strongestIncrease)&&(identical(other.strongestDecrease, strongestDecrease) || other.strongestDecrease == strongestDecrease));
}


@override
int get hashCode => Object.hash(runtimeType,range,totalExpenseMinor,transactionCount,const DeepCollectionEquality().hash(dailyExpenses),const DeepCollectionEquality().hash(categories),smartInsight,strongestIncrease,strongestDecrease);

@override
String toString() {
  return 'StatisticPeriodOverview(range: $range, totalExpenseMinor: $totalExpenseMinor, transactionCount: $transactionCount, dailyExpenses: $dailyExpenses, categories: $categories, smartInsight: $smartInsight, strongestIncrease: $strongestIncrease, strongestDecrease: $strongestDecrease)';
}


}

/// @nodoc
abstract mixin class $StatisticPeriodOverviewCopyWith<$Res>  {
  factory $StatisticPeriodOverviewCopyWith(StatisticPeriodOverview value, $Res Function(StatisticPeriodOverview) _then) = _$StatisticPeriodOverviewCopyWithImpl;
@useResult
$Res call({
 StatisticDateRange range, int totalExpenseMinor, int transactionCount, List<StatisticDailyExpenseData> dailyExpenses, List<StatisticCategoryData> categories, StatisticInsightData? smartInsight, StatisticInsightData? strongestIncrease, StatisticInsightData? strongestDecrease
});


$StatisticDateRangeCopyWith<$Res> get range;$StatisticInsightDataCopyWith<$Res>? get smartInsight;$StatisticInsightDataCopyWith<$Res>? get strongestIncrease;$StatisticInsightDataCopyWith<$Res>? get strongestDecrease;

}
/// @nodoc
class _$StatisticPeriodOverviewCopyWithImpl<$Res>
    implements $StatisticPeriodOverviewCopyWith<$Res> {
  _$StatisticPeriodOverviewCopyWithImpl(this._self, this._then);

  final StatisticPeriodOverview _self;
  final $Res Function(StatisticPeriodOverview) _then;

/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? totalExpenseMinor = null,Object? transactionCount = null,Object? dailyExpenses = null,Object? categories = null,Object? smartInsight = freezed,Object? strongestIncrease = freezed,Object? strongestDecrease = freezed,}) {
  return _then(_self.copyWith(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as StatisticDateRange,totalExpenseMinor: null == totalExpenseMinor ? _self.totalExpenseMinor : totalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,dailyExpenses: null == dailyExpenses ? _self.dailyExpenses : dailyExpenses // ignore: cast_nullable_to_non_nullable
as List<StatisticDailyExpenseData>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<StatisticCategoryData>,smartInsight: freezed == smartInsight ? _self.smartInsight : smartInsight // ignore: cast_nullable_to_non_nullable
as StatisticInsightData?,strongestIncrease: freezed == strongestIncrease ? _self.strongestIncrease : strongestIncrease // ignore: cast_nullable_to_non_nullable
as StatisticInsightData?,strongestDecrease: freezed == strongestDecrease ? _self.strongestDecrease : strongestDecrease // ignore: cast_nullable_to_non_nullable
as StatisticInsightData?,
  ));
}
/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticDateRangeCopyWith<$Res> get range {
  
  return $StatisticDateRangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<$Res>? get smartInsight {
    if (_self.smartInsight == null) {
    return null;
  }

  return $StatisticInsightDataCopyWith<$Res>(_self.smartInsight!, (value) {
    return _then(_self.copyWith(smartInsight: value));
  });
}/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<$Res>? get strongestIncrease {
    if (_self.strongestIncrease == null) {
    return null;
  }

  return $StatisticInsightDataCopyWith<$Res>(_self.strongestIncrease!, (value) {
    return _then(_self.copyWith(strongestIncrease: value));
  });
}/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<$Res>? get strongestDecrease {
    if (_self.strongestDecrease == null) {
    return null;
  }

  return $StatisticInsightDataCopyWith<$Res>(_self.strongestDecrease!, (value) {
    return _then(_self.copyWith(strongestDecrease: value));
  });
}
}


/// @nodoc


class _StatisticPeriodOverview implements StatisticPeriodOverview {
  const _StatisticPeriodOverview({required this.range, this.totalExpenseMinor = 0, this.transactionCount = 0, final  List<StatisticDailyExpenseData> dailyExpenses = const [], final  List<StatisticCategoryData> categories = const [], this.smartInsight, this.strongestIncrease, this.strongestDecrease}): _dailyExpenses = dailyExpenses,_categories = categories;
  

@override final  StatisticDateRange range;
@override@JsonKey() final  int totalExpenseMinor;
@override@JsonKey() final  int transactionCount;
 final  List<StatisticDailyExpenseData> _dailyExpenses;
@override@JsonKey() List<StatisticDailyExpenseData> get dailyExpenses {
  if (_dailyExpenses is EqualUnmodifiableListView) return _dailyExpenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyExpenses);
}

 final  List<StatisticCategoryData> _categories;
@override@JsonKey() List<StatisticCategoryData> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  StatisticInsightData? smartInsight;
@override final  StatisticInsightData? strongestIncrease;
@override final  StatisticInsightData? strongestDecrease;

/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticPeriodOverviewCopyWith<_StatisticPeriodOverview> get copyWith => __$StatisticPeriodOverviewCopyWithImpl<_StatisticPeriodOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticPeriodOverview&&(identical(other.range, range) || other.range == range)&&(identical(other.totalExpenseMinor, totalExpenseMinor) || other.totalExpenseMinor == totalExpenseMinor)&&(identical(other.transactionCount, transactionCount) || other.transactionCount == transactionCount)&&const DeepCollectionEquality().equals(other._dailyExpenses, _dailyExpenses)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.smartInsight, smartInsight) || other.smartInsight == smartInsight)&&(identical(other.strongestIncrease, strongestIncrease) || other.strongestIncrease == strongestIncrease)&&(identical(other.strongestDecrease, strongestDecrease) || other.strongestDecrease == strongestDecrease));
}


@override
int get hashCode => Object.hash(runtimeType,range,totalExpenseMinor,transactionCount,const DeepCollectionEquality().hash(_dailyExpenses),const DeepCollectionEquality().hash(_categories),smartInsight,strongestIncrease,strongestDecrease);

@override
String toString() {
  return 'StatisticPeriodOverview(range: $range, totalExpenseMinor: $totalExpenseMinor, transactionCount: $transactionCount, dailyExpenses: $dailyExpenses, categories: $categories, smartInsight: $smartInsight, strongestIncrease: $strongestIncrease, strongestDecrease: $strongestDecrease)';
}


}

/// @nodoc
abstract mixin class _$StatisticPeriodOverviewCopyWith<$Res> implements $StatisticPeriodOverviewCopyWith<$Res> {
  factory _$StatisticPeriodOverviewCopyWith(_StatisticPeriodOverview value, $Res Function(_StatisticPeriodOverview) _then) = __$StatisticPeriodOverviewCopyWithImpl;
@override @useResult
$Res call({
 StatisticDateRange range, int totalExpenseMinor, int transactionCount, List<StatisticDailyExpenseData> dailyExpenses, List<StatisticCategoryData> categories, StatisticInsightData? smartInsight, StatisticInsightData? strongestIncrease, StatisticInsightData? strongestDecrease
});


@override $StatisticDateRangeCopyWith<$Res> get range;@override $StatisticInsightDataCopyWith<$Res>? get smartInsight;@override $StatisticInsightDataCopyWith<$Res>? get strongestIncrease;@override $StatisticInsightDataCopyWith<$Res>? get strongestDecrease;

}
/// @nodoc
class __$StatisticPeriodOverviewCopyWithImpl<$Res>
    implements _$StatisticPeriodOverviewCopyWith<$Res> {
  __$StatisticPeriodOverviewCopyWithImpl(this._self, this._then);

  final _StatisticPeriodOverview _self;
  final $Res Function(_StatisticPeriodOverview) _then;

/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? totalExpenseMinor = null,Object? transactionCount = null,Object? dailyExpenses = null,Object? categories = null,Object? smartInsight = freezed,Object? strongestIncrease = freezed,Object? strongestDecrease = freezed,}) {
  return _then(_StatisticPeriodOverview(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as StatisticDateRange,totalExpenseMinor: null == totalExpenseMinor ? _self.totalExpenseMinor : totalExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,transactionCount: null == transactionCount ? _self.transactionCount : transactionCount // ignore: cast_nullable_to_non_nullable
as int,dailyExpenses: null == dailyExpenses ? _self._dailyExpenses : dailyExpenses // ignore: cast_nullable_to_non_nullable
as List<StatisticDailyExpenseData>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<StatisticCategoryData>,smartInsight: freezed == smartInsight ? _self.smartInsight : smartInsight // ignore: cast_nullable_to_non_nullable
as StatisticInsightData?,strongestIncrease: freezed == strongestIncrease ? _self.strongestIncrease : strongestIncrease // ignore: cast_nullable_to_non_nullable
as StatisticInsightData?,strongestDecrease: freezed == strongestDecrease ? _self.strongestDecrease : strongestDecrease // ignore: cast_nullable_to_non_nullable
as StatisticInsightData?,
  ));
}

/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticDateRangeCopyWith<$Res> get range {
  
  return $StatisticDateRangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<$Res>? get smartInsight {
    if (_self.smartInsight == null) {
    return null;
  }

  return $StatisticInsightDataCopyWith<$Res>(_self.smartInsight!, (value) {
    return _then(_self.copyWith(smartInsight: value));
  });
}/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<$Res>? get strongestIncrease {
    if (_self.strongestIncrease == null) {
    return null;
  }

  return $StatisticInsightDataCopyWith<$Res>(_self.strongestIncrease!, (value) {
    return _then(_self.copyWith(strongestIncrease: value));
  });
}/// Create a copy of StatisticPeriodOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticInsightDataCopyWith<$Res>? get strongestDecrease {
    if (_self.strongestDecrease == null) {
    return null;
  }

  return $StatisticInsightDataCopyWith<$Res>(_self.strongestDecrease!, (value) {
    return _then(_self.copyWith(strongestDecrease: value));
  });
}
}

/// @nodoc
mixin _$StatisticOverviewData {

 StatisticPeriodOverview get currentPeriod; StatisticPeriodOverview get previousPeriod; List<TransactionModel> get currentTransactions; List<TransactionModel> get previousTransactions;
/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticOverviewDataCopyWith<StatisticOverviewData> get copyWith => _$StatisticOverviewDataCopyWithImpl<StatisticOverviewData>(this as StatisticOverviewData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticOverviewData&&(identical(other.currentPeriod, currentPeriod) || other.currentPeriod == currentPeriod)&&(identical(other.previousPeriod, previousPeriod) || other.previousPeriod == previousPeriod)&&const DeepCollectionEquality().equals(other.currentTransactions, currentTransactions)&&const DeepCollectionEquality().equals(other.previousTransactions, previousTransactions));
}


@override
int get hashCode => Object.hash(runtimeType,currentPeriod,previousPeriod,const DeepCollectionEquality().hash(currentTransactions),const DeepCollectionEquality().hash(previousTransactions));

@override
String toString() {
  return 'StatisticOverviewData(currentPeriod: $currentPeriod, previousPeriod: $previousPeriod, currentTransactions: $currentTransactions, previousTransactions: $previousTransactions)';
}


}

/// @nodoc
abstract mixin class $StatisticOverviewDataCopyWith<$Res>  {
  factory $StatisticOverviewDataCopyWith(StatisticOverviewData value, $Res Function(StatisticOverviewData) _then) = _$StatisticOverviewDataCopyWithImpl;
@useResult
$Res call({
 StatisticPeriodOverview currentPeriod, StatisticPeriodOverview previousPeriod, List<TransactionModel> currentTransactions, List<TransactionModel> previousTransactions
});


$StatisticPeriodOverviewCopyWith<$Res> get currentPeriod;$StatisticPeriodOverviewCopyWith<$Res> get previousPeriod;

}
/// @nodoc
class _$StatisticOverviewDataCopyWithImpl<$Res>
    implements $StatisticOverviewDataCopyWith<$Res> {
  _$StatisticOverviewDataCopyWithImpl(this._self, this._then);

  final StatisticOverviewData _self;
  final $Res Function(StatisticOverviewData) _then;

/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPeriod = null,Object? previousPeriod = null,Object? currentTransactions = null,Object? previousTransactions = null,}) {
  return _then(_self.copyWith(
currentPeriod: null == currentPeriod ? _self.currentPeriod : currentPeriod // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview,previousPeriod: null == previousPeriod ? _self.previousPeriod : previousPeriod // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview,currentTransactions: null == currentTransactions ? _self.currentTransactions : currentTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,previousTransactions: null == previousTransactions ? _self.previousTransactions : previousTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,
  ));
}
/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res> get currentPeriod {
  
  return $StatisticPeriodOverviewCopyWith<$Res>(_self.currentPeriod, (value) {
    return _then(_self.copyWith(currentPeriod: value));
  });
}/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res> get previousPeriod {
  
  return $StatisticPeriodOverviewCopyWith<$Res>(_self.previousPeriod, (value) {
    return _then(_self.copyWith(previousPeriod: value));
  });
}
}


/// @nodoc


class _StatisticOverviewData implements StatisticOverviewData {
  const _StatisticOverviewData({required this.currentPeriod, required this.previousPeriod, final  List<TransactionModel> currentTransactions = const [], final  List<TransactionModel> previousTransactions = const []}): _currentTransactions = currentTransactions,_previousTransactions = previousTransactions;
  

@override final  StatisticPeriodOverview currentPeriod;
@override final  StatisticPeriodOverview previousPeriod;
 final  List<TransactionModel> _currentTransactions;
@override@JsonKey() List<TransactionModel> get currentTransactions {
  if (_currentTransactions is EqualUnmodifiableListView) return _currentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentTransactions);
}

 final  List<TransactionModel> _previousTransactions;
@override@JsonKey() List<TransactionModel> get previousTransactions {
  if (_previousTransactions is EqualUnmodifiableListView) return _previousTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousTransactions);
}


/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticOverviewDataCopyWith<_StatisticOverviewData> get copyWith => __$StatisticOverviewDataCopyWithImpl<_StatisticOverviewData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticOverviewData&&(identical(other.currentPeriod, currentPeriod) || other.currentPeriod == currentPeriod)&&(identical(other.previousPeriod, previousPeriod) || other.previousPeriod == previousPeriod)&&const DeepCollectionEquality().equals(other._currentTransactions, _currentTransactions)&&const DeepCollectionEquality().equals(other._previousTransactions, _previousTransactions));
}


@override
int get hashCode => Object.hash(runtimeType,currentPeriod,previousPeriod,const DeepCollectionEquality().hash(_currentTransactions),const DeepCollectionEquality().hash(_previousTransactions));

@override
String toString() {
  return 'StatisticOverviewData(currentPeriod: $currentPeriod, previousPeriod: $previousPeriod, currentTransactions: $currentTransactions, previousTransactions: $previousTransactions)';
}


}

/// @nodoc
abstract mixin class _$StatisticOverviewDataCopyWith<$Res> implements $StatisticOverviewDataCopyWith<$Res> {
  factory _$StatisticOverviewDataCopyWith(_StatisticOverviewData value, $Res Function(_StatisticOverviewData) _then) = __$StatisticOverviewDataCopyWithImpl;
@override @useResult
$Res call({
 StatisticPeriodOverview currentPeriod, StatisticPeriodOverview previousPeriod, List<TransactionModel> currentTransactions, List<TransactionModel> previousTransactions
});


@override $StatisticPeriodOverviewCopyWith<$Res> get currentPeriod;@override $StatisticPeriodOverviewCopyWith<$Res> get previousPeriod;

}
/// @nodoc
class __$StatisticOverviewDataCopyWithImpl<$Res>
    implements _$StatisticOverviewDataCopyWith<$Res> {
  __$StatisticOverviewDataCopyWithImpl(this._self, this._then);

  final _StatisticOverviewData _self;
  final $Res Function(_StatisticOverviewData) _then;

/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPeriod = null,Object? previousPeriod = null,Object? currentTransactions = null,Object? previousTransactions = null,}) {
  return _then(_StatisticOverviewData(
currentPeriod: null == currentPeriod ? _self.currentPeriod : currentPeriod // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview,previousPeriod: null == previousPeriod ? _self.previousPeriod : previousPeriod // ignore: cast_nullable_to_non_nullable
as StatisticPeriodOverview,currentTransactions: null == currentTransactions ? _self._currentTransactions : currentTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,previousTransactions: null == previousTransactions ? _self._previousTransactions : previousTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,
  ));
}

/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res> get currentPeriod {
  
  return $StatisticPeriodOverviewCopyWith<$Res>(_self.currentPeriod, (value) {
    return _then(_self.copyWith(currentPeriod: value));
  });
}/// Create a copy of StatisticOverviewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticPeriodOverviewCopyWith<$Res> get previousPeriod {
  
  return $StatisticPeriodOverviewCopyWith<$Res>(_self.previousPeriod, (value) {
    return _then(_self.copyWith(previousPeriod: value));
  });
}
}

// dart format on

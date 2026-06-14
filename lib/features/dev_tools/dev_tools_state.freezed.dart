// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_tools_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DevToolsState {

 DevToolsOpStatus get faqStatus; String? get faqMessage; DevToolsOpStatus get txStatus; String? get txMessage; DateTime? get selectedDate; String get transactionType; String get selectedCategoryId;
/// Create a copy of DevToolsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DevToolsStateCopyWith<DevToolsState> get copyWith => _$DevToolsStateCopyWithImpl<DevToolsState>(this as DevToolsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DevToolsState&&(identical(other.faqStatus, faqStatus) || other.faqStatus == faqStatus)&&(identical(other.faqMessage, faqMessage) || other.faqMessage == faqMessage)&&(identical(other.txStatus, txStatus) || other.txStatus == txStatus)&&(identical(other.txMessage, txMessage) || other.txMessage == txMessage)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId));
}


@override
int get hashCode => Object.hash(runtimeType,faqStatus,faqMessage,txStatus,txMessage,selectedDate,transactionType,selectedCategoryId);

@override
String toString() {
  return 'DevToolsState(faqStatus: $faqStatus, faqMessage: $faqMessage, txStatus: $txStatus, txMessage: $txMessage, selectedDate: $selectedDate, transactionType: $transactionType, selectedCategoryId: $selectedCategoryId)';
}


}

/// @nodoc
abstract mixin class $DevToolsStateCopyWith<$Res>  {
  factory $DevToolsStateCopyWith(DevToolsState value, $Res Function(DevToolsState) _then) = _$DevToolsStateCopyWithImpl;
@useResult
$Res call({
 DevToolsOpStatus faqStatus, String? faqMessage, DevToolsOpStatus txStatus, String? txMessage, DateTime? selectedDate, String transactionType, String selectedCategoryId
});




}
/// @nodoc
class _$DevToolsStateCopyWithImpl<$Res>
    implements $DevToolsStateCopyWith<$Res> {
  _$DevToolsStateCopyWithImpl(this._self, this._then);

  final DevToolsState _self;
  final $Res Function(DevToolsState) _then;

/// Create a copy of DevToolsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? faqStatus = null,Object? faqMessage = freezed,Object? txStatus = null,Object? txMessage = freezed,Object? selectedDate = freezed,Object? transactionType = null,Object? selectedCategoryId = null,}) {
  return _then(_self.copyWith(
faqStatus: null == faqStatus ? _self.faqStatus : faqStatus // ignore: cast_nullable_to_non_nullable
as DevToolsOpStatus,faqMessage: freezed == faqMessage ? _self.faqMessage : faqMessage // ignore: cast_nullable_to_non_nullable
as String?,txStatus: null == txStatus ? _self.txStatus : txStatus // ignore: cast_nullable_to_non_nullable
as DevToolsOpStatus,txMessage: freezed == txMessage ? _self.txMessage : txMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _DevToolsState extends DevToolsState {
  const _DevToolsState({this.faqStatus = DevToolsOpStatus.initial, this.faqMessage, this.txStatus = DevToolsOpStatus.initial, this.txMessage, this.selectedDate, this.transactionType = 'expense', this.selectedCategoryId = 'expense-an-uong'}): super._();
  

@override@JsonKey() final  DevToolsOpStatus faqStatus;
@override final  String? faqMessage;
@override@JsonKey() final  DevToolsOpStatus txStatus;
@override final  String? txMessage;
@override final  DateTime? selectedDate;
@override@JsonKey() final  String transactionType;
@override@JsonKey() final  String selectedCategoryId;

/// Create a copy of DevToolsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DevToolsStateCopyWith<_DevToolsState> get copyWith => __$DevToolsStateCopyWithImpl<_DevToolsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DevToolsState&&(identical(other.faqStatus, faqStatus) || other.faqStatus == faqStatus)&&(identical(other.faqMessage, faqMessage) || other.faqMessage == faqMessage)&&(identical(other.txStatus, txStatus) || other.txStatus == txStatus)&&(identical(other.txMessage, txMessage) || other.txMessage == txMessage)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId));
}


@override
int get hashCode => Object.hash(runtimeType,faqStatus,faqMessage,txStatus,txMessage,selectedDate,transactionType,selectedCategoryId);

@override
String toString() {
  return 'DevToolsState(faqStatus: $faqStatus, faqMessage: $faqMessage, txStatus: $txStatus, txMessage: $txMessage, selectedDate: $selectedDate, transactionType: $transactionType, selectedCategoryId: $selectedCategoryId)';
}


}

/// @nodoc
abstract mixin class _$DevToolsStateCopyWith<$Res> implements $DevToolsStateCopyWith<$Res> {
  factory _$DevToolsStateCopyWith(_DevToolsState value, $Res Function(_DevToolsState) _then) = __$DevToolsStateCopyWithImpl;
@override @useResult
$Res call({
 DevToolsOpStatus faqStatus, String? faqMessage, DevToolsOpStatus txStatus, String? txMessage, DateTime? selectedDate, String transactionType, String selectedCategoryId
});




}
/// @nodoc
class __$DevToolsStateCopyWithImpl<$Res>
    implements _$DevToolsStateCopyWith<$Res> {
  __$DevToolsStateCopyWithImpl(this._self, this._then);

  final _DevToolsState _self;
  final $Res Function(_DevToolsState) _then;

/// Create a copy of DevToolsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? faqStatus = null,Object? faqMessage = freezed,Object? txStatus = null,Object? txMessage = freezed,Object? selectedDate = freezed,Object? transactionType = null,Object? selectedCategoryId = null,}) {
  return _then(_DevToolsState(
faqStatus: null == faqStatus ? _self.faqStatus : faqStatus // ignore: cast_nullable_to_non_nullable
as DevToolsOpStatus,faqMessage: freezed == faqMessage ? _self.faqMessage : faqMessage // ignore: cast_nullable_to_non_nullable
as String?,txStatus: null == txStatus ? _self.txStatus : txStatus // ignore: cast_nullable_to_non_nullable
as DevToolsOpStatus,txMessage: freezed == txMessage ? _self.txMessage : txMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

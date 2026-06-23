// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ParentHomeState {

 ParentHomeStatus get status; FamilyModel? get family; List<FamilyMemberModel> get members; String? get selectedMemberId; List<TransactionModel> get selectedMemberTransactions; int get selectedMemberExpenseMinor; int get selectedMemberIncomeMinor; int get selectedMemberLimitMinor; int get selectedMemberTodayExpenseMinor; bool get isLoadingMemberData; bool get isCreatingFamily; String? get errorMessage;
/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentHomeStateCopyWith<ParentHomeState> get copyWith => _$ParentHomeStateCopyWithImpl<ParentHomeState>(this as ParentHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentHomeState&&(identical(other.status, status) || other.status == status)&&(identical(other.family, family) || other.family == family)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.selectedMemberId, selectedMemberId) || other.selectedMemberId == selectedMemberId)&&const DeepCollectionEquality().equals(other.selectedMemberTransactions, selectedMemberTransactions)&&(identical(other.selectedMemberExpenseMinor, selectedMemberExpenseMinor) || other.selectedMemberExpenseMinor == selectedMemberExpenseMinor)&&(identical(other.selectedMemberIncomeMinor, selectedMemberIncomeMinor) || other.selectedMemberIncomeMinor == selectedMemberIncomeMinor)&&(identical(other.selectedMemberLimitMinor, selectedMemberLimitMinor) || other.selectedMemberLimitMinor == selectedMemberLimitMinor)&&(identical(other.selectedMemberTodayExpenseMinor, selectedMemberTodayExpenseMinor) || other.selectedMemberTodayExpenseMinor == selectedMemberTodayExpenseMinor)&&(identical(other.isLoadingMemberData, isLoadingMemberData) || other.isLoadingMemberData == isLoadingMemberData)&&(identical(other.isCreatingFamily, isCreatingFamily) || other.isCreatingFamily == isCreatingFamily)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,family,const DeepCollectionEquality().hash(members),selectedMemberId,const DeepCollectionEquality().hash(selectedMemberTransactions),selectedMemberExpenseMinor,selectedMemberIncomeMinor,selectedMemberLimitMinor,selectedMemberTodayExpenseMinor,isLoadingMemberData,isCreatingFamily,errorMessage);

@override
String toString() {
  return 'ParentHomeState(status: $status, family: $family, members: $members, selectedMemberId: $selectedMemberId, selectedMemberTransactions: $selectedMemberTransactions, selectedMemberExpenseMinor: $selectedMemberExpenseMinor, selectedMemberIncomeMinor: $selectedMemberIncomeMinor, selectedMemberLimitMinor: $selectedMemberLimitMinor, selectedMemberTodayExpenseMinor: $selectedMemberTodayExpenseMinor, isLoadingMemberData: $isLoadingMemberData, isCreatingFamily: $isCreatingFamily, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ParentHomeStateCopyWith<$Res>  {
  factory $ParentHomeStateCopyWith(ParentHomeState value, $Res Function(ParentHomeState) _then) = _$ParentHomeStateCopyWithImpl;
@useResult
$Res call({
 ParentHomeStatus status, FamilyModel? family, List<FamilyMemberModel> members, String? selectedMemberId, List<TransactionModel> selectedMemberTransactions, int selectedMemberExpenseMinor, int selectedMemberIncomeMinor, int selectedMemberLimitMinor, int selectedMemberTodayExpenseMinor, bool isLoadingMemberData, bool isCreatingFamily, String? errorMessage
});


$FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class _$ParentHomeStateCopyWithImpl<$Res>
    implements $ParentHomeStateCopyWith<$Res> {
  _$ParentHomeStateCopyWithImpl(this._self, this._then);

  final ParentHomeState _self;
  final $Res Function(ParentHomeState) _then;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? family = freezed,Object? members = null,Object? selectedMemberId = freezed,Object? selectedMemberTransactions = null,Object? selectedMemberExpenseMinor = null,Object? selectedMemberIncomeMinor = null,Object? selectedMemberLimitMinor = null,Object? selectedMemberTodayExpenseMinor = null,Object? isLoadingMemberData = null,Object? isCreatingFamily = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentHomeStatus,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<FamilyMemberModel>,selectedMemberId: freezed == selectedMemberId ? _self.selectedMemberId : selectedMemberId // ignore: cast_nullable_to_non_nullable
as String?,selectedMemberTransactions: null == selectedMemberTransactions ? _self.selectedMemberTransactions : selectedMemberTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,selectedMemberExpenseMinor: null == selectedMemberExpenseMinor ? _self.selectedMemberExpenseMinor : selectedMemberExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,selectedMemberIncomeMinor: null == selectedMemberIncomeMinor ? _self.selectedMemberIncomeMinor : selectedMemberIncomeMinor // ignore: cast_nullable_to_non_nullable
as int,selectedMemberLimitMinor: null == selectedMemberLimitMinor ? _self.selectedMemberLimitMinor : selectedMemberLimitMinor // ignore: cast_nullable_to_non_nullable
as int,selectedMemberTodayExpenseMinor: null == selectedMemberTodayExpenseMinor ? _self.selectedMemberTodayExpenseMinor : selectedMemberTodayExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,isLoadingMemberData: null == isLoadingMemberData ? _self.isLoadingMemberData : isLoadingMemberData // ignore: cast_nullable_to_non_nullable
as bool,isCreatingFamily: null == isCreatingFamily ? _self.isCreatingFamily : isCreatingFamily // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<$Res>? get family {
    if (_self.family == null) {
    return null;
  }

  return $FamilyModelCopyWith<$Res>(_self.family!, (value) {
    return _then(_self.copyWith(family: value));
  });
}
}


/// @nodoc


class _ParentHomeState extends ParentHomeState {
  const _ParentHomeState({this.status = ParentHomeStatus.initial, this.family, final  List<FamilyMemberModel> members = const [], this.selectedMemberId, final  List<TransactionModel> selectedMemberTransactions = const [], this.selectedMemberExpenseMinor = 0, this.selectedMemberIncomeMinor = 0, this.selectedMemberLimitMinor = 0, this.selectedMemberTodayExpenseMinor = 0, this.isLoadingMemberData = false, this.isCreatingFamily = false, this.errorMessage}): _members = members,_selectedMemberTransactions = selectedMemberTransactions,super._();
  

@override@JsonKey() final  ParentHomeStatus status;
@override final  FamilyModel? family;
 final  List<FamilyMemberModel> _members;
@override@JsonKey() List<FamilyMemberModel> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  String? selectedMemberId;
 final  List<TransactionModel> _selectedMemberTransactions;
@override@JsonKey() List<TransactionModel> get selectedMemberTransactions {
  if (_selectedMemberTransactions is EqualUnmodifiableListView) return _selectedMemberTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedMemberTransactions);
}

@override@JsonKey() final  int selectedMemberExpenseMinor;
@override@JsonKey() final  int selectedMemberIncomeMinor;
@override@JsonKey() final  int selectedMemberLimitMinor;
@override@JsonKey() final  int selectedMemberTodayExpenseMinor;
@override@JsonKey() final  bool isLoadingMemberData;
@override@JsonKey() final  bool isCreatingFamily;
@override final  String? errorMessage;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentHomeStateCopyWith<_ParentHomeState> get copyWith => __$ParentHomeStateCopyWithImpl<_ParentHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentHomeState&&(identical(other.status, status) || other.status == status)&&(identical(other.family, family) || other.family == family)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.selectedMemberId, selectedMemberId) || other.selectedMemberId == selectedMemberId)&&const DeepCollectionEquality().equals(other._selectedMemberTransactions, _selectedMemberTransactions)&&(identical(other.selectedMemberExpenseMinor, selectedMemberExpenseMinor) || other.selectedMemberExpenseMinor == selectedMemberExpenseMinor)&&(identical(other.selectedMemberIncomeMinor, selectedMemberIncomeMinor) || other.selectedMemberIncomeMinor == selectedMemberIncomeMinor)&&(identical(other.selectedMemberLimitMinor, selectedMemberLimitMinor) || other.selectedMemberLimitMinor == selectedMemberLimitMinor)&&(identical(other.selectedMemberTodayExpenseMinor, selectedMemberTodayExpenseMinor) || other.selectedMemberTodayExpenseMinor == selectedMemberTodayExpenseMinor)&&(identical(other.isLoadingMemberData, isLoadingMemberData) || other.isLoadingMemberData == isLoadingMemberData)&&(identical(other.isCreatingFamily, isCreatingFamily) || other.isCreatingFamily == isCreatingFamily)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,family,const DeepCollectionEquality().hash(_members),selectedMemberId,const DeepCollectionEquality().hash(_selectedMemberTransactions),selectedMemberExpenseMinor,selectedMemberIncomeMinor,selectedMemberLimitMinor,selectedMemberTodayExpenseMinor,isLoadingMemberData,isCreatingFamily,errorMessage);

@override
String toString() {
  return 'ParentHomeState(status: $status, family: $family, members: $members, selectedMemberId: $selectedMemberId, selectedMemberTransactions: $selectedMemberTransactions, selectedMemberExpenseMinor: $selectedMemberExpenseMinor, selectedMemberIncomeMinor: $selectedMemberIncomeMinor, selectedMemberLimitMinor: $selectedMemberLimitMinor, selectedMemberTodayExpenseMinor: $selectedMemberTodayExpenseMinor, isLoadingMemberData: $isLoadingMemberData, isCreatingFamily: $isCreatingFamily, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ParentHomeStateCopyWith<$Res> implements $ParentHomeStateCopyWith<$Res> {
  factory _$ParentHomeStateCopyWith(_ParentHomeState value, $Res Function(_ParentHomeState) _then) = __$ParentHomeStateCopyWithImpl;
@override @useResult
$Res call({
 ParentHomeStatus status, FamilyModel? family, List<FamilyMemberModel> members, String? selectedMemberId, List<TransactionModel> selectedMemberTransactions, int selectedMemberExpenseMinor, int selectedMemberIncomeMinor, int selectedMemberLimitMinor, int selectedMemberTodayExpenseMinor, bool isLoadingMemberData, bool isCreatingFamily, String? errorMessage
});


@override $FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class __$ParentHomeStateCopyWithImpl<$Res>
    implements _$ParentHomeStateCopyWith<$Res> {
  __$ParentHomeStateCopyWithImpl(this._self, this._then);

  final _ParentHomeState _self;
  final $Res Function(_ParentHomeState) _then;

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? family = freezed,Object? members = null,Object? selectedMemberId = freezed,Object? selectedMemberTransactions = null,Object? selectedMemberExpenseMinor = null,Object? selectedMemberIncomeMinor = null,Object? selectedMemberLimitMinor = null,Object? selectedMemberTodayExpenseMinor = null,Object? isLoadingMemberData = null,Object? isCreatingFamily = null,Object? errorMessage = freezed,}) {
  return _then(_ParentHomeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParentHomeStatus,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<FamilyMemberModel>,selectedMemberId: freezed == selectedMemberId ? _self.selectedMemberId : selectedMemberId // ignore: cast_nullable_to_non_nullable
as String?,selectedMemberTransactions: null == selectedMemberTransactions ? _self._selectedMemberTransactions : selectedMemberTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,selectedMemberExpenseMinor: null == selectedMemberExpenseMinor ? _self.selectedMemberExpenseMinor : selectedMemberExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,selectedMemberIncomeMinor: null == selectedMemberIncomeMinor ? _self.selectedMemberIncomeMinor : selectedMemberIncomeMinor // ignore: cast_nullable_to_non_nullable
as int,selectedMemberLimitMinor: null == selectedMemberLimitMinor ? _self.selectedMemberLimitMinor : selectedMemberLimitMinor // ignore: cast_nullable_to_non_nullable
as int,selectedMemberTodayExpenseMinor: null == selectedMemberTodayExpenseMinor ? _self.selectedMemberTodayExpenseMinor : selectedMemberTodayExpenseMinor // ignore: cast_nullable_to_non_nullable
as int,isLoadingMemberData: null == isLoadingMemberData ? _self.isLoadingMemberData : isLoadingMemberData // ignore: cast_nullable_to_non_nullable
as bool,isCreatingFamily: null == isCreatingFamily ? _self.isCreatingFamily : isCreatingFamily // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ParentHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FamilyModelCopyWith<$Res>? get family {
    if (_self.family == null) {
    return null;
  }

  return $FamilyModelCopyWith<$Res>(_self.family!, (value) {
    return _then(_self.copyWith(family: value));
  });
}
}

// dart format on

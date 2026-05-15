// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FamilyManagementState {

 FamilyManagementStatus get status; FamilyModel? get family; List<FamilyMemberModel> get members; String? get errorMessage; bool get isProcessing;
/// Create a copy of FamilyManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyManagementStateCopyWith<FamilyManagementState> get copyWith => _$FamilyManagementStateCopyWithImpl<FamilyManagementState>(this as FamilyManagementState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyManagementState&&(identical(other.status, status) || other.status == status)&&(identical(other.family, family) || other.family == family)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing));
}


@override
int get hashCode => Object.hash(runtimeType,status,family,const DeepCollectionEquality().hash(members),errorMessage,isProcessing);

@override
String toString() {
  return 'FamilyManagementState(status: $status, family: $family, members: $members, errorMessage: $errorMessage, isProcessing: $isProcessing)';
}


}

/// @nodoc
abstract mixin class $FamilyManagementStateCopyWith<$Res>  {
  factory $FamilyManagementStateCopyWith(FamilyManagementState value, $Res Function(FamilyManagementState) _then) = _$FamilyManagementStateCopyWithImpl;
@useResult
$Res call({
 FamilyManagementStatus status, FamilyModel? family, List<FamilyMemberModel> members, String? errorMessage, bool isProcessing
});


$FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class _$FamilyManagementStateCopyWithImpl<$Res>
    implements $FamilyManagementStateCopyWith<$Res> {
  _$FamilyManagementStateCopyWithImpl(this._self, this._then);

  final FamilyManagementState _self;
  final $Res Function(FamilyManagementState) _then;

/// Create a copy of FamilyManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? family = freezed,Object? members = null,Object? errorMessage = freezed,Object? isProcessing = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FamilyManagementStatus,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<FamilyMemberModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of FamilyManagementState
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


class _FamilyManagementState extends FamilyManagementState {
  const _FamilyManagementState({this.status = FamilyManagementStatus.initial, this.family, final  List<FamilyMemberModel> members = const [], this.errorMessage, this.isProcessing = false}): _members = members,super._();
  

@override@JsonKey() final  FamilyManagementStatus status;
@override final  FamilyModel? family;
 final  List<FamilyMemberModel> _members;
@override@JsonKey() List<FamilyMemberModel> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  String? errorMessage;
@override@JsonKey() final  bool isProcessing;

/// Create a copy of FamilyManagementState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyManagementStateCopyWith<_FamilyManagementState> get copyWith => __$FamilyManagementStateCopyWithImpl<_FamilyManagementState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyManagementState&&(identical(other.status, status) || other.status == status)&&(identical(other.family, family) || other.family == family)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing));
}


@override
int get hashCode => Object.hash(runtimeType,status,family,const DeepCollectionEquality().hash(_members),errorMessage,isProcessing);

@override
String toString() {
  return 'FamilyManagementState(status: $status, family: $family, members: $members, errorMessage: $errorMessage, isProcessing: $isProcessing)';
}


}

/// @nodoc
abstract mixin class _$FamilyManagementStateCopyWith<$Res> implements $FamilyManagementStateCopyWith<$Res> {
  factory _$FamilyManagementStateCopyWith(_FamilyManagementState value, $Res Function(_FamilyManagementState) _then) = __$FamilyManagementStateCopyWithImpl;
@override @useResult
$Res call({
 FamilyManagementStatus status, FamilyModel? family, List<FamilyMemberModel> members, String? errorMessage, bool isProcessing
});


@override $FamilyModelCopyWith<$Res>? get family;

}
/// @nodoc
class __$FamilyManagementStateCopyWithImpl<$Res>
    implements _$FamilyManagementStateCopyWith<$Res> {
  __$FamilyManagementStateCopyWithImpl(this._self, this._then);

  final _FamilyManagementState _self;
  final $Res Function(_FamilyManagementState) _then;

/// Create a copy of FamilyManagementState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? family = freezed,Object? members = null,Object? errorMessage = freezed,Object? isProcessing = null,}) {
  return _then(_FamilyManagementState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FamilyManagementStatus,family: freezed == family ? _self.family : family // ignore: cast_nullable_to_non_nullable
as FamilyModel?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<FamilyMemberModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FamilyManagementState
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

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangeProfileState {

 ProfileModel? get profile; bool get isLoading; bool get isSaving; String? get errorMessage; bool get saveSuccess;
/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeProfileStateCopyWith<ChangeProfileState> get copyWith => _$ChangeProfileStateCopyWithImpl<ChangeProfileState>(this as ChangeProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSuccess, saveSuccess) || other.saveSuccess == saveSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,profile,isLoading,isSaving,errorMessage,saveSuccess);

@override
String toString() {
  return 'ChangeProfileState(profile: $profile, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage, saveSuccess: $saveSuccess)';
}


}

/// @nodoc
abstract mixin class $ChangeProfileStateCopyWith<$Res>  {
  factory $ChangeProfileStateCopyWith(ChangeProfileState value, $Res Function(ChangeProfileState) _then) = _$ChangeProfileStateCopyWithImpl;
@useResult
$Res call({
 ProfileModel? profile, bool isLoading, bool isSaving, String? errorMessage, bool saveSuccess
});


$ProfileModelCopyWith<$Res>? get profile;

}
/// @nodoc
class _$ChangeProfileStateCopyWithImpl<$Res>
    implements $ChangeProfileStateCopyWith<$Res> {
  _$ChangeProfileStateCopyWithImpl(this._self, this._then);

  final ChangeProfileState _self;
  final $Res Function(ChangeProfileState) _then;

/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,Object? saveSuccess = null,}) {
  return _then(_self.copyWith(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileModel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSuccess: null == saveSuccess ? _self.saveSuccess : saveSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileModelCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// @nodoc


class _ChangeProfileState extends ChangeProfileState {
  const _ChangeProfileState({this.profile, this.isLoading = false, this.isSaving = false, this.errorMessage, this.saveSuccess = false}): super._();
  

@override final  ProfileModel? profile;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? errorMessage;
@override@JsonKey() final  bool saveSuccess;

/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeProfileStateCopyWith<_ChangeProfileState> get copyWith => __$ChangeProfileStateCopyWithImpl<_ChangeProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSuccess, saveSuccess) || other.saveSuccess == saveSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,profile,isLoading,isSaving,errorMessage,saveSuccess);

@override
String toString() {
  return 'ChangeProfileState(profile: $profile, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage, saveSuccess: $saveSuccess)';
}


}

/// @nodoc
abstract mixin class _$ChangeProfileStateCopyWith<$Res> implements $ChangeProfileStateCopyWith<$Res> {
  factory _$ChangeProfileStateCopyWith(_ChangeProfileState value, $Res Function(_ChangeProfileState) _then) = __$ChangeProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileModel? profile, bool isLoading, bool isSaving, String? errorMessage, bool saveSuccess
});


@override $ProfileModelCopyWith<$Res>? get profile;

}
/// @nodoc
class __$ChangeProfileStateCopyWithImpl<$Res>
    implements _$ChangeProfileStateCopyWith<$Res> {
  __$ChangeProfileStateCopyWithImpl(this._self, this._then);

  final _ChangeProfileState _self;
  final $Res Function(_ChangeProfileState) _then;

/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? isLoading = null,Object? isSaving = null,Object? errorMessage = freezed,Object? saveSuccess = null,}) {
  return _then(_ChangeProfileState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileModel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveSuccess: null == saveSuccess ? _self.saveSuccess : saveSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileModelCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on

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

 ProfileModel? get profile; ChangeProfileStatus get status; String get fullName; String get phone; String get dob; String get gender; ChangeProfileFieldError? get fullNameError; ChangeProfileFieldError? get phoneError; bool get isFormValid; bool get isSaving; String? get errorMessage; bool get saveSuccess;
/// Create a copy of ChangeProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeProfileStateCopyWith<ChangeProfileState> get copyWith => _$ChangeProfileStateCopyWithImpl<ChangeProfileState>(this as ChangeProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.status, status) || other.status == status)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.fullNameError, fullNameError) || other.fullNameError == fullNameError)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.isFormValid, isFormValid) || other.isFormValid == isFormValid)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSuccess, saveSuccess) || other.saveSuccess == saveSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,profile,status,fullName,phone,dob,gender,fullNameError,phoneError,isFormValid,isSaving,errorMessage,saveSuccess);

@override
String toString() {
  return 'ChangeProfileState(profile: $profile, status: $status, fullName: $fullName, phone: $phone, dob: $dob, gender: $gender, fullNameError: $fullNameError, phoneError: $phoneError, isFormValid: $isFormValid, isSaving: $isSaving, errorMessage: $errorMessage, saveSuccess: $saveSuccess)';
}


}

/// @nodoc
abstract mixin class $ChangeProfileStateCopyWith<$Res>  {
  factory $ChangeProfileStateCopyWith(ChangeProfileState value, $Res Function(ChangeProfileState) _then) = _$ChangeProfileStateCopyWithImpl;
@useResult
$Res call({
 ProfileModel? profile, ChangeProfileStatus status, String fullName, String phone, String dob, String gender, ChangeProfileFieldError? fullNameError, ChangeProfileFieldError? phoneError, bool isFormValid, bool isSaving, String? errorMessage, bool saveSuccess
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
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? status = null,Object? fullName = null,Object? phone = null,Object? dob = null,Object? gender = null,Object? fullNameError = freezed,Object? phoneError = freezed,Object? isFormValid = null,Object? isSaving = null,Object? errorMessage = freezed,Object? saveSuccess = null,}) {
  return _then(_self.copyWith(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChangeProfileStatus,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,fullNameError: freezed == fullNameError ? _self.fullNameError : fullNameError // ignore: cast_nullable_to_non_nullable
as ChangeProfileFieldError?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as ChangeProfileFieldError?,isFormValid: null == isFormValid ? _self.isFormValid : isFormValid // ignore: cast_nullable_to_non_nullable
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
  const _ChangeProfileState({this.profile, this.status = ChangeProfileStatus.initial, this.fullName = '', this.phone = '', this.dob = '', this.gender = '', this.fullNameError, this.phoneError, this.isFormValid = false, this.isSaving = false, this.errorMessage, this.saveSuccess = false}): super._();
  

@override final  ProfileModel? profile;
@override@JsonKey() final  ChangeProfileStatus status;
@override@JsonKey() final  String fullName;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String dob;
@override@JsonKey() final  String gender;
@override final  ChangeProfileFieldError? fullNameError;
@override final  ChangeProfileFieldError? phoneError;
@override@JsonKey() final  bool isFormValid;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.status, status) || other.status == status)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.fullNameError, fullNameError) || other.fullNameError == fullNameError)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.isFormValid, isFormValid) || other.isFormValid == isFormValid)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveSuccess, saveSuccess) || other.saveSuccess == saveSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,profile,status,fullName,phone,dob,gender,fullNameError,phoneError,isFormValid,isSaving,errorMessage,saveSuccess);

@override
String toString() {
  return 'ChangeProfileState(profile: $profile, status: $status, fullName: $fullName, phone: $phone, dob: $dob, gender: $gender, fullNameError: $fullNameError, phoneError: $phoneError, isFormValid: $isFormValid, isSaving: $isSaving, errorMessage: $errorMessage, saveSuccess: $saveSuccess)';
}


}

/// @nodoc
abstract mixin class _$ChangeProfileStateCopyWith<$Res> implements $ChangeProfileStateCopyWith<$Res> {
  factory _$ChangeProfileStateCopyWith(_ChangeProfileState value, $Res Function(_ChangeProfileState) _then) = __$ChangeProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileModel? profile, ChangeProfileStatus status, String fullName, String phone, String dob, String gender, ChangeProfileFieldError? fullNameError, ChangeProfileFieldError? phoneError, bool isFormValid, bool isSaving, String? errorMessage, bool saveSuccess
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
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? status = null,Object? fullName = null,Object? phone = null,Object? dob = null,Object? gender = null,Object? fullNameError = freezed,Object? phoneError = freezed,Object? isFormValid = null,Object? isSaving = null,Object? errorMessage = freezed,Object? saveSuccess = null,}) {
  return _then(_ChangeProfileState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChangeProfileStatus,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,dob: null == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,fullNameError: freezed == fullNameError ? _self.fullNameError : fullNameError // ignore: cast_nullable_to_non_nullable
as ChangeProfileFieldError?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as ChangeProfileFieldError?,isFormValid: null == isFormValid ? _self.isFormValid : isFormValid // ignore: cast_nullable_to_non_nullable
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

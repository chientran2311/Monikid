// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountModel {

 String get uid; String get email; String get displayName; String? get photoUrl; String get role; String? get familyId; String get memberStatus; DateTime get createdAt; DateTime get updatedAt; SpendingAlertModel? get spendingAlert;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.memberStatus, memberStatus) || other.memberStatus == memberStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.spendingAlert, spendingAlert) || other.spendingAlert == spendingAlert));
}


@override
int get hashCode => Object.hash(runtimeType,uid,email,displayName,photoUrl,role,familyId,memberStatus,createdAt,updatedAt,spendingAlert);

@override
String toString() {
  return 'AccountModel(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, role: $role, familyId: $familyId, memberStatus: $memberStatus, createdAt: $createdAt, updatedAt: $updatedAt, spendingAlert: $spendingAlert)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String displayName, String? photoUrl, String role, String? familyId, String memberStatus, DateTime createdAt, DateTime updatedAt, SpendingAlertModel? spendingAlert
});


$SpendingAlertModelCopyWith<$Res>? get spendingAlert;

}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? displayName = null,Object? photoUrl = freezed,Object? role = null,Object? familyId = freezed,Object? memberStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? spendingAlert = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,memberStatus: null == memberStatus ? _self.memberStatus : memberStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,spendingAlert: freezed == spendingAlert ? _self.spendingAlert : spendingAlert // ignore: cast_nullable_to_non_nullable
as SpendingAlertModel?,
  ));
}
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpendingAlertModelCopyWith<$Res>? get spendingAlert {
    if (_self.spendingAlert == null) {
    return null;
  }

  return $SpendingAlertModelCopyWith<$Res>(_self.spendingAlert!, (value) {
    return _then(_self.copyWith(spendingAlert: value));
  });
}
}


/// @nodoc


class _AccountModel extends AccountModel {
  const _AccountModel({required this.uid, required this.email, required this.displayName, this.photoUrl, required this.role, this.familyId, required this.memberStatus, required this.createdAt, required this.updatedAt, this.spendingAlert}): super._();
  

@override final  String uid;
@override final  String email;
@override final  String displayName;
@override final  String? photoUrl;
@override final  String role;
@override final  String? familyId;
@override final  String memberStatus;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SpendingAlertModel? spendingAlert;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.familyId, familyId) || other.familyId == familyId)&&(identical(other.memberStatus, memberStatus) || other.memberStatus == memberStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.spendingAlert, spendingAlert) || other.spendingAlert == spendingAlert));
}


@override
int get hashCode => Object.hash(runtimeType,uid,email,displayName,photoUrl,role,familyId,memberStatus,createdAt,updatedAt,spendingAlert);

@override
String toString() {
  return 'AccountModel(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, role: $role, familyId: $familyId, memberStatus: $memberStatus, createdAt: $createdAt, updatedAt: $updatedAt, spendingAlert: $spendingAlert)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String displayName, String? photoUrl, String role, String? familyId, String memberStatus, DateTime createdAt, DateTime updatedAt, SpendingAlertModel? spendingAlert
});


@override $SpendingAlertModelCopyWith<$Res>? get spendingAlert;

}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? displayName = null,Object? photoUrl = freezed,Object? role = null,Object? familyId = freezed,Object? memberStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? spendingAlert = freezed,}) {
  return _then(_AccountModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,familyId: freezed == familyId ? _self.familyId : familyId // ignore: cast_nullable_to_non_nullable
as String?,memberStatus: null == memberStatus ? _self.memberStatus : memberStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,spendingAlert: freezed == spendingAlert ? _self.spendingAlert : spendingAlert // ignore: cast_nullable_to_non_nullable
as SpendingAlertModel?,
  ));
}

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpendingAlertModelCopyWith<$Res>? get spendingAlert {
    if (_self.spendingAlert == null) {
    return null;
  }

  return $SpendingAlertModelCopyWith<$Res>(_self.spendingAlert!, (value) {
    return _then(_self.copyWith(spendingAlert: value));
  });
}
}

/// @nodoc
mixin _$SpendingAlertModel {

 bool get enabled; int get dailyLimitMinor; int get monthlyLimitMinor;
/// Create a copy of SpendingAlertModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpendingAlertModelCopyWith<SpendingAlertModel> get copyWith => _$SpendingAlertModelCopyWithImpl<SpendingAlertModel>(this as SpendingAlertModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpendingAlertModel&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.dailyLimitMinor, dailyLimitMinor) || other.dailyLimitMinor == dailyLimitMinor)&&(identical(other.monthlyLimitMinor, monthlyLimitMinor) || other.monthlyLimitMinor == monthlyLimitMinor));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,dailyLimitMinor,monthlyLimitMinor);

@override
String toString() {
  return 'SpendingAlertModel(enabled: $enabled, dailyLimitMinor: $dailyLimitMinor, monthlyLimitMinor: $monthlyLimitMinor)';
}


}

/// @nodoc
abstract mixin class $SpendingAlertModelCopyWith<$Res>  {
  factory $SpendingAlertModelCopyWith(SpendingAlertModel value, $Res Function(SpendingAlertModel) _then) = _$SpendingAlertModelCopyWithImpl;
@useResult
$Res call({
 bool enabled, int dailyLimitMinor, int monthlyLimitMinor
});




}
/// @nodoc
class _$SpendingAlertModelCopyWithImpl<$Res>
    implements $SpendingAlertModelCopyWith<$Res> {
  _$SpendingAlertModelCopyWithImpl(this._self, this._then);

  final SpendingAlertModel _self;
  final $Res Function(SpendingAlertModel) _then;

/// Create a copy of SpendingAlertModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? dailyLimitMinor = null,Object? monthlyLimitMinor = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,dailyLimitMinor: null == dailyLimitMinor ? _self.dailyLimitMinor : dailyLimitMinor // ignore: cast_nullable_to_non_nullable
as int,monthlyLimitMinor: null == monthlyLimitMinor ? _self.monthlyLimitMinor : monthlyLimitMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _SpendingAlertModel extends SpendingAlertModel {
  const _SpendingAlertModel({required this.enabled, required this.dailyLimitMinor, required this.monthlyLimitMinor}): super._();
  

@override final  bool enabled;
@override final  int dailyLimitMinor;
@override final  int monthlyLimitMinor;

/// Create a copy of SpendingAlertModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpendingAlertModelCopyWith<_SpendingAlertModel> get copyWith => __$SpendingAlertModelCopyWithImpl<_SpendingAlertModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpendingAlertModel&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.dailyLimitMinor, dailyLimitMinor) || other.dailyLimitMinor == dailyLimitMinor)&&(identical(other.monthlyLimitMinor, monthlyLimitMinor) || other.monthlyLimitMinor == monthlyLimitMinor));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,dailyLimitMinor,monthlyLimitMinor);

@override
String toString() {
  return 'SpendingAlertModel(enabled: $enabled, dailyLimitMinor: $dailyLimitMinor, monthlyLimitMinor: $monthlyLimitMinor)';
}


}

/// @nodoc
abstract mixin class _$SpendingAlertModelCopyWith<$Res> implements $SpendingAlertModelCopyWith<$Res> {
  factory _$SpendingAlertModelCopyWith(_SpendingAlertModel value, $Res Function(_SpendingAlertModel) _then) = __$SpendingAlertModelCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int dailyLimitMinor, int monthlyLimitMinor
});




}
/// @nodoc
class __$SpendingAlertModelCopyWithImpl<$Res>
    implements _$SpendingAlertModelCopyWith<$Res> {
  __$SpendingAlertModelCopyWithImpl(this._self, this._then);

  final _SpendingAlertModel _self;
  final $Res Function(_SpendingAlertModel) _then;

/// Create a copy of SpendingAlertModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? dailyLimitMinor = null,Object? monthlyLimitMinor = null,}) {
  return _then(_SpendingAlertModel(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,dailyLimitMinor: null == dailyLimitMinor ? _self.dailyLimitMinor : dailyLimitMinor // ignore: cast_nullable_to_non_nullable
as int,monthlyLimitMinor: null == monthlyLimitMinor ? _self.monthlyLimitMinor : monthlyLimitMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

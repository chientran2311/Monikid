// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_security_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinSecuritySnapshot {

 String? get pinCodeHash; int get failedCount; DateTime? get lockedUntil;
/// Create a copy of PinSecuritySnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinSecuritySnapshotCopyWith<PinSecuritySnapshot> get copyWith => _$PinSecuritySnapshotCopyWithImpl<PinSecuritySnapshot>(this as PinSecuritySnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinSecuritySnapshot&&(identical(other.pinCodeHash, pinCodeHash) || other.pinCodeHash == pinCodeHash)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.lockedUntil, lockedUntil) || other.lockedUntil == lockedUntil));
}


@override
int get hashCode => Object.hash(runtimeType,pinCodeHash,failedCount,lockedUntil);

@override
String toString() {
  return 'PinSecuritySnapshot(pinCodeHash: $pinCodeHash, failedCount: $failedCount, lockedUntil: $lockedUntil)';
}


}

/// @nodoc
abstract mixin class $PinSecuritySnapshotCopyWith<$Res>  {
  factory $PinSecuritySnapshotCopyWith(PinSecuritySnapshot value, $Res Function(PinSecuritySnapshot) _then) = _$PinSecuritySnapshotCopyWithImpl;
@useResult
$Res call({
 String? pinCodeHash, int failedCount, DateTime? lockedUntil
});




}
/// @nodoc
class _$PinSecuritySnapshotCopyWithImpl<$Res>
    implements $PinSecuritySnapshotCopyWith<$Res> {
  _$PinSecuritySnapshotCopyWithImpl(this._self, this._then);

  final PinSecuritySnapshot _self;
  final $Res Function(PinSecuritySnapshot) _then;

/// Create a copy of PinSecuritySnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinCodeHash = freezed,Object? failedCount = null,Object? lockedUntil = freezed,}) {
  return _then(_self.copyWith(
pinCodeHash: freezed == pinCodeHash ? _self.pinCodeHash : pinCodeHash // ignore: cast_nullable_to_non_nullable
as String?,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,lockedUntil: freezed == lockedUntil ? _self.lockedUntil : lockedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc


class _PinSecuritySnapshot extends PinSecuritySnapshot {
  const _PinSecuritySnapshot({this.pinCodeHash, this.failedCount = 0, this.lockedUntil}): super._();
  

@override final  String? pinCodeHash;
@override@JsonKey() final  int failedCount;
@override final  DateTime? lockedUntil;

/// Create a copy of PinSecuritySnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinSecuritySnapshotCopyWith<_PinSecuritySnapshot> get copyWith => __$PinSecuritySnapshotCopyWithImpl<_PinSecuritySnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinSecuritySnapshot&&(identical(other.pinCodeHash, pinCodeHash) || other.pinCodeHash == pinCodeHash)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.lockedUntil, lockedUntil) || other.lockedUntil == lockedUntil));
}


@override
int get hashCode => Object.hash(runtimeType,pinCodeHash,failedCount,lockedUntil);

@override
String toString() {
  return 'PinSecuritySnapshot(pinCodeHash: $pinCodeHash, failedCount: $failedCount, lockedUntil: $lockedUntil)';
}


}

/// @nodoc
abstract mixin class _$PinSecuritySnapshotCopyWith<$Res> implements $PinSecuritySnapshotCopyWith<$Res> {
  factory _$PinSecuritySnapshotCopyWith(_PinSecuritySnapshot value, $Res Function(_PinSecuritySnapshot) _then) = __$PinSecuritySnapshotCopyWithImpl;
@override @useResult
$Res call({
 String? pinCodeHash, int failedCount, DateTime? lockedUntil
});




}
/// @nodoc
class __$PinSecuritySnapshotCopyWithImpl<$Res>
    implements _$PinSecuritySnapshotCopyWith<$Res> {
  __$PinSecuritySnapshotCopyWithImpl(this._self, this._then);

  final _PinSecuritySnapshot _self;
  final $Res Function(_PinSecuritySnapshot) _then;

/// Create a copy of PinSecuritySnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinCodeHash = freezed,Object? failedCount = null,Object? lockedUntil = freezed,}) {
  return _then(_PinSecuritySnapshot(
pinCodeHash: freezed == pinCodeHash ? _self.pinCodeHash : pinCodeHash // ignore: cast_nullable_to_non_nullable
as String?,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,lockedUntil: freezed == lockedUntil ? _self.lockedUntil : lockedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

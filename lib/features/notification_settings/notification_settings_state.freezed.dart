// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSettingsState {

 NotificationSettingsStatus get status; bool get enabled; int get hour; int get minute; String? get errorMessage;
/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsStateCopyWith<NotificationSettingsState> get copyWith => _$NotificationSettingsStateCopyWithImpl<NotificationSettingsState>(this as NotificationSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsState&&(identical(other.status, status) || other.status == status)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,enabled,hour,minute,errorMessage);

@override
String toString() {
  return 'NotificationSettingsState(status: $status, enabled: $enabled, hour: $hour, minute: $minute, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsStateCopyWith<$Res>  {
  factory $NotificationSettingsStateCopyWith(NotificationSettingsState value, $Res Function(NotificationSettingsState) _then) = _$NotificationSettingsStateCopyWithImpl;
@useResult
$Res call({
 NotificationSettingsStatus status, bool enabled, int hour, int minute, String? errorMessage
});




}
/// @nodoc
class _$NotificationSettingsStateCopyWithImpl<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  _$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final NotificationSettingsState _self;
  final $Res Function(NotificationSettingsState) _then;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? enabled = null,Object? hour = null,Object? minute = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationSettingsStatus,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _NotificationSettingsState extends NotificationSettingsState {
  const _NotificationSettingsState({this.status = NotificationSettingsStatus.initial, this.enabled = false, this.hour = 21, this.minute = 0, this.errorMessage}): super._();
  

@override@JsonKey() final  NotificationSettingsStatus status;
@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int hour;
@override@JsonKey() final  int minute;
@override final  String? errorMessage;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsStateCopyWith<_NotificationSettingsState> get copyWith => __$NotificationSettingsStateCopyWithImpl<_NotificationSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsState&&(identical(other.status, status) || other.status == status)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,enabled,hour,minute,errorMessage);

@override
String toString() {
  return 'NotificationSettingsState(status: $status, enabled: $enabled, hour: $hour, minute: $minute, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsStateCopyWith<$Res> implements $NotificationSettingsStateCopyWith<$Res> {
  factory _$NotificationSettingsStateCopyWith(_NotificationSettingsState value, $Res Function(_NotificationSettingsState) _then) = __$NotificationSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 NotificationSettingsStatus status, bool enabled, int hour, int minute, String? errorMessage
});




}
/// @nodoc
class __$NotificationSettingsStateCopyWithImpl<$Res>
    implements _$NotificationSettingsStateCopyWith<$Res> {
  __$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final _NotificationSettingsState _self;
  final $Res Function(_NotificationSettingsState) _then;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? enabled = null,Object? hour = null,Object? minute = null,Object? errorMessage = freezed,}) {
  return _then(_NotificationSettingsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationSettingsStatus,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

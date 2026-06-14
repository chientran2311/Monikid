// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangeThemeState {

 ThemeMode get themeMode;
/// Create a copy of ChangeThemeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeThemeStateCopyWith<ChangeThemeState> get copyWith => _$ChangeThemeStateCopyWithImpl<ChangeThemeState>(this as ChangeThemeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode);

@override
String toString() {
  return 'ChangeThemeState(themeMode: $themeMode)';
}


}

/// @nodoc
abstract mixin class $ChangeThemeStateCopyWith<$Res>  {
  factory $ChangeThemeStateCopyWith(ChangeThemeState value, $Res Function(ChangeThemeState) _then) = _$ChangeThemeStateCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode
});




}
/// @nodoc
class _$ChangeThemeStateCopyWithImpl<$Res>
    implements $ChangeThemeStateCopyWith<$Res> {
  _$ChangeThemeStateCopyWithImpl(this._self, this._then);

  final ChangeThemeState _self;
  final $Res Function(ChangeThemeState) _then;

/// Create a copy of ChangeThemeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}

}


/// @nodoc


class _ChangeThemeState extends ChangeThemeState {
  const _ChangeThemeState({this.themeMode = ThemeMode.light}): super._();
  

@override@JsonKey() final  ThemeMode themeMode;

/// Create a copy of ChangeThemeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeThemeStateCopyWith<_ChangeThemeState> get copyWith => __$ChangeThemeStateCopyWithImpl<_ChangeThemeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode);

@override
String toString() {
  return 'ChangeThemeState(themeMode: $themeMode)';
}


}

/// @nodoc
abstract mixin class _$ChangeThemeStateCopyWith<$Res> implements $ChangeThemeStateCopyWith<$Res> {
  factory _$ChangeThemeStateCopyWith(_ChangeThemeState value, $Res Function(_ChangeThemeState) _then) = __$ChangeThemeStateCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode
});




}
/// @nodoc
class __$ChangeThemeStateCopyWithImpl<$Res>
    implements _$ChangeThemeStateCopyWith<$Res> {
  __$ChangeThemeStateCopyWithImpl(this._self, this._then);

  final _ChangeThemeState _self;
  final $Res Function(_ChangeThemeState) _then;

/// Create a copy of ChangeThemeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,}) {
  return _then(_ChangeThemeState(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplashState {

 bool get isLoading; int get loadingProgress; SplashRouteTarget get routeTarget;
/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplashStateCopyWith<SplashState> get copyWith => _$SplashStateCopyWithImpl<SplashState>(this as SplashState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadingProgress, loadingProgress) || other.loadingProgress == loadingProgress)&&(identical(other.routeTarget, routeTarget) || other.routeTarget == routeTarget));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,loadingProgress,routeTarget);

@override
String toString() {
  return 'SplashState(isLoading: $isLoading, loadingProgress: $loadingProgress, routeTarget: $routeTarget)';
}


}

/// @nodoc
abstract mixin class $SplashStateCopyWith<$Res>  {
  factory $SplashStateCopyWith(SplashState value, $Res Function(SplashState) _then) = _$SplashStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, int loadingProgress, SplashRouteTarget routeTarget
});




}
/// @nodoc
class _$SplashStateCopyWithImpl<$Res>
    implements $SplashStateCopyWith<$Res> {
  _$SplashStateCopyWithImpl(this._self, this._then);

  final SplashState _self;
  final $Res Function(SplashState) _then;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? loadingProgress = null,Object? routeTarget = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingProgress: null == loadingProgress ? _self.loadingProgress : loadingProgress // ignore: cast_nullable_to_non_nullable
as int,routeTarget: null == routeTarget ? _self.routeTarget : routeTarget // ignore: cast_nullable_to_non_nullable
as SplashRouteTarget,
  ));
}

}


/// @nodoc


class _SplashState implements SplashState {
  const _SplashState({this.isLoading = true, this.loadingProgress = 0, this.routeTarget = SplashRouteTarget.none});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int loadingProgress;
@override@JsonKey() final  SplashRouteTarget routeTarget;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplashStateCopyWith<_SplashState> get copyWith => __$SplashStateCopyWithImpl<_SplashState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplashState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadingProgress, loadingProgress) || other.loadingProgress == loadingProgress)&&(identical(other.routeTarget, routeTarget) || other.routeTarget == routeTarget));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,loadingProgress,routeTarget);

@override
String toString() {
  return 'SplashState(isLoading: $isLoading, loadingProgress: $loadingProgress, routeTarget: $routeTarget)';
}


}

/// @nodoc
abstract mixin class _$SplashStateCopyWith<$Res> implements $SplashStateCopyWith<$Res> {
  factory _$SplashStateCopyWith(_SplashState value, $Res Function(_SplashState) _then) = __$SplashStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, int loadingProgress, SplashRouteTarget routeTarget
});




}
/// @nodoc
class __$SplashStateCopyWithImpl<$Res>
    implements _$SplashStateCopyWith<$Res> {
  __$SplashStateCopyWithImpl(this._self, this._then);

  final _SplashState _self;
  final $Res Function(_SplashState) _then;

/// Create a copy of SplashState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? loadingProgress = null,Object? routeTarget = null,}) {
  return _then(_SplashState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingProgress: null == loadingProgress ? _self.loadingProgress : loadingProgress // ignore: cast_nullable_to_non_nullable
as int,routeTarget: null == routeTarget ? _self.routeTarget : routeTarget // ignore: cast_nullable_to_non_nullable
as SplashRouteTarget,
  ));
}


}

// dart format on

import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

enum SplashRouteTarget {
  none,
  login,
  pinGateway,
}

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(true) bool isLoading,
    @Default(0) int loadingProgress,
    @Default(SplashRouteTarget.none) SplashRouteTarget routeTarget,
  }) = _SplashState;
}

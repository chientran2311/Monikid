import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(true) bool isLoading,
    @Default(0) int loadingProgress, // Splash progress (0-100)
    @Default(false) bool onboardingComplete,
    @Default(false) bool isAuthenticated,
  }) = _SplashState;
}

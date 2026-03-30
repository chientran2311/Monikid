import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/auth/auth_status.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(true) bool isLoading,
    @Default(0) int loadingProgress, // Splash progress (0-100)
    @Default(false) bool onboardingComplete,
    @Default(AuthStatus.initial) AuthStatus authStatus,
  }) = _SplashState;
}

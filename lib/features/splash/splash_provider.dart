import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/core/di/locator.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/features/auth/providers/auth_state.dart';

import 'splash_state.dart';

part 'splash_provider.g.dart';

@Riverpod(keepAlive: true)
class SplashNotifier extends _$SplashNotifier {
  @override
  SplashState build() {
    return const SplashState();
  }

  /// Initialize necessary services, update progress, and determine initial state
  Future<void> init() async {
    print(
      "SPLASH: init() called. Current state - isLoading: ${state.isLoading}, progress: ${state.loadingProgress}",
    );
    // Reset progress on init
    state = state.copyWith(isLoading: true, loadingProgress: 0);

    try {
      // Step 1: Initialize local storage
      final localStorage = getIt<AppLocalStorage>();
      state = state.copyWith(loadingProgress: 30);
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Small delay for UX

      // Check onboarding status
      final isComplete =
          localStorage.readSync(StorageKeys.onboardCompleteKey) == 'true';
      state = state.copyWith(onboardingComplete: isComplete);

      // Step 2: Check secure storage and auth state
      // We could check if token/pin exists here if needed to prep
      state = state.copyWith(loadingProgress: 60);
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Small delay for UX

      // Step 3: Wait for auth provider to properly determine if user is authenticated
      // Wait for auth provider to not be in initial status
      int waits = 0;
      while (ref.read(authProvider).status == AuthStatus.initial &&
          waits < 10) {
        await Future.delayed(const Duration(milliseconds: 200));
        waits++;
      }

      final authStatus = ref.read(authProvider).status;
      state = state.copyWith(
        loadingProgress: 100,
        isAuthenticated: authStatus == AuthStatus.authenticated,
      );

      await Future.delayed(
        const Duration(milliseconds: 200),
      ); // Let the bar fill
    } catch (e) {
      // In case of error, just proceed to login as safe fallback
      state = state.copyWith(loadingProgress: 100, onboardingComplete: true);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

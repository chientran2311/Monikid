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
    // Nếu đã tải xong rồi (ví dụ: sau khi đăng nhập và quay lại splash)
    // thì bỏ qua để tránh duplicate loading animation
    if (state.loadingProgress == 100 && !state.isLoading) {
      _navigateOut();
      return;
    }

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
      state = state.copyWith(loadingProgress: 60);
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Small delay for UX

      // Step 3: Wait for auth provider to properly determine if user is authenticated
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

  /// Navigate out nhưng không chạy lại animation
  void _navigateOut() {
    // Re-check auth for correct redirection
    final authStatus = ref.read(authProvider).status;
    state = state.copyWith(
      isLoading: false,
      loadingProgress: 100,
      isAuthenticated: authStatus == AuthStatus.authenticated,
    );
  }
}

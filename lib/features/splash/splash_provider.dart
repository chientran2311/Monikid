import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/repositories/auth/onboarding_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'splash_state.dart';

part 'splash_provider.g.dart';

@Riverpod(keepAlive: true)
class SplashNotifier extends _$SplashNotifier {
  late final OnboardingRepository _onboardingRepository =
      getIt<OnboardingRepository>();
  late final Logger _logger = getIt<Logger>();

  @override
  SplashState build() {
    return const SplashState();
  }

  Future<void> init() async {
    if (state.loadingProgress == 100 && !state.isLoading) {
      _navigateOut();
      return;
    }

    _logger.i(
      'Splash init bắt đầu. isLoading=${state.isLoading}, progress=${state.loadingProgress}',
    );
    state = state.copyWith(isLoading: true, loadingProgress: 0);

    try {
      state = state.copyWith(loadingProgress: 30);
      await Future.delayed(const Duration(milliseconds: 300));

      final isComplete = await _onboardingRepository.isOnboardingComplete();
      state = state.copyWith(onboardingComplete: isComplete);

      state = state.copyWith(loadingProgress: 60);
      await Future.delayed(const Duration(milliseconds: 300));

      int waits = 0;
      while (ref.read(authSessionProvider).status == AuthStatus.initial &&
          waits < 10) {
        await Future.delayed(const Duration(milliseconds: 200));
        waits++;
      }

      final authStatus = ref.read(authSessionProvider).status;
      state = state.copyWith(
        loadingProgress: 100,
        authStatus: authStatus,
      );

      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e, stackTrace) {
      _logger.e(
        'Splash init lỗi, dùng fallback an toàn cho onboarding.',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        loadingProgress: 100,
        onboardingComplete: false,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void _navigateOut() {
    final authStatus = ref.read(authSessionProvider).status;
    state = state.copyWith(
      isLoading: false,
      loadingProgress: 100,
      authStatus: authStatus,
    );
  }
}

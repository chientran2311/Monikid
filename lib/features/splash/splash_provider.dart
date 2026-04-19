import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/auth/providers/auth_session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'splash_state.dart';

part 'splash_provider.g.dart';

@Riverpod(keepAlive: true)
class SplashNotifier extends _$SplashNotifier {
  late final Logger _logger;
  late final AppLocalStorage _localStorage;

  @override
  SplashState build() {
    _logger = getIt<Logger>();
    _localStorage = getIt<AppLocalStorage>();
    return const SplashState();
  }

  Future<void> validateUserForRoute() async {
    if (state.routeTarget != SplashRouteTarget.none && !state.isLoading) {
      return;
    }

    _logger.i('Start splash route validation.');
    state = state.copyWith(
      isLoading: true,
      loadingProgress: 0,
      routeTarget: SplashRouteTarget.none,
    );

    try {
      state = state.copyWith(loadingProgress: 25);
      await Future.delayed(const Duration(milliseconds: 300));

      final hasSignedInBefore =
          await _localStorage.readBool(StorageKeys.hasSignedInBefore) ?? false;

      if (!hasSignedInBefore) {
        state = state.copyWith(
          isLoading: false,
          loadingProgress: 100,
          routeTarget: SplashRouteTarget.login,
        );
        return;
      }

      state = state.copyWith(loadingProgress: 60);
      await Future.delayed(const Duration(milliseconds: 300));

      final authState = await _waitForResolvedAuthState();
      final routeTarget =
          authState.isAuthenticated
              ? SplashRouteTarget.pinGateway
              : SplashRouteTarget.login;

      state = state.copyWith(
        isLoading: false,
        loadingProgress: 100,
        routeTarget: routeTarget,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Splash route validation failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        loadingProgress: 100,
        routeTarget: SplashRouteTarget.login,
      );
    }
  }

  Future<AuthSessionState> _waitForResolvedAuthState() async {
    var authState = ref.read(authSessionProvider);
    var attempts = 0;

    while ((authState.isInitial || authState.isLoading) && attempts < 15) {
      await Future.delayed(const Duration(milliseconds: 200));
      authState = ref.read(authSessionProvider);
      attempts++;
    }

    return authState;
  }
}

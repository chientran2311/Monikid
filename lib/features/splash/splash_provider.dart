import 'dart:async';

import 'package:logger/logger.dart';

import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/auth_session/auth_session_state.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'splash_state.dart';

part 'splash_provider.g.dart';

const _devForceOnboarding = false;

@Riverpod(keepAlive: true)
class SplashNotifier extends _$SplashNotifier {
  late final Logger _logger;
  late final AppLocalStorage _localStorage;
  late final GeminiAiService _geminiService;
  late final GemmaModelRepository _modelRepository;
  late final AuthRepository _authRepository;

  @override
  SplashState build() {
    _logger = getIt<Logger>();
    _localStorage = getIt<AppLocalStorage>();
    _geminiService = getIt<GeminiAiService>();
    _modelRepository = getIt<GemmaModelRepository>();
    _authRepository = ref.read(authRepositoryProvider);
    return const SplashState();
  }

  Future<void> validateUserForRoute() async {
    if (state.routeTarget != SplashRouteTarget.none && !state.isLoading) {
      return;
    }

    _logger.i('SplashNotifier.validateUserForRoute: start.');
    state = state.copyWith(
      isLoading: true,
      loadingProgress: 0,
      routeTarget: SplashRouteTarget.none,
    );

    try {
      state = state.copyWith(loadingProgress: 25);
      await Future.delayed(const Duration(milliseconds: 300));

      if (_devForceOnboarding) {
        state = state.copyWith(
          isLoading: false,
          loadingProgress: 100,
          routeTarget: SplashRouteTarget.onboarding,
        );
        return;
      }

      // 1. Onboarding check — route first-time users before any auth logic.
      final isOnboarded =
          await _localStorage.readBool(StorageKeys.isOnboarded) ?? false;
      if (!isOnboarded) {
        _logger.i('SplashNotifier.validateUserForRoute: onboarding required.');
        state = state.copyWith(
          isLoading: false,
          loadingProgress: 100,
          routeTarget: SplashRouteTarget.onboarding,
        );
        return;
      }

      state = state.copyWith(loadingProgress: 50);

      // 2. AI readiness check — fire-and-forget, never blocks navigation.
      unawaited(_checkAndSaveAiStatus());

      state = state.copyWith(loadingProgress: 75);
      await Future.delayed(const Duration(milliseconds: 200));

      // 3. Auth resolution.
      // Fast path: Firebase.currentUser is synchronous and reflects the cached
      // session without waiting for the Riverpod state machine. This avoids
      // briefly showing the login screen for already-authenticated users.
      final cachedUser = _authRepository.currentUser;
      final bool isAuthenticated;
      if (cachedUser != null) {
        _logger.i(
          'SplashNotifier.validateUserForRoute: Firebase currentUser present — skip polling.',
        );
        isAuthenticated = true;
      } else {
        // No cached user — wait for Riverpod to fully resolve (handles the
        // sign-in-in-progress and accountIncomplete cases).
        final authState = await _waitForResolvedAuthState();
        isAuthenticated = authState.isAuthenticated;
      }

      if (!isAuthenticated) {
        _logger.i(
          'SplashNotifier.validateUserForRoute: unauthenticated — routing to login.',
        );
        state = state.copyWith(
          isLoading: false,
          loadingProgress: 100,
          routeTarget: SplashRouteTarget.login,
        );
        return;
      }

      // 4. PIN check — decide between create-new vs enter-existing.
      final hasPinCode =
          await ref.read(pinCodeRepositoryProvider).hasPinCode();
      _logger.i(
        'SplashNotifier.validateUserForRoute: authenticated. hasPinCode=$hasPinCode',
      );
      final routeTarget =
          hasPinCode
              ? SplashRouteTarget.enterPinCode
              : SplashRouteTarget.createNewPin;

      state = state.copyWith(
        isLoading: false,
        loadingProgress: 100,
        routeTarget: routeTarget,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'SplashNotifier.validateUserForRoute failed.',
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
    final current = ref.read(authSessionProvider);
    if (!current.isInitial && !current.isLoading) return current;

    final completer = Completer<AuthSessionState>();
    final sub = ref.listen<AuthSessionState>(authSessionProvider, (_, AuthSessionState next) {
      if (!completer.isCompleted && !next.isInitial && !next.isLoading) {
        completer.complete(next);
      }
    });

    try {
      return await completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          _logger.w('SplashNotifier._waitForResolvedAuthState: timed out.');
          return ref.read(authSessionProvider);
        },
      );
    } finally {
      sub.close();
    }
  }

  /// Checks whether a working AI source is available and saves the result to
  /// SharedPreferences under [StorageKeys.activeAiSource]. Runs in background —
  /// never awaited from [validateUserForRoute].
  Future<void> _checkAndSaveAiStatus() async {
    _logger.d('SplashNotifier._checkAndSaveAiStatus: start.');
    try {
      // Check Gemini API key first.
      final hasGeminiFlag =
          await _localStorage.readBool(StorageKeys.hasStoredGeminiApiKey) ??
          false;
      if (hasGeminiFlag) {
        final apiKey = await _geminiService.getStoredApiKey();
        if (apiKey != null) {
          try {
            await _geminiService.validateApiKey(apiKey);
            await _localStorage.write(
              key: StorageKeys.activeAiSource,
              value: 'gemini',
            );
            _logger.i(
              'SplashNotifier._checkAndSaveAiStatus: Gemini AI is active.',
            );
            return;
          } catch (error, stackTrace) {
            _logger.w(
              'SplashNotifier._checkAndSaveAiStatus: Gemini key invalid — falling through.',
              error: error,
              stackTrace: stackTrace,
            );
          }
        }
      }

      // Check local Gemma model.
      final useLocal =
          await _localStorage.readBool(StorageKeys.useLocalModel) ?? false;
      if (useLocal) {
        final isCached = await _modelRepository.isModelCached();
        if (isCached) {
          await _localStorage.write(
            key: StorageKeys.activeAiSource,
            value: 'local',
          );
          _logger.i(
            'SplashNotifier._checkAndSaveAiStatus: local model is active.',
          );
          return;
        }
      }

      await _localStorage.write(
        key: StorageKeys.activeAiSource,
        value: 'none',
      );
      _logger.d('SplashNotifier._checkAndSaveAiStatus: no AI available.');
    } catch (error, stackTrace) {
      _logger.e(
        'SplashNotifier._checkAndSaveAiStatus failed.',
        error: error,
        stackTrace: stackTrace,
      );
      await _localStorage.write(
        key: StorageKeys.activeAiSource,
        value: 'none',
      );
    }
  }
}

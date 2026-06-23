import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_session_state.dart';

part 'auth_session_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  StreamSubscription<User?>? _authSubscription;
  late final AuthRepository _authRepository;
  late final Logger _logger;
  var _isDisposed = false;

  @override
  AuthSessionState build() {
    _authRepository = ref.read(authRepositoryProvider);
    _logger = getIt<Logger>();

    ref.onDispose(() {
      _isDisposed = true;
      _authSubscription?.cancel();
    });

    _initAuthListener();
    onInit();

    return const AuthSessionState();
  }

  void onInit() {
    Future.microtask(() async {
      if (_isDisposed) {
        return;
      }
      await _checkCurrentSession();
    });
  }

  Future<void> refreshSession() async {
    state = state.copyWith(
      status: AuthStatus.initial,
      pinVerificationStatus: PinVerificationStatus.unknown,
      errorMessage: null,
    );
    await _checkCurrentSession();
  }

  Future<void> ensureAuthenticatedSession() async {
    await refreshSession();
    if (state.isAuthenticated) {
      return;
    }

    throw Exception(
      state.errorMessage ?? 'Authentication session was not established.',
    );
  }

  Future<void> signOut() async {
    state = state.copyWith(
      status: AuthStatus.isLoading,
      pinVerificationStatus: PinVerificationStatus.unknown,
      errorMessage: null,
    );

    try {
      // Notif prefs + scheduled alarms are GLOBAL (not scoped per account).
      // Reset them on logout so the next account does not inherit the previous
      // user's enabled flag / scheduled notifications, and is forced to
      // (re)grant OS permission when they toggle ON.
      final prefs = await SharedPreferences.getInstance();
      _logger.i(
        'AuthSession.signOut: notif prefs BEFORE reset — '
        'enabled=${prefs.getBool(NotifPrefsKeys.enabled)} '
        'hour=${prefs.getInt(NotifPrefsKeys.hour)} '
        'minute=${prefs.getInt(NotifPrefsKeys.minute)}',
      );
      try {
        await getIt<NotificationRepository>().cancelAllAndClearData();
        await prefs.remove(NotifPrefsKeys.enabled);
        await prefs.remove(NotifPrefsKeys.hour);
        await prefs.remove(NotifPrefsKeys.minute);
        _logger.i('AuthSession.signOut: notif state reset (cancelled + prefs cleared).');
      } catch (notifError, notifStack) {
        _logger.w(
          'AuthSession.signOut: notif reset failed (non-fatal).',
          error: notifError,
          stackTrace: notifStack,
        );
      }

      await _authRepository.signOut();
      await ref.read(pinCodeRepositoryProvider).clearPinCode();
      state = const AuthSessionState(status: AuthStatus.unauthenticated);
    } catch (e, stackTrace) {
      _setErrorState(
        message: 'Sign out failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  void markPinVerified() {
    // No isAuthenticated guard: the user may have entered their PIN while
    // _handleAuthUserChanged is still loading (Firestore fetch in progress).
    // _handleAuthUserChanged preserves PinVerificationStatus.verified when
    // it resolves, so setting it here is safe even in loading state.
    state = state.copyWith(
      pinVerificationStatus: PinVerificationStatus.verified,
    );
  }

  void requirePinVerification() {
    if (!state.isAuthenticated) {
      return;
    }

    state = state.copyWith(
      pinVerificationStatus: PinVerificationStatus.required,
    );
  }

  void patchAccountFamilyId(String familyId) {
    final account = state.account;
    if (account == null) return;
    state = state.copyWith(account: account.copyWith(familyId: familyId));
  }

  Future<void> _checkCurrentSession() async {
    try {
      final currentUser = _authRepository.currentUser;
      await _handleAuthUserChanged(currentUser);
    } catch (e, stackTrace) {
      _setErrorState(
        message: 'Check current session failed',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void _initAuthListener() {
    try {
      _authSubscription = _authRepository.authStateChanges.listen(
        (user) {
          unawaited(_handleAuthUserChanged(user));
        },
        onError: (Object error, StackTrace stackTrace) {
          _setErrorState(
            message: 'Auth session listener failed',
            error: error,
            stackTrace: stackTrace,
          );
        },
      );
    } catch (e, stackTrace) {
      _setErrorState(
        message: 'Auth session listener failed',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _handleAuthUserChanged(User? user) async {
    if (user == null) {
      _logger.i(
        'Auth session resolved as unauthenticated because Firebase returned no user.',
      );
      state = const AuthSessionState(status: AuthStatus.unauthenticated);
      return;
    }

    state = state.copyWith(
      status: AuthStatus.isLoading,
      firebaseUser: user,
      errorMessage: null,
    );

    try {
      final account = await _authRepository.fetchAccountByUid(user.uid);

      if (account == null) {
        _logger.w(
          'Auth session blocked for uid=${user.uid}: no Firestore account document found.',
        );
        state = AuthSessionState(
          status: AuthStatus.accountIncomplete,
          firebaseUser: user,
          errorMessage: 'Account setup is incomplete.',
        );
        return;
      }

      if (!account.isValid) {
        _logger.w(
          'Auth session blocked for uid=${user.uid}: invalid account document. '
          'Issues: ${account.validationIssues.join(', ')}',
        );
        state = AuthSessionState(
          status: AuthStatus.accountIncomplete,
          firebaseUser: user,
          errorMessage: 'Account setup is incomplete.',
        );
        return;
      }

      _logger.i(
        'Auth session resolved as authenticated for uid=${user.uid} role=${account.role}.',
      );
      final hasPinCode =
          await ref.read(pinCodeRepositoryProvider).hasPinCode();
      state = AuthSessionState(
        status: AuthStatus.isAuthenticated,
        firebaseUser: user,
        account: account,
        // Preserve 'verified' if markPinVerified() was already called
        // (e.g., during concurrent _handleAuthUserChanged calls on startup).
        pinVerificationStatus: state.isPinVerified
            ? PinVerificationStatus.verified
            : PinVerificationStatus.required,
        hasPinCode: hasPinCode,
      );
    } catch (e, stackTrace) {
      _setErrorState(
        message: 'Resolve auth account failed',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void _setErrorState({
    required String message,
    required Object error,
    required StackTrace stackTrace,
  }) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    if (_isDisposed) {
      return;
    }
    state = state.copyWith(
      status: AuthStatus.error,
      errorMessage: error.toString().replaceAll('Exception: ', ''),
    );
  }
}

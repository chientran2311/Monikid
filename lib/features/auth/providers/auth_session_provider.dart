import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';

import 'auth_session_state.dart';

final authSessionProvider =
    NotifierProvider<AuthSessionNotifier, AuthSessionState>(
  AuthSessionNotifier.new,
);

class AuthSessionNotifier extends Notifier<AuthSessionState> {
  StreamSubscription<User?>? _authSubscription;
  late final FirebaseAuth _firebaseAuth;
  late final AuthRepository _authRepository;
  late final Logger _logger;

  @override
  AuthSessionState build() {
    _firebaseAuth = getIt<FirebaseAuth>();
    _authRepository = getIt<AuthRepository>();
    _logger = getIt<Logger>();

    ref.onDispose(() {
      _authSubscription?.cancel();
    });

    _initAuthListener();
    unawaited(_checkCurrentSession());

    return const AuthSessionState();
  }

  Future<void> refreshSession() async {
    state = state.copyWith(
      status: AuthStatus.initial,
      clearErrorMessage: true,
    );
    await _checkCurrentSession();
  }

  Future<void> signOut() async {
    state = state.copyWith(
      status: AuthStatus.isLoading,
      clearErrorMessage: true,
    );

    try {
      _logger.i('Signing out current user');
      await _authRepository.signOut();
      state = const AuthSessionState(status: AuthStatus.unauthenticated);
    } catch (e, stackTrace) {
      _logger.e('Sign out failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }

  Future<void> _checkCurrentSession() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        state = const AuthSessionState(status: AuthStatus.unauthenticated);
        return;
      }

      final role = await _authRepository.getUserRole(currentUser.uid);
      state = AuthSessionState(
        status: AuthStatus.isAuthenticated,
        user: currentUser,
        userRole: role,
      );
    } catch (e, stackTrace) {
      _logger.e('Check current session failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  void _initAuthListener() {
    try {
      _authSubscription = _firebaseAuth.authStateChanges().listen((user) async {
        if (user == null) {
          state = const AuthSessionState(status: AuthStatus.unauthenticated);
          return;
        }

        final role = await _authRepository.getUserRole(user.uid);
        state = AuthSessionState(
          status: AuthStatus.isAuthenticated,
          user: user,
          userRole: role,
        );
      });
    } catch (e, stackTrace) {
      _logger.e('Auth session listener failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

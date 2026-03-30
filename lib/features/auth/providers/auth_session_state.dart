import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:monikid/features/auth/auth_status.dart';

class AuthSessionState {
  const AuthSessionState({
    this.status = AuthStatus.initial,
    this.user,
    this.userRole,
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final String? userRole;
  final String? errorMessage;

  bool get isAuthenticated => status == AuthStatus.isAuthenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isInitial => status == AuthStatus.initial;
  bool get isLoading => status == AuthStatus.isLoading;

  AuthSessionState copyWith({
    AuthStatus? status,
    User? user,
    bool clearUser = false,
    String? userRole,
    bool clearUserRole = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AuthSessionState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      userRole: clearUserRole ? null : (userRole ?? this.userRole),
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

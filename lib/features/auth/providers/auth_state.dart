import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;

part 'auth_state.freezed.dart';

/// Auth status enum để quản lý trạng thái xác thực
enum AuthStatus {
  initial,       // Chưa kiểm tra
  authenticated, // Đã đăng nhập
  unauthenticated, // Chưa đăng nhập
  loading,       // Đang xử lý (login/register/logout)
}

@freezed
abstract class AppAuthState with _$AppAuthState {
  const factory AppAuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    User? user,
    String? errorMessage,
    @Default(false) bool isLoading,
    @Default(false) bool isFirstTime, // Để check show onboarding
  }) = _AppAuthState;

  const AppAuthState._();

  /// Helper getters
  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isInitial => status == AuthStatus.initial;
}

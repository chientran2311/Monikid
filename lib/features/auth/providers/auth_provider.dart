import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'auth_state.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:monikid/repositories/auth/auth_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  StreamSubscription<User?>? _authSubscription;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final AuthRepository _authRepository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  AppAuthState build() {
    // Initialize repository
    _authRepository = AuthRepositoryImpl(_firebaseAuth, FirebaseFirestore.instance);
    
    // Cleanup khi provider bị dispose
    ref.onDispose(() {
      _authSubscription?.cancel();
    });
    
    // Khởi tạo và lắng nghe auth changes
    _initAuthListener();
    
    // Check session hiện tại
    return _checkCurrentSession();
  }

  /// Kiểm tra session hiện tại khi khởi động
  AppAuthState _checkCurrentSession() {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        return AppAuthState(
          status: AuthStatus.authenticated,
          user: currentUser,
        );
      }
      return const AppAuthState(status: AuthStatus.unauthenticated);
    } catch (e) {
      // Firebase chưa khởi tạo
      return const AppAuthState(status: AuthStatus.initial);
    }
  }

  /// Lắng nghe thay đổi auth state từ Firebase
  void _initAuthListener() {
    try {
      _authSubscription = _firebaseAuth.authStateChanges().listen(
        (User? user) {
          if (user != null) {
            state = AppAuthState(
              status: AuthStatus.authenticated,
              user: user,
            );
          } else {
            state = const AppAuthState(status: AuthStatus.unauthenticated);
          }
        },
      );
    } catch (e) {
      // Firebase chưa khởi tạo - bỏ qua
    }
  }

  // ============================================================================
  // PUBLIC METHODS
  // ============================================================================

  /// Đăng nhập với email và password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // Set loading state
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      _logger.i('🔐 Auth Provider: Starting sign in for $email');
      
      final userCredential = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _logger.i('✅ Auth Provider: Sign in successful');
        state = AppAuthState(
          status: AuthStatus.authenticated,
          user: userCredential.user,
          isLoading: false,
        );
      } else {
        _logger.w('⚠️ Auth Provider: Sign in returned null user');
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Sign in failed. Please try again.',
        );
      }
    } on FirebaseAuthException catch (e) {
      _logger.e('❌ Auth Provider: Firebase Auth error - ${e.code}: ${e.message}');
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred during sign in.';
      }
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: errorMessage,
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('❌ Auth Provider: Unexpected error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Đăng ký với email và password
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      _logger.i('📝 Auth Provider: Starting sign up for $email');
      _logger.d('📝 Details - Name: $fullName, Phone: $phone, Role: $role');
      
      // Gọi repository để tạo auth account VÀ sync Firestore
      final userCredential = await _authRepository.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: role,
      );

      if (userCredential.user != null) {
        _logger.i('✅ Auth Provider: Sign up successful');
        _logger.i('💾 Firestore sync completed by repository');
        
        // Update display name
        await userCredential.user!.updateDisplayName(fullName);
        
        // Reload user to get updated info
        await userCredential.user!.reload();
        final updatedUser = _firebaseAuth.currentUser;

        state = AppAuthState(
          status: AuthStatus.authenticated,
          user: updatedUser,
          isLoading: false,
        );
      } else {
        _logger.w('⚠️ Auth Provider: Sign up returned null user');
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Sign up failed. Please try again.',
        );
      }
    } on FirebaseAuthException catch (e) {
      _logger.e('❌ Auth Provider: Firebase Auth error - ${e.code}: ${e.message}');
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak. Use at least 6 characters.';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred during sign up.';
      }
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: errorMessage,
      );
      rethrow;
    } on FirebaseException catch (e) {
      _logger.e('❌ Auth Provider: Firestore error - ${e.code}: ${e.message}');
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        errorMessage: 'Failed to sync user data: ${e.message}',
      );
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('❌ Auth Provider: Unexpected error', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Đăng xuất
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    try {
      _logger.i('🚪 Auth Provider: Signing out');
      await _authRepository.signOut();
      state = const AppAuthState(status: AuthStatus.unauthenticated);
      _logger.i('✅ Auth Provider: Sign out successful');
    } catch (e, stackTrace) {
      _logger.e('❌ Auth Provider: Sign out failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Sign out failed: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Reset state về initial (dùng khi cần re-check auth)
  void reset() {
    state = _checkCurrentSession();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

import 'login_state.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/utils/validators.dart';
import 'package:monikid/features/auth/domain/params/auth_param.dart';
import 'package:monikid/features/auth/providers/auth_provider.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
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
  LoginState build() {
    _authRepository = getIt<AuthRepository>();
    return const LoginState();
  }

  /// Thay đổi role được chọn trên UI (parent / student)
  void setRole(String role) {
    state = state.copyWith(selectedRole: role, errorMessage: null);
  }

  /// Xóa thông báo lỗi
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Đăng nhập: validate → fetch role từ email → so sánh → signIn Firebase
  Future<void> signIn({required String email, required String password}) async {
    // --- 1. Local validation ---
    final emailError = Validators.email(email);
    if (emailError != null) {
      state = state.copyWith(errorMessage: emailError);
      return;
    }
    final passwordError = Validators.password(password);
    if (passwordError != null) {
      state = state.copyWith(errorMessage: passwordError);
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // --- 2. Fetch role từ Firestore theo email TRƯỚC khi login ---
      _logger.i('🔍 Login Provider: Fetching role for email: $email');
      final existingRole = await _authRepository.getRoleByEmail(email.trim());

      // --- 3. Validate role mismatch ---
      final mismatchError = Validators.roleEmailMismatch(
        existingRole: existingRole,
        selectedRole: state.selectedRole,
      );
      if (mismatchError != null) {
        _logger.w('⚠️ Login Provider: Role mismatch — $mismatchError');
        state = state.copyWith(isLoading: false, errorMessage: mismatchError);
        return;
      }

      // --- 4. Tài khoản chưa tồn tại hoặc role khớp → tiến hành đăng nhập ---
      if (existingRole == null) {
        // Email không tồn tại trong Firestore
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Không tìm thấy người dùng với email này.',
        );
        return;
      }

      _logger.i(
        '✅ Login Provider: Role verified ($existingRole). Signing in...',
      );
      await ref
          .read(authProvider.notifier)
          .validateUser(
            SignInParam(
              email: email.trim(),
              password: password,
              selectedRole: state.selectedRole,
            ),
          );

      _logger.i('✅ Login Provider: Sign in successful');
      state = state.copyWith(isLoading: false);
    } on FirebaseAuthException catch (e) {
      _logger.e('❌ Login Provider: FirebaseAuthException: ${e.code}');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapFirebaseError(e),
      );
    } catch (e) {
      _logger.e('❌ Login Provider: Error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Không tìm thấy người dùng với email này.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email hoặc mật khẩu không chính xác.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      case 'too-many-requests':
        return 'Quá nhiều lần đăng nhập thất bại. Vui lòng thử lại sau.';
      default:
        return e.message ?? 'Đã xảy ra lỗi hệ thống.';
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:monikid/features/auth/domain/params/auth_param.dart';
import 'package:monikid/features/auth/domain/responses/auth_response.dart';

abstract class AuthRepository {
  User? get currentUser;

  Stream<User?> get authStateChanges;

  Future<AuthResponse> signUp(SignUpParam param);

  Future<AuthResponse> signIn(SignInParam param);

  Future<void> signOut();

  /// Gửi email đặt lại mật khẩu qua Firebase
  Future<void> resetPassword(ResetPasswordParam param);

  /// Lấy role của user từ Firestore theo UID
  Future<String?> getUserRole(String uid);

  /// Lấy role của user từ Firestore theo email (dùng trước khi đăng nhập)
  Future<String?> getRoleByEmail(String email);
}

import 'package:injectable/injectable.dart'; // Cần import cái này cho @LazySingleton
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  // Injectable sẽ tự tìm SupabaseClient (nhờ Module ở bước 3)
  AuthRepositoryImpl(this._supabaseClient);

  // 1. Getter: Lấy user hiện tại
  @override
  User? get currentUser => _supabaseClient.auth.currentUser;

  // 2. Getter: Lắng nghe trạng thái đăng nhập
  @override
  Stream<AuthState> get authStateChanges => _supabaseClient.auth.onAuthStateChange;

  // 3. Hàm Đăng nhập
  @override
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // 4. Hàm Đăng ký (Đã sửa để gửi metadata)
  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'phone': phone,
        'role': role, // Quan trọng: Để trigger SQL biết user là parent hay child
      },
    );
  }

  // 5. Hàm Đăng xuất
  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
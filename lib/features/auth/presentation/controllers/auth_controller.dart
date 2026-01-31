import 'package:monikid/features/auth/presentation/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Dòng này phải trùng tên file: auth_controller -> auth_controller.g.dart
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // Khởi tạo state ban đầu là null (không làm gì cả)
    return null;
  }

  // Hàm Đăng nhập
  Future<void> login({required String email, required String password}) async {
    // Set state thành loading
    state = const AsyncLoading();
    
    // Thực hiện logic và bắt lỗi
    state = await AsyncValue.guard(() async {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signIn(email: email, password: password);
    });
  }

  // Hàm Đăng ký
  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: role,
      );
    });
  }
  
  // Hàm Đăng xuất
  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
       final authRepo = ref.read(authRepositoryProvider);
       await authRepo.signOut();
    });
  }
}
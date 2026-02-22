/// Validators — Kiểm tra đầu vào cho form auth và các input khác
/// Dùng với CustomInputField.validator hoặc gọi trực tiếp trong logic.
/// Error messages bằng tiếng Việt, chuẩn bị cho SnackBar widget (sẽ tạo sau).
class Validators {
  Validators._(); // Không cho khởi tạo

  // ========== EMAIL ==========

  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Validate email — dùng cho Login, Register, ForgotPassword
  /// Returns null nếu hợp lệ, String lỗi nếu không hợp lệ
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Email không đúng định dạng';
    }
    return null;
  }

  // ========== MẬT KHẨU ==========

  /// Validate mật khẩu — dùng cho Login
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  /// Validate mật khẩu mạnh — dùng cho Register, UpdatePassword
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu cần ít nhất 1 chữ hoa';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Mật khẩu cần ít nhất 1 chữ thường';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu cần ít nhất 1 chữ số';
    }
    return null;
  }

  /// Validate xác nhận mật khẩu — kiểm tra khớp với mật khẩu gốc
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }
    if (value != originalPassword) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  // ========== HỌ TÊN ==========

  /// Validate họ tên — dùng cho Register
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    if (value.trim().length < 2) {
      return 'Họ tên phải có ít nhất 2 ký tự';
    }
    if (value.trim().length > 50) {
      return 'Họ tên không được quá 50 ký tự';
    }
    return null;
  }

  // ========== SỐ ĐIỆN THOẠI ==========

  static final _phoneRegex = RegExp(r'^(0|\+84)\d{9,10}$');

  /// Validate số điện thoại Việt Nam (tùy chọn — nullable)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone là optional
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return 'Số điện thoại không hợp lệ (VD: 0912345678)';
    }
    return null;
  }

  // ========== ROLE VALIDATION ==========

  /// Kiểm tra email có khớp với role đã chọn không
  /// Dùng khi đăng ký: user chọn tab Student nhưng email đã register là Parent
  /// [existingRole] là role trong Firestore ('student' | 'parent'), null nếu chưa có
  /// [selectedRole] là role user chọn trên UI
  static String? roleEmailMismatch({
    required String? existingRole,
    required String selectedRole,
  }) {
    if (existingRole == null) {
      return null; // Email chưa tồn tại → OK
    }
    if (existingRole != selectedRole) {
      final existingLabel = existingRole == 'parent'
          ? 'Phụ huynh'
          : 'Sinh viên';
      return 'Email này đã được đăng ký với vai trò "$existingLabel"';
    }
    return null;
  }

  /// Kiểm tra role-email mismatch (phiên bản async — gọi Firestore)
  /// Dùng trong Register screen trước khi signUp
  /// Trả về error message hoặc null nếu OK
  static Future<String?> checkEmailRole({
    required String email,
    required String selectedRole,
    required Future<String?> Function(String email) getRoleByEmail,
  }) async {
    try {
      final existingRole = await getRoleByEmail(email);
      return roleEmailMismatch(
        existingRole: existingRole,
        selectedRole: selectedRole,
      );
    } catch (_) {
      return null; // Lỗi kết nối → bỏ qua, để signUp xử lý
    }
  }

  // ========== SỐ TIỀN ==========

  /// Validate số tiền (cho giao dịch)
  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập số tiền';
    }
    // Loại bỏ dấu chấm phân cách hàng nghìn
    final cleanValue = value.replaceAll('.', '').replaceAll(',', '');
    final number = double.tryParse(cleanValue);
    if (number == null) {
      return 'Số tiền không hợp lệ';
    }
    if (number <= 0) {
      return 'Số tiền phải lớn hơn 0';
    }
    if (number > 999999999) {
      return 'Số tiền quá lớn';
    }
    return null;
  }

  // ========== CHUNG ==========

  /// Validate field bắt buộc
  static String? required(String? value, [String fieldName = 'Trường này']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  /// Validate độ dài tối thiểu
  static String? minLength(
    String? value,
    int min, [
    String fieldName = 'Nội dung',
  ]) {
    if (value == null || value.trim().length < min) {
      return '$fieldName phải có ít nhất $min ký tự';
    }
    return null;
  }

  /// Validate độ dài tối đa
  static String? maxLength(
    String? value,
    int max, [
    String fieldName = 'Nội dung',
  ]) {
    if (value != null && value.trim().length > max) {
      return '$fieldName không được quá $max ký tự';
    }
    return null;
  }
}

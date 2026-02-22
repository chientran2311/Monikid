# 🤖 AGENT PROMPT — TUẦN 1: REFACTOR & NỀN TẢNG
> Paste toàn bộ file này vào AI Agent (Antigravity)
> Agent phải đọc AGENT_CONTEXT.md trước khi bắt đầu bất kỳ task nào

---

## 🎯 MỤC TIÊU TUẦN NÀY

Refactor lại toàn bộ nền tảng dự án Flutter SmartSpending từ structure cũ sang Clean Architecture chuẩn. **Không thêm tính năng mới** — chỉ dọn dẹp, tổ chức lại, và tạo nền móng vững chắc cho các tuần tiếp theo.

**Checkpoint thành công:** App vẫn chạy được sau refactor. Login/Register/Onboarding hoạt động bình thường. Folder structure đúng chuẩn. Theme mới đã áp dụng (background sáng, không tối).

---

## ⚠️ QUY TẮC BẮT BUỘC

```
1. Đọc AGENT_CONTEXT.md TRƯỚC KHI làm bất cứ thứ gì
2. Thực hiện TỪNG PHASE theo thứ tự, KHÔNG nhảy cóc
3. Sau mỗi phase: cập nhật PROJECT_STATUS.md + CHANGELOG.md
4. Nếu không chắc về code hiện tại → hỏi user TRƯỚC khi xóa
5. KHÔNG xóa: login_screen, register_screen, splash_screen, onboarding_screen
6. KHÔNG hardcode màu sắc hay string — dùng AppColors, AppStrings
7. LUÔN có try/catch trong hàm gọi Firebase hoặc API
8. Commit Git sau mỗi phase hoàn thành
```

---

## 📋 PHASE 1 — GIT SAFETY & AUDIT (~30 phút)

### Mục tiêu
Tạo môi trường an toàn để refactor mà không sợ mất code.

### Tasks

```bash
# 1.1 — Kiểm tra trạng thái Git
git status

# 1.2 — Commit toàn bộ code hiện tại (backup)
git add -A
git commit -m "chore: save current state before refactor"

# 1.3 — Tạo branch mới
git checkout -b feature/refactor-v2

# 1.4 — Audit toàn bộ file dart
find lib/ -name "*.dart" | sort

# 1.5 — Đọc pubspec.yaml để biết dependencies đang có
cat pubspec.yaml
```

### ✅ Output bắt buộc — Tạo file `PROJECT_STATUS.md` ở root project

```markdown
# 📊 PROJECT STATUS — SmartSpending
> Cập nhật: [ngày hôm nay]
> Branch: feature/refactor-v2
> Giai đoạn: Tuần 1 — Đang Refactor

---

## 🚦 Trạng thái tổng quan
**ĐANG REFACTOR — Tuần 1**
Tiến độ: ~15%

## 📁 Cấu trúc file hiện tại
[Paste kết quả `find lib/ -name "*.dart" | sort`]

## 📦 Dependencies hiện tại
[Paste phần dependencies từ pubspec.yaml]

## 🗺️ Màn hình đang có
| Màn hình | File | Quyết định |
|---|---|---|
| Splash | splash_screen.dart | ✅ Giữ |
| Onboarding | onboarding_screen.dart | ✅ Giữ |
| Login | login_screen.dart | ✅ Giữ |
| Register | register_screen.dart | ✅ Giữ |
| Home | home_screen.dart | 🔄 Refactor |
| Transfer | transfer_screen.dart | ❌ Xóa |
| TopUp | top_up_screen.dart | ❌ Xóa |
| Wallet | wallet_screen.dart | ❌ Xóa |

## 🐛 Vấn đề phát hiện
- UI màu tối → cần chuyển sang light theme
- Border xấu → cần áp dụng AppTheme chuẩn
- Folder structure phẳng → cần Clean Architecture
- Màn hình Transfer/TopUp/Wallet không đúng mục tiêu → xóa
```

### ✅ Output bắt buộc — Tạo file `CHANGELOG.md` ở root project

```markdown
# 📝 CHANGELOG — SmartSpending

Tất cả thay đổi quan trọng của dự án được ghi lại ở đây.
Format: [Phase] — [ngày] — [mô tả]

---

## [feature/refactor-v2] — Tuần 1: Refactor & Nền tảng

### Phase 1 — Git Safety & Audit — [ngày]
- ✅ Committed toàn bộ code lên main trước khi refactor
- ✅ Tạo branch feature/refactor-v2
- ✅ Audit: [X] file dart tìm thấy
- ✅ Phát hiện cần xóa: Transfer, TopUp, Wallet screens
```

---

## 📋 PHASE 2 — XÓA CODE THỪA (~20 phút)

### Mục tiêu
Loại bỏ các màn hình không đúng mục tiêu nghiệp vụ.

### Tasks

```
[ ] 2.1 Xóa các file màn hình sai mục tiêu:
    - transfer_screen.dart (hoặc tên tương đương)
    - top_up_screen.dart (hoặc tên tương đương)
    - wallet_screen.dart (hoặc tên tương đương)
    ⚠️ Nếu tên file khác với trên → hỏi user xác nhận trước

[ ] 2.2 Xóa tất cả references đến 3 file trên:
    - import statements
    - route definitions
    - navigation calls (Navigator.pushNamed...)
    - bottom nav items (nếu có tab wallet/transfer)

[ ] 2.3 Chạy kiểm tra:
    flutter analyze
    → Phải đạt 0 errors trước khi tiếp tục

[ ] 2.4 Chạy app nhanh:
    flutter run
    → Đảm bảo Login/Register/Onboarding không crash
```

```bash
# Commit sau phase 2
git add -A
git commit -m "chore: remove transfer, topup, wallet screens"
```

### ✅ Append vào `CHANGELOG.md`

```markdown
### Phase 2 — Xóa code thừa — [ngày]
- ✅ Xóa: transfer_screen.dart
- ✅ Xóa: top_up_screen.dart
- ✅ Xóa: wallet_screen.dart
- ✅ Xóa tất cả references liên quan
- ✅ flutter analyze: 0 errors
- ✅ App chạy bình thường sau khi xóa
```

---

## 📋 PHASE 3 — FOLDER STRUCTURE (~30 phút)

### Mục tiêu
Tạo đúng cấu trúc Clean Architecture.

### Tasks

```bash
# 3.1 — Tạo toàn bộ thư mục cần thiết
mkdir -p lib/core/constants
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/data/models
mkdir -p lib/data/repositories
mkdir -p lib/data/services
mkdir -p lib/presentation/screens/auth
mkdir -p lib/presentation/screens/onboarding
mkdir -p lib/presentation/screens/student/home
mkdir -p lib/presentation/screens/student/transaction
mkdir -p lib/presentation/screens/student/budget
mkdir -p lib/presentation/screens/student/link
mkdir -p lib/presentation/screens/parent
mkdir -p lib/presentation/screens/shared
mkdir -p lib/presentation/widgets
```

```
[ ] 3.2 Di chuyển màn hình hiện có vào đúng vị trí:
    login_screen.dart     → lib/presentation/screens/auth/
    register_screen.dart  → lib/presentation/screens/auth/
    splash_screen.dart    → lib/presentation/screens/onboarding/
    onboarding_screen.dart → lib/presentation/screens/onboarding/
    home_screen.dart      → lib/presentation/screens/student/home/
    ⚠️ Cập nhật TOÀN BỘ import paths sau khi move

[ ] 3.3 Kiểm tra:
    flutter analyze → 0 errors
```

```bash
git add -A
git commit -m "refactor: apply clean architecture folder structure"
```

### ✅ Append vào `CHANGELOG.md`

```markdown
### Phase 3 — Folder Structure — [ngày]
- ✅ Tạo Clean Architecture: core/, data/, presentation/
- ✅ Di chuyển [X] màn hình vào đúng thư mục
- ✅ Cập nhật tất cả import paths
- ✅ flutter analyze: 0 errors
```

---

## 📋 PHASE 4 — CORE FILES (~45 phút)

### Mục tiêu
Tạo các file nền tảng dùng xuyên suốt toàn app.

### Tasks — Tạo lần lượt từng file

**[ ] 4.1 — `lib/core/constants/app_colors.dart`**
```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary      = Color(0xFF2E7D32);
  static const Color secondary    = Color(0xFF66BB6A);
  static const Color background   = Color(0xFFF5F5F5);
  static const Color surface      = Color(0xFFFFFFFF);
  static const Color income       = Color(0xFF1976D2);
  static const Color expense      = Color(0xFFD32F2F);
  static const Color textPrimary  = Color(0xFF212121);
  static const Color textSecondary= Color(0xFF757575);
  static const Color textHint     = Color(0xFFBDBDBD);
  static const Color error        = Color(0xFFD32F2F);
  static const Color success      = Color(0xFF388E3C);
  static const Color warning      = Color(0xFFF57C00);
  static const Color border       = Color(0xFFE0E0E0);
  static const Color divider      = Color(0xFFF5F5F5);

  // Category colors
  static const Color catFood          = Color(0xFFFF7043);
  static const Color catTransport     = Color(0xFF42A5F5);
  static const Color catStudy         = Color(0xFF7E57C2);
  static const Color catEntertainment = Color(0xFFFFCA28);
  static const Color catShopping      = Color(0xFFEC407A);
  static const Color catHealth        = Color(0xFF26C6DA);
  static const Color catHousing       = Color(0xFF8D6E63);
  static const Color catOther         = Color(0xFF78909C);

  static Color getCategoryColor(String category) {
    switch (category) {
      case 'food':          return catFood;
      case 'transport':     return catTransport;
      case 'study':         return catStudy;
      case 'entertainment': return catEntertainment;
      case 'shopping':      return catShopping;
      case 'health':        return catHealth;
      case 'housing':       return catHousing;
      default:              return catOther;
    }
  }
}
```

**[ ] 4.2 — `lib/core/constants/app_strings.dart`**
```dart
class AppStrings {
  AppStrings._();

  static const String appName = 'SmartSpending';

  // Auth
  static const String login             = 'Đăng nhập';
  static const String register          = 'Đăng ký';
  static const String logout            = 'Đăng xuất';
  static const String email             = 'Email';
  static const String password          = 'Mật khẩu';
  static const String forgotPassword    = 'Quên mật khẩu?';
  static const String fullName          = 'Họ và tên';
  static const String roleStudent       = 'Sinh viên';
  static const String roleParent        = 'Phụ huynh';

  // Transaction
  static const String addTransaction    = 'Thêm giao dịch';
  static const String income            = 'Thu nhập';
  static const String expense           = 'Chi tiêu';
  static const String amount            = 'Số tiền';
  static const String category          = 'Danh mục';
  static const String note              = 'Ghi chú';
  static const String date              = 'Ngày';
  static const String save              = 'Lưu';
  static const String cancel            = 'Hủy';
  static const String delete            = 'Xóa';
  static const String edit              = 'Chỉnh sửa';

  // Categories
  static const String catFood           = 'Ăn uống';
  static const String catTransport      = 'Di chuyển';
  static const String catStudy          = 'Học tập';
  static const String catEntertainment  = 'Giải trí';
  static const String catShopping       = 'Mua sắm';
  static const String catHealth         = 'Sức khỏe';
  static const String catHousing        = 'Sinh hoạt';
  static const String catOther          = 'Khác';

  static String getCategoryName(String key) {
    switch (key) {
      case 'food':          return catFood;
      case 'transport':     return catTransport;
      case 'study':         return catStudy;
      case 'entertainment': return catEntertainment;
      case 'shopping':      return catShopping;
      case 'health':        return catHealth;
      case 'housing':       return catHousing;
      default:              return catOther;
    }
  }

  static String getCategoryIcon(String key) {
    switch (key) {
      case 'food':          return '🍜';
      case 'transport':     return '🚌';
      case 'study':         return '📚';
      case 'entertainment': return '🎬';
      case 'shopping':      return '🛍️';
      case 'health':        return '💊';
      case 'housing':       return '🏠';
      default:              return '📦';
    }
  }

  // Dashboard
  static const String totalIncome         = 'Tổng thu';
  static const String totalExpense        = 'Tổng chi';
  static const String balance             = 'Số dư';
  static const String thisMonth           = 'Tháng này';
  static const String recentTransactions  = 'Giao dịch gần đây';

  // Parent
  static const String linkParent    = 'Liên kết phụ huynh';
  static const String enterCode     = 'Nhập mã liên kết';
  static const String generateCode  = 'Tạo mã mới';
  static const String codeExpiry    = 'Mã hết hạn sau 24 giờ';

  // Errors
  static const String errorRequired        = 'Trường này không được để trống';
  static const String errorInvalidEmail    = 'Email không hợp lệ';
  static const String errorPasswordShort   = 'Mật khẩu tối thiểu 6 ký tự';
  static const String errorAmountInvalid   = 'Số tiền phải lớn hơn 0';
  static const String errorGeneric         = 'Đã có lỗi xảy ra, vui lòng thử lại';
}
```

**[ ] 4.3 — `lib/core/constants/app_routes.dart`**
```dart
class AppRoutes {
  AppRoutes._();

  static const String splash          = '/';
  static const String onboarding      = '/onboarding';
  static const String login           = '/login';
  static const String register        = '/register';
  static const String forgotPassword  = '/forgot-password';

  // Student
  static const String studentHome         = '/student/home';
  static const String addTransaction      = '/student/transaction/add';
  static const String transactionHistory  = '/student/transaction/history';
  static const String transactionDetail   = '/student/transaction/detail';
  static const String budgetSetting       = '/student/budget';
  static const String scanReceipt         = '/student/scan-receipt';
  static const String linkParent          = '/student/link-parent';

  // Parent
  static const String parentHome          = '/parent/home';
  static const String enterLinkCode       = '/parent/enter-code';
  static const String parentNotifications = '/parent/notifications';

  // Shared
  static const String profile = '/profile';
}
```

**[ ] 4.4 — `lib/core/theme/app_theme.dart`**
```dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textHint),
      ),
    );
  }
}
```

**[ ] 4.5 — `lib/core/utils/currency_formatter.dart`**
```dart
import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _vnd = NumberFormat.currency(
    locale: 'vi_VN', symbol: 'đ', decimalDigits: 0,
  );

  /// 1500000 → "1.500.000đ"
  static String format(num amount) => _vnd.format(amount);

  /// income 1500000 → "+1.500.000đ" | expense → "-1.500.000đ"
  static String formatWithSign(num amount, String type) {
    final f = _vnd.format(amount.abs());
    return type == 'income' ? '+$f' : '-$f';
  }

  /// "1.500.000" → 1500000.0
  static double parse(String value) {
    final clean = value
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('đ', '')
        .trim();
    return double.tryParse(clean) ?? 0;
  }
}
```

**[ ] 4.6 — `lib/core/utils/date_formatter.dart`**
```dart
import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String toDisplay(DateTime d) =>
      DateFormat('dd/MM/yyyy').format(d);

  static String toMonthYear(DateTime d) =>
      DateFormat('MM/yyyy').format(d);

  static String toMonthKey(DateTime d) =>
      DateFormat('yyyy-MM').format(d);

  static String toRelative(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inDays == 0) return 'Hôm nay';
    if (diff.inDays == 1) return 'Hôm qua';
    if (diff.inDays < 7)  return '${diff.inDays} ngày trước';
    return toDisplay(d);
  }
}
```

**[ ] 4.7 — `lib/core/utils/validators.dart`**
```dart
import '../constants/app_strings.dart';

class Validators {
  Validators._();

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.errorRequired;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.trim()))
      return AppStrings.errorInvalidEmail;
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return AppStrings.errorRequired;
    if (v.length < 6) return AppStrings.errorPasswordShort;
    return null;
  }

  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.errorRequired;
    return null;
  }

  static String? amount(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.errorRequired;
    final n = double.tryParse(
      v.replaceAll('.', '').replaceAll(',', '').replaceAll('đ', ''),
    );
    if (n == null || n <= 0) return AppStrings.errorAmountInvalid;
    return null;
  }
}
```

**[ ] 4.8 — Cập nhật `main.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_routes.dart';
import 'firebase_options.dart';
import 'presentation/screens/onboarding/splash_screen.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SmartSpendingApp());
}

class SmartSpendingApp extends StatelessWidget {
  const SmartSpendingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartSpending',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash:      (_) => const SplashScreen(),
        AppRoutes.onboarding:  (_) => const OnboardingScreen(),
        AppRoutes.login:       (_) => const LoginScreen(),
        AppRoutes.register:    (_) => const RegisterScreen(),
      },
    );
  }
}
```

**[ ] 4.9 — Cập nhật `pubspec.yaml`** — thêm packages nếu chưa có:
```yaml
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6
  google_generative_ai: ^0.4.0
  google_mlkit_text_recognition: ^0.11.0
  fl_chart: ^0.66.0
  flutter_local_notifications: ^16.3.0
  flutter_riverpod: ^2.4.9
  intl: ^0.18.1
  image_picker: ^1.0.7
  uuid: ^4.3.3
```

```bash
flutter pub get
flutter analyze
# Phải đạt: 0 errors

git add -A
git commit -m "feat: add core constants, theme, utils + update dependencies"
```

### ✅ Append vào `CHANGELOG.md`

```markdown
### Phase 4 — Core Files — [ngày]
- ✅ AppColors: palette đầy đủ + getCategoryColor()
- ✅ AppStrings: tất cả text + getCategoryName() + getCategoryIcon()
- ✅ AppRoutes: tất cả route names
- ✅ AppTheme: Material 3, light mode, input/button/card styles
- ✅ CurrencyFormatter: format VND, formatWithSign, parse
- ✅ DateFormatter: toDisplay, toRelative, toMonthKey
- ✅ Validators: email, password, required, amount
- ✅ main.dart: dùng AppTheme + AppRoutes
- ✅ Dependencies thêm: [liệt kê packages]
- ✅ flutter pub get: OK
- ✅ flutter analyze: 0 errors
```

---

## 📋 PHASE 5 — DATA MODELS (~45 phút)

### Mục tiêu
Tạo 4 Model classes đại diện cho data Firestore.

**[ ] 5.1 — `lib/data/models/user_model.dart`**
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { student, parent }

class UserModel {
  final String userId;
  final String email;
  final String displayName;
  final UserRole role;
  final String? linkedParentId;
  final String? linkedStudentId;
  final double? monthlyBudget;
  final DateTime createdAt;

  const UserModel({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.role,
    this.linkedParentId,
    this.linkedStudentId,
    this.monthlyBudget,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: doc.id,
      email: d['email'] ?? '',
      displayName: d['displayName'] ?? '',
      role: d['role'] == 'parent' ? UserRole.parent : UserRole.student,
      linkedParentId: d['linkedParentId'],
      linkedStudentId: d['linkedStudentId'],
      monthlyBudget: (d['monthlyBudget'] as num?)?.toDouble(),
      createdAt: (d['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'email': email,
    'displayName': displayName,
    'role': role.name,
    'linkedParentId': linkedParentId,
    'linkedStudentId': linkedStudentId,
    'monthlyBudget': monthlyBudget,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  UserModel copyWith({
    String? displayName,
    String? linkedParentId,
    String? linkedStudentId,
    double? monthlyBudget,
  }) => UserModel(
    userId: userId, email: email, role: role, createdAt: createdAt,
    displayName: displayName ?? this.displayName,
    linkedParentId: linkedParentId ?? this.linkedParentId,
    linkedStudentId: linkedStudentId ?? this.linkedStudentId,
    monthlyBudget: monthlyBudget ?? this.monthlyBudget,
  );

  bool get isStudent => role == UserRole.student;
  bool get isParent  => role == UserRole.parent;
  bool get isLinked  => linkedParentId != null || linkedStudentId != null;
}
```

**[ ] 5.2 — `lib/data/models/transaction_model.dart`**
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType   { income, expense }
enum TransactionSource { manual, ocr }

class TransactionModel {
  final String transactionId;
  final String userId;
  final double amount;
  final TransactionType type;
  final String category;   // food | transport | study | ...
  final String note;
  final TransactionSource source;
  final String? receiptImageUrl;
  final DateTime date;
  final DateTime createdAt;

  const TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    required this.note,
    required this.source,
    this.receiptImageUrl,
    required this.date,
    required this.createdAt,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      transactionId: doc.id,
      userId: d['userId'] ?? '',
      amount: (d['amount'] as num).toDouble(),
      type: d['type'] == 'income'
          ? TransactionType.income : TransactionType.expense,
      category: d['category'] ?? 'other',
      note: d['note'] ?? '',
      source: d['source'] == 'ocr'
          ? TransactionSource.ocr : TransactionSource.manual,
      receiptImageUrl: d['receiptImageUrl'],
      date: (d['date'] as Timestamp).toDate(),
      createdAt: (d['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'amount': amount,
    'type': type.name,
    'category': category,
    'note': note,
    'source': source.name,
    'receiptImageUrl': receiptImageUrl,
    'date': Timestamp.fromDate(date),
    'createdAt': Timestamp.fromDate(createdAt),
  };

  bool get isExpense   => type == TransactionType.expense;
  bool get isIncome    => type == TransactionType.income;
  bool get hasReceipt  => receiptImageUrl != null;
  bool get isOcr       => source == TransactionSource.ocr;
}
```

**[ ] 5.3 — `lib/data/models/link_request_model.dart`**
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

enum LinkStatus { pending, accepted, expired }

class LinkRequestModel {
  final String requestId;
  final String code;
  final String studentId;
  final DateTime expiresAt;
  final LinkStatus status;

  const LinkRequestModel({
    required this.requestId,
    required this.code,
    required this.studentId,
    required this.expiresAt,
    required this.status,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isValid   => status == LinkStatus.pending && !isExpired;

  factory LinkRequestModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return LinkRequestModel(
      requestId: doc.id,
      code: d['code'] ?? '',
      studentId: d['studentId'] ?? '',
      expiresAt: (d['expiresAt'] as Timestamp).toDate(),
      status: LinkStatus.values.firstWhere(
        (e) => e.name == d['status'],
        orElse: () => LinkStatus.expired,
      ),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'code': code,
    'studentId': studentId,
    'expiresAt': Timestamp.fromDate(expiresAt),
    'status': status.name,
  };
}
```

**[ ] 5.4 — `lib/data/models/notification_model.dart`**
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String notificationId;
  final String recipientId;
  final String studentId;
  final String? transactionId;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.notificationId,
    required this.recipientId,
    required this.studentId,
    this.transactionId,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      notificationId: doc.id,
      recipientId: d['recipientId'] ?? '',
      studentId: d['studentId'] ?? '',
      transactionId: d['transactionId'],
      message: d['message'] ?? '',
      createdAt: (d['createdAt'] as Timestamp).toDate(),
      isRead: d['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'recipientId': recipientId,
    'studentId': studentId,
    'transactionId': transactionId,
    'message': message,
    'createdAt': Timestamp.fromDate(createdAt),
    'isRead': isRead,
  };

  NotificationModel markAsRead() => NotificationModel(
    notificationId: notificationId, recipientId: recipientId,
    studentId: studentId, transactionId: transactionId,
    message: message, createdAt: createdAt, isRead: true,
  );
}
```

```bash
flutter analyze
# Phải: 0 errors

git add -A
git commit -m "feat: add data models (User, Transaction, LinkRequest, Notification)"
```

### ✅ Append vào `CHANGELOG.md`

```markdown
### Phase 5 — Data Models — [ngày]
- ✅ UserModel: fromFirestore, toFirestore, copyWith, isStudent/isParent/isLinked
- ✅ TransactionModel: fromFirestore, toFirestore, isExpense/hasReceipt/isOcr
- ✅ LinkRequestModel: fromFirestore, toFirestore, isValid getter
- ✅ NotificationModel: fromFirestore, toFirestore, markAsRead()
- ✅ flutter analyze: 0 errors
```

---

## 📋 PHASE 6 — FINAL CHECK & BÁO CÁO (~20 phút)

```bash
# 6.1 — Final analyze
flutter analyze
# Phải: 0 errors

# 6.2 — Chạy app lần cuối kiểm tra
flutter run
# Kiểm tra: Splash → Onboarding → Login/Register đều OK
# Kiểm tra: Background đã sáng (không còn tối)
# Kiểm tra: Không có màn hình Transfer/TopUp/Wallet

# 6.3 — Final commit & push
git add -A
git commit -m "chore: week 1 complete - refactor & foundation"
git push origin feature/refactor-v2
```

### ✅ Cập nhật toàn bộ `PROJECT_STATUS.md` lần cuối

```markdown
# 📊 PROJECT STATUS — SmartSpending
> Cập nhật: [ngày cuối tuần 1]
> Branch: feature/refactor-v2

---

## 🚦 Trạng thái tổng quan
**✅ TUẦN 1 HOÀN THÀNH**
Tiến độ tổng thể: ~25%

---

## ✅ Đã hoàn thành

### Tuần 1 — Refactor & Nền tảng
- [x] Git: branch feature/refactor-v2
- [x] Xóa Transfer, TopUp, Wallet screens
- [x] Clean Architecture folder structure
- [x] AppColors (full palette + category colors)
- [x] AppStrings (all text + category helpers)
- [x] AppRoutes (all route names)
- [x] AppTheme (Material 3, light mode)
- [x] CurrencyFormatter
- [x] DateFormatter
- [x] Validators
- [x] UserModel
- [x] TransactionModel
- [x] LinkRequestModel
- [x] NotificationModel
- [x] main.dart updated
- [x] Dependencies updated
- [x] flutter analyze: 0 errors ✅

---

## 🔄 Tuần 2 — Sắp bắt đầu
- [ ] AuthRepository (login, register, logout, getCurrentUser)
- [ ] UserRepository (getUser, updateUser, linkAccounts)
- [ ] Add Transaction Screen (form + validation)
- [ ] Transaction History Screen (list + filter)

---

## 📋 Backlog
- [ ] Tuần 3: Gemini AI phân loại
- [ ] Tuần 4: Dashboard & Charts
- [ ] Tuần 5: Parent Flow + Notifications
- [ ] Tuần 6: OCR + Budget + Testing
- [ ] Tuần 7: UI Polish + Docs + Demo

---

## 🐛 Known Issues
[Liệt kê issues nếu có, hoặc "None"]

---

## 📦 Tất cả Dependencies

[Paste toàn bộ dependencies section từ pubspec.yaml]

---

## 📁 Folder structure hiện tại
[Paste: find lib/ -name "*.dart" | sort]
```

### ✅ Append vào `CHANGELOG.md`

```markdown
### Phase 6 — Final Check — [ngày]
- ✅ flutter analyze: 0 errors
- ✅ App chạy: Splash → Onboarding → Login/Register OK
- ✅ Theme mới: background sáng ✅
- ✅ Không còn màn hình Transfer/TopUp/Wallet ✅
- ✅ Pushed: feature/refactor-v2

---

## TUẦN 1 HOÀN THÀNH ✅
**Tổng kết:**
- 6 phases hoàn thành
- [X] files dart mới tạo
- [X] files dart xóa
- 0 errors
- Sẵn sàng cho Tuần 2: CRUD Giao dịch 🚀
```

---

## 🔚 BÁO CÁO CUỐI CHO USER

Sau khi xong tất cả, agent gửi summary này cho user:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ TUẦN 1 HOÀN THÀNH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PHASES ĐÃ HOÀN THÀNH:
✅ Phase 1: Git Safety & Audit
✅ Phase 2: Xóa Transfer/TopUp/Wallet
✅ Phase 3: Clean Architecture Structure
✅ Phase 4: Core Files (Colors/Strings/Routes/Theme/Utils)
✅ Phase 5: Data Models (4 models)
✅ Phase 6: Final Check

FILES MỚI TẠO:
• lib/core/constants/app_colors.dart
• lib/core/constants/app_strings.dart
• lib/core/constants/app_routes.dart
• lib/core/theme/app_theme.dart
• lib/core/utils/currency_formatter.dart
• lib/core/utils/date_formatter.dart
• lib/core/utils/validators.dart
• lib/data/models/user_model.dart
• lib/data/models/transaction_model.dart
• lib/data/models/link_request_model.dart
• lib/data/models/notification_model.dart
• PROJECT_STATUS.md (root)
• CHANGELOG.md (root)

BƯỚC TIẾP THEO (Tuần 2):
→ Tạo AuthRepository
→ Tạo Add Transaction Screen
→ Tạo Transaction History Screen

USER CẦN XÁC NHẬN:
[ ] flutter analyze: 0 errors?
[ ] App chạy được trên device/simulator?
[ ] Background đã sáng lên (không còn tối)?
[ ] Không còn crash khi mở app?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

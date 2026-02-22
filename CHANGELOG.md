# 📝 CHANGELOG — MoniKid

Tất cả thay đổi quan trọng trong suốt quá trình hoàn thiện MoniKid sẽ được ghi chú ở đây.

---

## Tuần 1: Khởi tạo & Dọn dẹp nền tảng

### Phase 1 & 2 — Audit và Xóa code thừa
- ✅ Xóa các màn hình: `transfer_money_screen.dart`, `wallet_screen.dart`, `withdraw_deposit.dart`
- ✅ Xóa widget trung gian: `quick_action.dart`
- ✅ Xóa tất cả tham chiếu và routes đến Wallet

### Phase 3 — (SKIPPED) Cấu trúc
- ✅ Quyết định: Giữ nguyên folder structure Layer-based/Feature-based hiện tại của Monitkid

### Phase 4 & 5 — Core files & Models
- ✅ Cập nhật, tạo mới utils: CurrencyFormatter, DateFormatter, Validators
- ✅ Hoàn thiện `app_strings.dart`
- ✅ Tạo 4 Data Models: `UserModel`, `TransactionModel`, `LinkRequestModel`, `NotificationModel` để phục vụ Data-Binding Firestore sắp tới.

### Phase 6 — Cập nhật tài liệu
- ✅ Khởi tạo file Track: `PROJECT_STATUS.md`, `CHANGELOG.md`
- ✅ Kiểm tra lint tổng thể

## Tuần 2: Refactor UI & Onboarding Flow

### Phase 1: Theme & Splash Screen
- ✅ Cập nhật `lib/core/theme/theme.dart` với mã màu mới theo thiết kế Tailwind và font Spline Sans.
- ✅ Hoàn thành UI màn hình Splash (`lib/features/auth/splash/splash_screen.dart`) đúng theo bản thiết kế HTML mới. Cập nhật logic điều hướng.
- ✅ Refactor toàn cục tên biến màu sắc cũ (`primaryGreen`, `background`, v.v.) sang hệ thống thuộc tính mới để tránh lỗi biên dịch.

### Phase 2: Onboarding Screens
- ✅ Hoàn thiện các màn hình Onboarding (`lib/features/auth/onboard/onboard_1.dart`, 2, 3) theo bản thiết kế HTML.
- ✅ Bổ sung widget dùng chung: `OnboardingIndicator` cho thanh trạng thái bước nhảy giữa các màn Onboard.

### Phase 3: Auth Screens (Login & Register)
- ✅ Refactor lại giao diện trang đăng nhập (`login_screen.dart`) và đăng ký (`register.dart`) theo thiết kế HTML gốc.
- ✅ Cấu hình tính năng "Fake Login" cho phép ấn đăng nhập là vào thẳng trang `parentHome` không qua xác thực Firebase để dễ test UI.
- ✅ Custom Theme tương thích Dark mode/Light mode đồng nhất trên form Input, Tab selector và các nút Social Login.

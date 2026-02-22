# 📊 Báo Cáo Trạng Thái & Đánh Giá Dự Án (MoniKid)

**Thời gian đánh giá:** 22/02/2026
**Cơ sở đánh giá:** `docs/project_structure.md`, `CHANGELOG.md`, và tiêu chuẩn Clean Architecture trong `@.antigravity/skills/flutter_feature`.

---

## 1. Tóm tắt Code Changes (Tuần 1 & 2)

### Dọn dẹp & Kiến trúc (Tuần 1)
- **Log:** Xóa một số file mã nguồn và widget thừa (liên quan đến `Wallet`, `Transfer`, v.v.), giúp giảm dung lượng và tránh import rác. Định hình cấu trúc **Feature-first** kết hợp **DDD**.
- **Model:** Tạo mới 4 Data Models: `UserModel`, `TransactionModel`, `LinkRequestModel`, `NotificationModel`.

### UI/UX & Giao diện (Tuần 2)
- **Refactoring & UI:** Hoàn thiện hầu hết UI (~80-90%) cho Splash, Onboarding, Login, Register dựa trên bản thiết kế mới.
- **Theming & Assets:** Cập nhật lại hệ thống màu sắc theo Tailwind và font chữ Spline Sans. Hỗ trợ chuẩn xác Dark/Light mode trên toàn bộ Form, Tab, Social Login Button.
- **Tái sử dụng Component:** Triển khai các widget dùng để tái sử dụng (`OnboardingIndicator`, custom theme input).

### 🔐 Auth Feature (Tuần 3 — MỚI)

#### Phase A: UI Screens
- **3 Screens mới:** `ForgotPasswordScreen` (illustration + email + gửi OTP), `OTPScreen` (6 ô input + countdown 60s), `UpdatePasswordScreen` (password + strength indicator + success dialog).
- **5 Widgets mới:** `IllustrationSection`, `OtpInputField` (auto-focus, paste, backspace), `CountdownTimer` (restart, resend), `PasswordStrengthIndicator` (scoring real-time), `SuccessDialog` (shared/reusable).
- **Fix LoginScreen:** Thay thế bypass `context.go()` → `authProvider.signIn()` thực. Thêm error/loading display.

#### Phase B: Backend Integration
- **AuthRepository:** Thêm `resetPassword()` (Firebase `sendPasswordResetEmail`) + `getUserRole()` (Firestore lookup).
- **AuthState:** Thêm field `userRole` cho role-based redirect.
- **AuthProvider:** `signIn` auto-fetch role từ Firestore, `signUp` set role trực tiếp, thêm `resetPassword()` method.
- **Router:** Bật redirect auth guard — user đã login redirect theo role (student/parent), user chưa login bị chặn vào private routes. `initialLocation` đổi từ `onboard1` → `splash`.
- **UserModel:** Cập nhật field names match Firestore (`full_name`, `avatar_url`, `wallet`, `bank_account`).
- **Firestore Schema:** Cập nhật `firestore_schema.md` — thêm `wallet`, `bank_account`, đổi `displayName` → `full_name`, `avatarUrl` → `avatar_url`.

---

## 2. Review Code Performance & Đánh Giá Kiến Trúc

Dựa trên chuẩn mực `flutter-feature-dev` (kỹ năng chuẩn hóa cho kiến trúc app Flutter), đây là phần đánh giá:

### ✅ Điểm Được Đánh Giá Cao (Tuân thủ Best Practices)
1. **Thiết lập Core Package vững chắc:** `Riverpod`, `Freezed`, `GoRouter`, `GetIt/Injectable`.
2. **Phase 5 (Model Development):** Code gen Freezed + JsonSerializable chuẩn.
3. **Phân chia Feature-based Rõ Ràng:** Tách biệt `auth`, `parent`, `student`.
4. **Clean Code & Thống Nhất Core/Shared:** Widgets tái sử dụng (`CustomInputField`, `PrimaryButton`, `AuthCard`, `SuccessDialog`).
5. **🆕 Auth Flow Hoàn Chỉnh:** Login → ForgotPassword → OTP → UpdatePassword → Login. Backend tích hợp Firebase Auth + Firestore sync + role-based routing.

### ⚠️ Điểm Cần Cải Thiện / Refactor Tiếp Theo
1. **Vị Trí Của Repositories & Models (Phase 6):** Repository nên nằm trong `features/{feature_name}` khi scale.
2. ~~**Trick Bypass Auth UI (Fake Login):**~~ ✅ **ĐÃ KHẮC PHỤC** — Login đã nối auth thực, router redirect đã bật.
3. **OTP Flow:** Hiện Firebase Auth không có native OTP cho password reset (chỉ có email link). Cần quyết định: dùng email link hay tự build OTP backend.

---

## 3. Khuyến nghị Tiếp Theo (Next Steps)

1. **Thay thế Dummy Data (Phase 6/7/8):** Chuyển dữ liệu hardcode Dashboard sang `Firestore` với `StreamProvider/FutureProvider`.
2. **Google/Apple Sign-In:** Thêm social login (cần config OAuth).
3. **Email Verification:** Thêm flow verify email sau đăng ký.
4. **Profile Editing:** Kết nối Setting screen với `UserModel` update.
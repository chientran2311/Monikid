# Tổng quan Cấu trúc Dự án (Project Structure)
Dự án: **Monikid (SmartSpending)**

## 1. Trạng thái Dự án & Độ hoàn thiện
Dự án đang trong giai đoạn phát triển và chuyển từ việc build giao diện (UI thuần hardcoded) sang tích hợp logic thực tế với Firebase/Backend.

**Đánh giá tổng quan độ hoàn thiện:**
- **UI (Giao diện):** Đã hoàn thiện ~80-90% cho hầu hết các màn hình chính của cả 2 roles (Student & Parent). Các màn hình đầy đủ màu sắc, animations cơ bản, và components tái sử dụng được.
- **State Management & Architecture:** Đã setup xong kiến trúc cơ bản với **Riverpod**, Routing với **GoRouter**, tiêm phụ thuộc (DI) với **GetIt/Injectable**.
- **Tính năng Auth:** Đã có giao diện Login/Register/Onboarding. Phần code provider/repository cho Firebase Auth đã có cấu trúc, tuy nhiên currently UI đang bypass auth flow bằng cách gọi `context.go` để test giao diện.
- **Tính năng cốt lõi (Giao dịch, Thống kê, Liên kết):** Toàn bộ dữ liệu hiển thị hiện đang là Mock data (dữ liệu cứng). Cấu trúc model đã được định nghĩa (`user_model.dart`, `transaction_model.dart`, `family_model.dart`) và hỗ trợ gen code (`Freezed`/`JsonSerializable`). Firebase Integration (Firestore, Storage) chưa được kết nối hoàn chỉnh vào UI.

---

## 2. Cấu trúc thư mục (Folder Structure)
Cấu trúc tuân theo chuẩn **Feature-first** kết hợp **Domain-Driven Design (DDD)** linh hoạt.

### `lib/`
Chứa toàn bộ mã nguồn Dart chính của ứng dụng.
- **`app/`**
  - Khởi tạo ứng dụng chính, global state.
  - Chứa file cấu hình Router (`router.dart`) điều hướng toàn app.
- **`core/`**
  - Chứa cấu hình cốt lõi (constants, theme, configs, error handling).
  - Các tiện ích dùng chung (`utils/`: formatters, validators, logger) và Dependency Injection (`di/`).
- **`features/`**
  - Nơi chia mã nguồn theo từng module tính năng cụ thể. Các màn hình (Screen) và logic UI state (Riverpod providers) nằm tại đây.
  - `auth/`: Tính năng phân quyền, đăng nhập, đăng ký, quên mật khẩu, splash, onboard.
  - `parent/`: Các màn hình dành riêng cho vai trò Phụ huynh (Home, Statistic, Setting, Bottom navigation).
  - `student/`: Các màn hình dành riêng cho vai trò Học sinh (Home, Statistic, Transaction, Setting, Bottom navigation).
- **`models/`**
  - Phân chia model cho tầng Domain (`entities/`) và tầng Data (`response/`).
  - Sử dụng Freezed để tạo immutable classes cho các đối tượng như: `AppUser`, `Transaction`, `Family`, `Notification`, v.v.
- **`repositories/`**
  - Chứa class, abstract class xử lý nghiệp vụ gọi lấy dữ liệu từ Backend/Firebase.
  - Ví dụ: `auth_repository.dart`, `wallet_repository.dart`
- **`shared/`**
  - Component UI dùng chung toàn app để tái sử dụng (`widgets/`).
  - Gồm button, custom input, transaction item, card...
- **`main.dart` & `firebase_options.dart`**
  - Entry point khởi chạy ứng dụng Flutter. Setup các service cơ bản (Firebase, Provider context, DI).

### `html_code/`
- Chứa các file HTML tĩnh mô phỏng giao diện mẫu trước khi chuyển thành code Flutter. Đây là bản thiết kế mockup ban đầu của dự án.

### `docs/`
- Nơi lưu trữ toàn bộ các tài liệu quan trọng của dự án.
- Tham khảo như: `SmartSpending_DoAn.md` (yêu cầu nghiệp vụ), `firestore_schema.md` (thiết kế db).

### `assets/`
- Lưu trữ tài nguyên file tĩnh như hình ảnh (`images/`), biểu tượng (`icons/`), tệp hiệu ứng (`lottie/`).

### Các file cấu hình ngoài (Root)
- `pubspec.yaml`: Khai báo package pub.dev, versioning, và assets.
- `analysis_options.yaml`: Cấu hình lint rule cho Dart để chuẩn hóa code style.
- `firebase.json`: Setting Firebase cho dự án.

---

## 3. Các thành phần công nghệ sử dụng
- **UI Framework:** Flutter / Dart
- **State Management:** Riverpod (`flutter_riverpod`, `riverpod_annotation`)
- **Routing:** go_router
- **Architecture Tools:** Freezed (Models), get_it & injectable (Dependency injection).
- **Backend / Database:** Firebase Authentication, Cloud Firestore.

## Tóm tắt Mục tiêu Tiếp theo
Để ứng dụng có thể hoạt động hoàn thiện:
1. Nối dây `AuthProvider` vào UI Login/Register.
2. Thay thế dữ liệu hardcoded trong `features/parent` và `features/student` bằng Repository calls (Firestore API).
3. Sửa luồng redirect của `GoRouter` để verify session user thay vì skip.

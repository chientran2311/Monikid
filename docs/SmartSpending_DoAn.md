# 📱 SmartSpending — Ứng Dụng Quản Lý Chi Tiêu Thông Minh

> **Đồ án tốt nghiệp | Khoa Công Nghệ Thông Tin | Trường Đại học Thủy Lợi**
> **Giảng viên hướng dẫn:** PGS.TS Nguyễn Văn Hùng
> **Công nghệ:** Flutter · Firebase · Gemini AI · Google ML Kit

---

## 1. TỔNG QUAN DỰ ÁN

### 1.1 Bối cảnh & Vấn đề

Sinh viên đại học thường gặp khó khăn trong việc quản lý tài chính cá nhân. Theo khảo sát thực tế, phần lớn sinh viên không theo dõi được mình đã chi tiêu vào đâu trong tháng, dẫn đến tình trạng thiếu tiền trước cuối tháng. Đồng thời, phụ huynh không có cách nào theo dõi tình hình tài chính của con một cách minh bạch mà không cần hỏi trực tiếp — gây khó xử cho cả hai phía.

**Pain point cốt lõi:**
- Sinh viên: Không biết tiền đi đâu, không có thói quen ghi chép
- Phụ huynh: Không biết con tiêu tiền có hợp lý không, muốn hỗ trợ nhưng không có thông tin

### 1.2 Giải pháp

**SmartSpending** là ứng dụng mobile cross-platform (iOS & Android) giúp sinh viên ghi lại chi tiêu hàng ngày một cách nhanh chóng, với sự hỗ trợ của AI tự động phân loại giao dịch. Phụ huynh có thể liên kết tài khoản để theo dõi tình hình tài chính của con theo thời gian thực — hoàn toàn minh bạch và không cần hỏi trực tiếp.

### 1.3 Mục tiêu sản phẩm

| Mục tiêu | Mô tả |
|---|---|
| Ghi chép nhanh | Thêm giao dịch trong vòng 3 giây |
| AI thông minh | Tự động phân loại danh mục chi tiêu |
| Minh bạch | Phụ huynh xem real-time, không cần hỏi con |
| Xác thực | Hóa đơn chụp ảnh làm bằng chứng chi tiêu thực tế |
| Trực quan | Biểu đồ thống kê dễ hiểu cho cả hai phía |

---

## 2. ĐỐI TƯỢNG NGƯỜI DÙNG

### 👩‍🎓 Role 1: Student (Sinh viên) — Người dùng chính

**Đặc điểm:** Sinh viên đại học, 18–24 tuổi, dùng điện thoại thành thạo, nhận tiền từ gia đình hàng tháng.

**Nhu cầu:**
- Ghi lại chi tiêu nhanh, không mất thời gian
- Biết mình còn bao nhiêu tiền trong tháng
- Không muốn bị phụ huynh hỏi liên tục về tiền bạc

**Luồng sử dụng chính:**
```
Mở app → Nhập giao dịch (hoặc chụp hóa đơn)
→ AI tự phân loại → Xem dashboard tổng quan
→ Nhận cảnh báo khi sắp vượt ngân sách
```

### 👨‍👩‍👧 Role 2: Parent (Phụ huynh) — Người quan sát

**Đặc điểm:** Phụ huynh của sinh viên, 40–55 tuổi, muốn theo dõi con nhưng không muốn can thiệp trực tiếp.

**Nhu cầu:**
- Biết con tiêu tiền vào đâu một cách minh bạch
- Được cảnh báo khi con chi tiêu bất thường
- Giao diện đơn giản, dễ dùng

**Luồng sử dụng chính:**
```
Nhận mã liên kết từ con → Nhập mã → Xem dashboard con
→ Xem lịch sử giao dịch → Nhận notification khi bất thường
```

---

## 3. TÍNH NĂNG CHI TIẾT

### 🔴 MUST HAVE — Tính năng bắt buộc

#### 3.1 Xác thực người dùng
- Đăng ký / Đăng nhập bằng Email + Password
- Chọn role khi đăng ký: Student hoặc Parent
- Quên mật khẩu qua email

#### 3.2 Quản lý giao dịch (Student)
- Thêm giao dịch thủ công: Số tiền · Loại (Thu/Chi) · Danh mục · Ghi chú · Ngày
- **AI tự động phân loại danh mục** từ ghi chú (Gemini API)
  - Ví dụ: Nhập *"Ăn phở 30k"* → AI tự chọn danh mục **Ăn uống**
- Sửa / Xóa giao dịch đã tạo
- Xem lịch sử giao dịch (filter theo tuần / tháng / danh mục)
- Mỗi giao dịch lưu metadata: nguồn nhập (thủ công / OCR) + timestamp chính xác

**Danh mục chi tiêu:**
| Icon | Danh mục | Ví dụ |
|---|---|---|
| 🍜 | Ăn uống | Phở, trà sữa, cơm |
| 🚌 | Di chuyển | Grab, xăng, xe buýt |
| 📚 | Học tập | Sách, học phí, văn phòng phẩm |
| 🎬 | Giải trí | Xem phim, game, du lịch |
| 🛍️ | Mua sắm | Quần áo, đồ dùng |
| 💊 | Sức khỏe | Thuốc, khám bệnh |
| 🏠 | Sinh hoạt | Tiền nhà, điện nước |
| 📦 | Khác | Không phân loại được |

#### 3.3 Dashboard & Thống kê (Student)
- Tổng thu / Tổng chi trong tháng hiện tại
- Số dư so với ngân sách (nếu đã đặt)
- Biểu đồ tròn (Pie Chart) — chi tiêu theo danh mục
- Biểu đồ đường (Line Chart) — chi tiêu theo ngày trong tháng
- Top 3 danh mục chi nhiều nhất

#### 3.4 Kết nối Parent-Student
- Student tạo **mã liên kết 6 số**, hiệu lực 24 giờ
- Parent nhập mã → Liên kết thành công (1 lần duy nhất)
- Một student chỉ liên kết với 1 parent
- Có thể hủy liên kết bất cứ lúc nào

#### 3.5 Dashboard Parent (Read-only)
- Xem toàn bộ thống kê của con (giống Student dashboard)
- Xem lịch sử giao dịch của con theo thời gian thực
- Không thể sửa / xóa / thêm giao dịch
- Nhận **Push Notification** khi con có giao dịch > 500.000đ

---

### 🟡 SHOULD HAVE — Nên có

#### 3.6 OCR Chụp hóa đơn (Google ML Kit)
- Student chụp ảnh hóa đơn bằng camera
- AI trích xuất số tiền tự động
- Ảnh hóa đơn được lưu kèm giao dịch làm bằng chứng
- Parent xem giao dịch có icon 📷 = có ảnh hóa đơn đính kèm

#### 3.7 Quản lý ngân sách tháng
- Student (hoặc Parent) đặt ngân sách tổng cho tháng
- Hiển thị progress bar: Đã tiêu X / Tổng Y
- Cảnh báo trong app khi đạt 80% ngân sách
- Cảnh báo push notification khi vượt 100%

---

### 🟢 NICE TO HAVE — Nếu còn thời gian

#### 3.8 AI Gợi ý tiết kiệm
- Cuối tháng, AI phân tích pattern chi tiêu
- Đưa ra 2-3 gợi ý cụ thể: *"Em chi 40% vào ăn uống, cao hơn mức trung bình. Thử nấu ăn tại nhà 3 ngày/tuần có thể tiết kiệm ~300k/tháng"*

#### 3.9 Export báo cáo
- Xuất PDF / chia sẻ báo cáo chi tiêu tháng
- Hữu ích để student gửi cho parent xem offline

---

### ❌ KHÔNG PHÁT TRIỂN (Đã xác định loại bỏ)

- ~~Chuyển tiền giữa ví~~ — Không đúng bản chất quản lý chi tiêu
- ~~TopUp từ mock bank~~ — Không cần thiết
- ~~Ví số~~ — Thay bằng quản lý ngân sách đơn giản

---

## 4. KIẾN TRÚC HỆ THỐNG

### 4.1 Tech Stack

> ✅ **Toàn bộ tech stack sử dụng 100% miễn phí — không phát sinh chi phí.**

| Layer | Công nghệ | Lý do chọn |
|---|---|---|
| Mobile Framework | Flutter (Dart) | Cross-platform iOS + Android, performance tốt |
| State Management | Riverpod / Provider | Phù hợp với Flutter, dễ test |
| Backend / Database | Firebase Firestore | Real-time sync, free tier 50k reads/20k writes ngày |
| Authentication | Firebase Auth | Tích hợp sẵn, free 10,000 users/tháng |
| Storage | Firebase Storage | Free 5GB, lưu ảnh hóa đơn |
| AI Phân loại | Gemini API — gọi thẳng từ Flutter | Free tier 15 RPM / 1500 req/ngày, đủ cho demo |
| OCR | Google ML Kit Text Recognition | Hoàn toàn miễn phí, chạy on-device |
| Notification | Firestore-based In-app + flutter_local_notifications | Thay thế FCM, hoàn toàn free |
| Charts | FL Chart | Thư viện Flutter phổ biến, miễn phí |
| ~~Firebase Cloud Functions~~ | ~~Loại bỏ~~ | ❌ Yêu cầu Blaze Plan (trả phí) |
| ~~Firebase Cloud Messaging~~ | ~~Loại bỏ~~ | ❌ Phụ thuộc Cloud Functions |

### 4.2 Sơ đồ kiến trúc

```
┌─────────────────────────────────────────────────┐
│                 FLUTTER APP                      │
│                                                  │
│   ┌─────────────────┐   ┌─────────────────┐     │
│   │   Student App   │   │   Parent App    │     │
│   │                 │   │                 │     │
│   │ • Add transaction│  │ • View dashboard│     │
│   │ • View stats    │   │ • View history  │     │
│   │ • Scan receipt  │   │ • Notifications │     │
│   └────────┬────────┘   └────────┬────────┘     │
│            │                     │               │
└────────────┼─────────────────────┼───────────────┘
             │                     │
             └──────────┬──────────┘
                        │
             ┌──────────▼──────────┐
             │      FIREBASE        │
             ├─────────────────────┤
             │ • Firestore (DB)    │ ← Real-time sync + In-app notification
             │ • Authentication    │ ← Login/Register
             │ • Cloud Storage     │ ← Ảnh hóa đơn
             └──────────┬──────────┘
                        │
             ┌──────────▼──────────┐
             │    AI SERVICES       │
             ├─────────────────────┤
             │ • Gemini API        │ ← Gọi thẳng từ Flutter (free tier)
             │ • Google ML Kit     │ ← OCR on-device, hoàn toàn free
             └─────────────────────┘

             ┌─────────────────────┐
             │  LOCAL NOTIFICATION  │
             ├─────────────────────┤
             │ flutter_local_      │ ← Hiển thị thông báo khi
             │ notifications       │   app đang mở (foreground)
             └─────────────────────┘
```

### 4.3 Firestore Database Schema

```javascript
// Collection: users
{
  userId: "uid_abc123",
  email: "student@tlu.edu.vn",
  displayName: "Nguyễn Văn A",
  role: "student",           // "student" | "parent"
  linkedParentId: "uid_xyz", // null nếu chưa liên kết
  linkedStudentId: null,     // dành cho parent
  monthlyBudget: 3000000,    // ngân sách tháng (có thể null)
  createdAt: timestamp
}

// Collection: transactions
{
  transactionId: "tx_001",
  userId: "uid_abc123",      // chủ sở hữu (student)
  amount: 30000,
  type: "expense",           // "expense" | "income"
  category: "food",          // do AI phân loại
  note: "Ăn phở buổi sáng",
  source: "manual",          // "manual" | "ocr"
  receiptImageUrl: null,     // URL ảnh nếu là OCR
  date: timestamp,
  createdAt: timestamp
}

// Collection: linkRequests
{
  requestId: "req_001",
  code: "482751",            // 6 chữ số
  studentId: "uid_abc123",
  expiresAt: timestamp,      // +24h từ lúc tạo
  status: "pending"          // "pending" | "accepted" | "expired"
}

// Collection: notifications (thay thế FCM — ghi từ client, đọc real-time)
{
  notificationId: "notif_001",
  recipientId: "uid_xyz",    // parent nhận
  studentId: "uid_abc123",
  transactionId: "tx_001",
  message: "Con bạn vừa chi 600.000đ cho Mua sắm",
  createdAt: timestamp,
  isRead: false
  // Ghi bởi: Flutter client của student (không cần Cloud Functions)
}
```

---

## 5. DANH SÁCH MÀN HÌNH

### Student App
| # | Màn hình | Mô tả |
|---|---|---|
| 1 | Splash Screen | Logo + loading (đã có) |
| 2 | Onboarding | Giới thiệu app 3 slide (đã có) |
| 3 | Login / Register | Đăng nhập, đăng ký, quên mật khẩu (đã có) |
| 4 | Home Dashboard | Tổng quan thu/chi, biểu đồ, giao dịch gần đây |
| 5 | Add Transaction | Form thêm giao dịch + AI phân loại |
| 6 | Transaction History | Danh sách + filter + search |
| 7 | Transaction Detail | Chi tiết 1 giao dịch, có ảnh hóa đơn nếu có |
| 8 | Scan Receipt | Camera OCR chụp hóa đơn |
| 9 | Budget Setting | Đặt ngân sách tháng |
| 10 | Link Parent | Tạo mã 6 số để parent liên kết |
| 11 | Profile / Settings | Thông tin cá nhân, đổi mật khẩu, hủy liên kết |

### Parent App
| # | Màn hình | Mô tả |
|---|---|---|
| 1 | Login / Register | Đăng nhập với role Parent |
| 2 | Enter Link Code | Nhập mã 6 số từ con |
| 3 | Parent Dashboard | Xem dashboard của con (read-only) |
| 4 | Transaction History | Xem lịch sử giao dịch của con |
| 5 | Notification | Danh sách thông báo đã nhận |
| 6 | Profile | Thông tin tài khoản |

---

## 6. KẾ HOẠCH TRIỂN KHAI — 7 TUẦN

> **Thời gian:** 20/02/2025 → 08/04/2025
> **Hạn nộp:** Giữa tháng 4/2025

```
TUẦN 1  │ 20/02 - 26/02 │ Refactor & Nền tảng
TUẦN 2  │ 27/02 - 05/03 │ Core: CRUD Giao dịch
TUẦN 3  │ 06/03 - 12/03 │ AI Phân loại (Gemini)
TUẦN 4  │ 13/03 - 19/03 │ Dashboard & Biểu đồ
TUẦN 5  │ 20/03 - 26/03 │ Parent Flow & Notification
TUẦN 6  │ 27/03 - 02/04 │ OCR + Budget + Testing
TUẦN 7  │ 03/04 - 10/04 │ UI Polish + Tài liệu + Demo
```

---

### 📅 TUẦN 1 — Refactor & Nền tảng (20/02 - 26/02)

**Mục tiêu:** Dọn dẹp code cũ, xác định rõ structure mới

**Việc cần làm:**
- [ ] Tạo Git branch mới `feature/refactor-v2`
- [ ] Xóa / ẩn màn hình Transfer, TopUp, Wallet
- [ ] Thiết lập Firestore schema theo đúng cấu trúc mới
- [ ] Cập nhật User model: thêm field `role`, `linkedParentId`, `monthlyBudget`
- [ ] Thiết lập folder structure chuẩn:
```
lib/
├── core/
│   ├── constants/     # colors, strings, routes
│   ├── theme/         # app theme, colors
│   └── utils/         # helpers, formatters
├── data/
│   ├── models/        # User, Transaction, LinkRequest
│   ├── repositories/  # FirestoreRepository
│   └── services/      # GeminiService, OCRService, FCMService
├── presentation/
│   ├── screens/       # Tất cả màn hình
│   ├── widgets/       # Shared widgets
│   └── providers/     # State management
└── main.dart
```
- [ ] Fix màu sắc UI: Chuyển sang palette sáng hơn (xem phần UI/UX)

**Checkpoint cuối tuần:** App chạy được với structure mới, không có lỗi compile

---

### 📅 TUẦN 2 — Core CRUD Giao dịch (27/02 - 05/03)

**Mục tiêu:** Student thêm/sửa/xóa giao dịch, lưu lên Firestore

**Việc cần làm:**
- [ ] Màn hình Add Transaction hoàn chỉnh
  - Input: Số tiền, loại (Thu/Chi toggle), danh mục, ghi chú, ngày
  - Validation: Số tiền > 0, bắt buộc chọn danh mục
  - Lưu Firestore thành công
- [ ] Màn hình Transaction History
  - List giao dịch của user hiện tại
  - Group theo ngày
  - Filter theo tháng
- [ ] Màn hình Transaction Detail
  - Xem chi tiết + nút Sửa / Xóa
- [ ] Cập nhật Home Dashboard: Hiển thị tổng thu/chi tháng hiện tại

**Checkpoint cuối tuần:** Thêm giao dịch → Lưu DB → Hiển thị đúng trong list

---

### 📅 TUẦN 3 — AI Phân loại Gemini (06/03 - 12/03)

**Mục tiêu:** Nhập ghi chú → AI tự chọn danh mục

**Việc cần làm:**
- [ ] Thêm package `google_generative_ai` vào `pubspec.yaml`
- [ ] Tạo `GeminiService` class trong Flutter:
```dart
// lib/data/services/gemini_service.dart
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
  );

  Future<String> classifyTransaction(String note) async {
    final prompt = '''
      Phân loại giao dịch chi tiêu sau vào đúng 1 danh mục.
      Danh mục: food, transport, study, entertainment, shopping, health, housing, other
      Giao dịch: "$note"
      Chỉ trả về đúng 1 từ danh mục, không giải thích.
    ''';
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim().toLowerCase() ?? 'other';
    } catch (e) {
      return 'other'; // fallback nếu lỗi
    }
  }
}
```
- [ ] Lưu API key an toàn: dùng `--dart-define=GEMINI_API_KEY=xxx` khi build, **KHÔNG** commit key lên Git
- [ ] Gọi `GeminiService` khi user nhập xong ghi chú (debounce 800ms)
- [ ] UI: Loading indicator khi AI đang xử lý
- [ ] UI: Danh mục tự động thay đổi theo kết quả AI
- [ ] Cho phép user override nếu AI phân loại sai

**Checkpoint cuối tuần:** Nhập "mua trà sữa" → AI trả về "food" trong <2 giây

---

### 📅 TUẦN 4 — Dashboard & Biểu đồ (13/03 - 19/03)

**Mục tiêu:** Dashboard trực quan, đẹp, dễ đọc

**Việc cần làm:**
- [ ] Tích hợp thư viện FL Chart
- [ ] Pie Chart: Chi tiêu theo danh mục trong tháng
- [ ] Line Chart: Chi tiêu theo ngày (30 ngày gần nhất)
- [ ] Summary Cards: Tổng chi / Tổng thu / Số dư
- [ ] Top 3 danh mục chi nhiều nhất (dạng list với progress bar)
- [ ] Navigation giữa các tháng (← Tháng trước | Tháng hiện tại →)
- [ ] Màn hình Budget: Đặt ngân sách + progress bar đã tiêu

**Checkpoint cuối tuần:** Dashboard hiển thị đúng data, biểu đồ đẹp, responsive

---

### 📅 TUẦN 5 — Parent Flow & Notification (20/03 - 26/03)

**Mục tiêu:** Parent liên kết được với student, xem data real-time

**Việc cần làm:**
- [ ] Màn hình tạo mã liên kết (Student):
  - Generate mã 6 số random
  - Lưu vào Firestore collection `linkRequests`
  - Countdown timer 24h
  - Nút copy mã
- [ ] Màn hình nhập mã (Parent):
  - Input 6 ô số tách biệt
  - Validate mã hợp lệ + chưa hết hạn
  - Cập nhật `linkedStudentId` / `linkedParentId` trong users
- [ ] Parent Dashboard: Clone Student Dashboard nhưng đọc data của student
- [ ] Parent Transaction History: Real-time stream từ Firestore
- [ ] Push Notification — thay thế bằng 2 lớp:
  - **Lớp 1 — In-app Notification (Firestore):** Khi student lưu giao dịch > 500k, Flutter client tự ghi vào collection `notifications`. Parent mở app → StreamBuilder hiển thị badge + danh sách thông báo real-time
  - **Lớp 2 — Local Notification:** Dùng `flutter_local_notifications` hiển thị banner khi app đang chạy foreground
  - ✅ Hoàn toàn free, không cần FCM hay Cloud Functions

**Checkpoint cuối tuần:** Parent nhập mã → xem data con real-time → nhận thông báo

---

### 📅 TUẦN 6 — OCR + Budget + Testing (27/03 - 02/04)

**Mục tiêu:** Tính năng OCR, hoàn thiện budget, fix bug

**Việc cần làm:**
- [ ] Tích hợp Google ML Kit Text Recognition
- [ ] Màn hình camera để chụp hóa đơn
- [ ] Parse text nhận dạng để trích xuất số tiền lớn nhất
- [ ] Upload ảnh lên Firebase Storage
- [ ] Hiển thị icon 📷 trên giao dịch có ảnh hóa đơn
- [ ] Cảnh báo trong app khi vượt 80% budget
- [ ] Viết Unit Test cho:
  - Transaction model
  - Category classification logic
  - Link code generation
- [ ] Fix toàn bộ bug tồn đọng
- [ ] Test trên cả Android và iOS simulator

**Checkpoint cuối tuần:** Chụp hóa đơn → số tiền tự điền vào form → lưu kèm ảnh

---

### 📅 TUẦN 7 — UI Polish + Tài liệu + Demo (03/04 - 10/04)

**Mục tiêu:** App đẹp, ổn định, sẵn sàng nộp

**Việc cần làm:**
- [ ] UI Polish: Màu sắc đồng nhất, spacing, border radius
- [ ] Empty states: Màn hình khi chưa có dữ liệu (đẹp, không trống trải)
- [ ] Loading states: Skeleton loading khi fetch data
- [ ] Error handling: Toast/Snackbar thông báo lỗi rõ ràng
- [ ] Viết báo cáo đồ án (theo template của trường)
- [ ] Viết README hướng dẫn cài đặt và chạy app
- [ ] Quay video demo 3-5 phút
- [ ] Build APK để demo

**Checkpoint cuối tuần:** App hoàn chỉnh, tài liệu đầy đủ, sẵn sàng nộp ✅

---

## 7. PHÂN TÍCH AI INTEGRATION

### 7.1 AI Feature 1: Phân loại giao dịch tự động ⭐ (Chính)

| Tiêu chí | Chi tiết |
|---|---|
| Input | Ghi chú giao dịch (tiếng Việt) |
| Output | 1 trong 8 danh mục |
| Model | Gemini 1.5 Flash |
| Cách gọi | Trực tiếp từ Flutter (`google_generative_ai` package) |
| Quota | Free: 15 requests/phút, 1500 requests/ngày — đủ cho demo |
| Độ chính xác dự kiến | 88-92% với tiếng Việt |
| Chi phí | **$0 — hoàn toàn miễn phí** |
| Thời gian phản hồi | 1-2 giây |

**Giá trị thực tế:** Giảm friction khi nhập giao dịch, user không cần chọn tay → tăng khả năng duy trì thói quen ghi chép.

### 7.2 AI Feature 2: OCR hóa đơn (Bổ trợ)

| Tiêu chí | Chi tiết |
|---|---|
| Input | Ảnh hóa đơn từ camera |
| Output | Số tiền trích xuất + text thô |
| Model | Google ML Kit Text Recognition v2 |
| Độ chính xác dự kiến | 75-85% (tùy chất lượng ảnh) |
| Chi phí | Miễn phí, chạy on-device |
| Thêm giá trị | Ảnh hóa đơn = bằng chứng cho parent |

---

## 8. UI/UX GUIDELINES

### 8.1 Color Palette (Đề xuất thay thế)

```
Primary:     #2E7D32  (Xanh lá đậm — liên quan đến tài chính/tiền)
Secondary:   #66BB6A  (Xanh lá nhạt)
Background:  #F5F5F5  (Xám rất nhạt — thay cho tối)
Surface:     #FFFFFF  (Trắng)
Error:       #D32F2F  (Đỏ — cho chi tiêu vượt ngân sách)
Income:      #1976D2  (Xanh dương — thu nhập)
Expense:     #D32F2F  (Đỏ — chi tiêu)
Text Primary: #212121
Text Secondary: #757575
```

### 8.2 Design Principles
- **Clean & Minimal:** Tập trung vào data, không rối mắt
- **Color coding nhất quán:** Xanh = thu, Đỏ = chi, luôn luôn
- **Border radius:** 12px cho cards, 8px cho buttons
- **Shadow:** Nhẹ, không quá đậm
- **Typography:** Số tiền phải nổi bật, to, dễ đọc

---

## 9. RỦI RO & PHƯƠNG ÁN DỰ PHÒNG

| Rủi ro | Xác suất | Giải pháp |
|---|---|---|
| Gemini API key lộ trong app | Thấp | Dùng `--dart-define`, không commit lên Git. Chấp nhận được với đồ án demo |
| Gemini API chậm hoặc lỗi | Thấp | Fallback về `other`, user chọn tay. Có retry logic |
| OCR không nhận được số tiền | Trung bình | Cho user sửa tay sau khi OCR, không bắt buộc |
| Real-time sync chậm | Thấp | Dùng Firestore `snapshots()` thay vì polling |
| In-app notification parent không thấy ngay | Trung bình | Chấp nhận với đồ án — parent cần mở app. Ghi rõ giới hạn trong báo cáo |
| Hết thời gian | Trung bình | OCR là SHOULD HAVE, bỏ nếu cần để focus core |

---

## 10. TIÊU CHÍ ĐÁNH GIÁ DỰ KIẾN

| Tiêu chí | Điểm tối đa | Dự kiến | Lý do |
|---|---|---|---|
| Tính năng | 40 | 34-36 | Đủ core features, có parent flow, có budget |
| AI Application | 25 | 21-23 | Gemini phân loại (chính) + OCR (bổ trợ), giá trị thực tế rõ ràng |
| Triển khai | 20 | 16-17 | Flutter clean architecture, Firebase đúng cách, có test |
| UI/UX | 10 | 8 | Sau khi fix màu sắc và border theo hướng dẫn |
| Tài liệu | 5 | 4-5 | Báo cáo rõ ràng, có README, video demo |
| **TỔNG** | **100** | **83-89** | **Xếp loại: Giỏi 🎉** |

---

## 11. HƯỚNG DẪN CÀI ĐẶT & CHẠY DỰ ÁN

```bash
# 1. Clone repository
git clone https://github.com/[username]/smartspending.git
cd smartspending

# 2. Cài dependencies
flutter pub get

# 3. Cấu hình Firebase
# - Tạo project trên Firebase Console
# - Tải google-services.json (Android) vào android/app/
# - Tải GoogleService-Info.plist (iOS) vào ios/Runner/
# - Chạy: flutterfire configure

# 4. Cấu hình Gemini API Key
# - Tạo file .env hoặc thêm vào Firebase Remote Config
# - KHÔNG commit API key lên Git

# 5. Chạy app
flutter run

# 6. Build APK (Android)
flutter build apk --release
```

**Yêu cầu môi trường:**
- Flutter SDK >= 3.16.0
- Dart >= 3.2.0
- Android Studio / Xcode
- Firebase project đã cấu hình

---

*Tài liệu này được lập ngày 20/02/2025*
*Cập nhật lần cuối theo buổi trao đổi với GV hướng dẫn*

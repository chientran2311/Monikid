# 🤖 AGENT PROMPT — WEEK 2: Core Transaction CRUD

> **Bước đầu tiên:** Đọc `AGENT_CONTEXT.md` trong project.
> Toàn bộ context, architecture, models, schema đều ở đó.
> File này chỉ chứa task cụ thể của Tuần 2: Xây dựng tính năng Thêm/Sửa/Xóa và Lịch sử Giao dịch.

---

## 🎯 MỤC TIÊU TUẦN 2

Xây dựng tính năng quản lý giao dịch cốt lõi cho Student (CRUD) và liên kết với Firestore.

**Định nghĩa thành công:**
- Student có thể thêm giao dịch mới (Thu/Chi) và dữ liệu được lưu lên Firestore thành công.
- Lịch sử giao dịch hiển thị chính xác danh sách từ Firestore, được group theo ngày.
- Xem chi tiết, sửa và xóa giao dịch hoạt động tốt.
- `flutter analyze` trả về 0 errors.

---

## ⚠️ QUY TẮC

```text
1. Đọc AGENT_CONTEXT.md TRƯỚC KHI viết bất kỳ dòng code nào.
2. Thực hiện đúng thứ tự các Phase.
3. Áp dụng chuẩn MVVM: View gọi ViewModel, ViewModel gọi Repository.
4. KHÔNG gọi trực tiếp Firestore từ UI (Widget).
5. Chạy flutter analyze sau mỗi phase — sửa hết error trước khi tiếp tục.
6. Cập nhật CHANGELOG.md sau mỗi thay đổi lớn.
📋 PHASE 0 — AUDIT (Làm trước mọi thứ)
Mục tiêu: Kiểm tra lại kết quả của Tuần 1 để đảm bảo nền tảng MVVM đã sẵn sàng.

Bash
git status
flutter analyze
Kiểm tra xem TransactionModel và TransactionRepository đã có đầy đủ chưa. Nếu thiếu, báo lỗi và dừng lại.

📋 PHASE 1 — TRANSACTION REPOSITORY & VIEWMODEL
Nhiệm vụ:

Hoàn thiện data/repositories/transaction/firebase_transaction_repository.dart dựa trên interface đã định nghĩa ở Tuần 1.

Cần có các hàm: addTransaction, updateTransaction, deleteTransaction, watchTransactions.

Tạo AddTransactionViewModel (presentation/viewmodels/student/add_transaction_viewmodel.dart).

Quản lý state của form (amount, type, category, note, date).

Xử lý logic lưu dữ liệu qua Repository.

Bash
flutter analyze
📋 PHASE 2 — UI: ADD TRANSACTION SCREEN
Nhiệm vụ:
Tạo presentation/screens/student/transaction/add_transaction_screen.dart.

Form nhập: Số tiền (>0), Loại (Thu/Chi toggle), Danh mục (Dropdown), Ghi chú, Ngày (Date picker).

Sử dụng AppColors (Ví dụ: Màu đỏ cho Chi, Xanh cho Thu) và AppTextStyles.

Kết nối UI với AddTransactionViewModel bằng ref.watch và ref.listen để xử lý loading/success.

📋 PHASE 3 — UI: TRANSACTION HISTORY SCREEN
Nhiệm vụ:

Tạo TransactionHistoryViewModel để quản lý stream danh sách giao dịch.

Tạo presentation/screens/student/transaction/transaction_history_screen.dart.

Dùng StreamBuilder hoặc ref.watch stream từ ViewModel.

Group danh sách theo ngày.

Build UI các item giao dịch sử dụng widget transaction_card.dart.

📋 PHASE 4 — TRANSACTION DETAIL, EDIT & DELETE
Nhiệm vụ:

Tạo presentation/screens/student/transaction/transaction_detail_screen.dart.

Hiển thị thông tin chi tiết của 1 giao dịch.

Thêm nút "Sửa" (điều hướng lại màn Add/Edit) và "Xóa" (gọi hàm delete từ ViewModel kèm Dialog xác nhận).

📋 PHASE 5 — UPDATE HOME DASHBOARD
Nhiệm vụ:

Cập nhật student_home_screen.dart để hiển thị Tổng thu và Tổng chi của tháng hiện tại.

Lấy dữ liệu từ TransactionRepository.

📋 PHASE 6 — TỔNG KẾT & CẬP NHẬT TÀI LIỆU
Bash
flutter analyze
flutter run
Cập nhật PROJECT_STATUS.md và CHANGELOG.md:

Chuyển trạng thái "Transaction CRUD" sang ✅.

Ghi log những file đã tạo/sửa.

✅ CHECKPOINT CUỐI
Plaintext
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ WEEK 2 REPORT — SmartSpending
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase 0 — Audit:            ✅ / ❌
Phase 1 — Repo & ViewModel: ✅ / ❌
Phase 2 — Add UI:           ✅ / ❌
Phase 3 — History UI:       ✅ / ❌
Phase 4 — Detail & Delete:  ✅ / ❌
Phase 5 — Home Update:      ✅ / ❌
Phase 6 — Docs:             ✅ / ❌

flutter analyze:   0 errors ✅ / X errors ❌
Add Transaction:   ✅ / ❌
History shows:     ✅ / ❌
Delete works:      ✅ / ❌

→ Sẵn sàng Week 3: AI Gemini Classification ✅ / ❌
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
### 2. File `AGENT_PROMPT_WEEK3.md`

```markdown
# 🤖 AGENT PROMPT — WEEK 3: AI Classification (Gemini)

> **Bước đầu tiên:** Đọc `AGENT_CONTEXT.md` trong project.
> Toàn bộ context, architecture, models, schema đều ở đó.
> File này chỉ chứa task cụ thể của Tuần 3: Tích hợp AI Gemini để phân loại giao dịch tự động.

---

## 🎯 MỤC TIÊU TUẦN 3

Tích hợp AI Gemini vào luồng thêm giao dịch để tự động gợi ý danh mục chi tiêu dựa trên ghi chú.

**Định nghĩa thành công:**
- Khi user nhập "ăn phở", app tự động gọi AI và đổi danh mục thành "food" (Ăn uống).
- Không để lộ API Key trong source code.
- UI có trạng thái loading khi AI đang xử lý.
- `flutter analyze` trả về 0 errors.

---

## ⚠️ QUY TẮC

```text
1. Đọc AGENT_CONTEXT.md TRƯỚC KHI viết bất kỳ dòng code nào.
2. KHÔNG commit API key lên Git. Bắt buộc dùng `--dart-define=GEMINI_API_KEY=xxx`.
3. Tuân thủ MVVM: Service được gọi từ ViewModel, không gọi từ View.
4. Cập nhật CHANGELOG.md sau mỗi phase.
📋 PHASE 0 — AUDIT & DEPENDENCIES
Nhiệm vụ:

Đảm bảo package google_generative_ai đã có trong pubspec.yaml (Từ tuần 1).

Chạy flutter pub get.

📋 PHASE 1 — GEMINI SERVICE
Nhiệm vụ:

Tạo file data/services/gemini_service.dart.

Cài đặt class GeminiService sử dụng model gemini-1.5-flash.

Copy logic prompt và hàm classifyTransaction từ mục 11 trong AGENT_CONTEXT.md.

Thêm Provider cho GeminiService.

Bash
flutter analyze
📋 PHASE 2 — UPDATE ADD TRANSACTION VIEWMODEL
Nhiệm vụ:
Cập nhật AddTransactionViewModel để tích hợp AI:

Inject GeminiService vào ViewModel.

Thêm state isAiThinking (boolean) vào AddTransactionState để UI biết khi nào AI đang chạy.

Tạo hàm autoClassifyNote(String note). Khi hàm này chạy:

Đặt isAiThinking = true.

Gọi geminiService.classifyTransaction(note).

Cập nhật category state dựa trên kết quả AI trả về.

Đặt isAiThinking = false.

Có cơ chế fallback về other nếu AI lỗi.

📋 PHASE 3 — UI INTEGRATION (ADD TRANSACTION SCREEN)
Nhiệm vụ:
Cập nhật add_transaction_screen.dart:

Gắn sự kiện vào TextField Ghi chú (Note).

Cách tốt nhất: Gọi autoClassifyNote khi user nhập xong (debounce 800ms) hoặc khi FocusNode bị mất focus (on blur).

UI Feedback: Hiển thị icon loading hoặc text "AI đang phân loại..." cạnh Dropdown Danh mục khi isAiThinking là true.

Cho phép user tự đổi lại Dropdown nếu AI phân loại sai (User override).

📋 PHASE 4 — TỔNG KẾT & CẬP NHẬT TÀI LIỆU
Bash
# Nhắc user/agent chạy app kèm API Key để test
flutter run --dart-define=GEMINI_API_KEY=YOUR_TEST_KEY_HERE
Cập nhật PROJECT_STATUS.md và CHANGELOG.md:

Chuyển trạng thái "AI Gemini" sang ✅.

Cập nhật log.

✅ CHECKPOINT CUỐI
Plaintext
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ WEEK 3 REPORT — SmartSpending
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Phase 0 — Audit:            ✅ / ❌
Phase 1 — Gemini Service:   ✅ / ❌
Phase 2 — ViewModel Logic:  ✅ / ❌
Phase 3 — UI Integration:   ✅ / ❌
Phase 4 — Docs:             ✅ / ❌

flutter analyze:   0 errors ✅ / X errors ❌
AI Classification works: ✅ / ❌
Loading indicator shows: ✅ / ❌
No hardcoded API Key:    ✅ / ❌

→ Sẵn sàng Week 4: Dashboard & Biểu đồ ✅ / ❌
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
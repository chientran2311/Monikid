import 'package:monikid/models/entities/faq/faq_model.dart';

// Mock FAQ data for child and parent roles, in English and Vietnamese.
//
// Each role exposes 10 question/answer pairs. The same 10 questions appear in
// both languages, so `childFaqsEn[i]` and `childFaqsVi[i]` describe the same
// topic. IDs are role-prefixed and stable (`child_001`, `parent_010`, ...) so
// the en/vi variants of one question share the same ID.
//
// Topics are drawn from real app features:
//   Child  — money limit, transactions, receipt OCR, AI model, history,
//            statistics, join family, language/theme, PIN.
//   Parent — create/manage family, invite child, monitor spending, child
//            transaction details, category breakdown, notifications, profile.

/// Child FAQs — English.
List<FAQModel> get childFaqsEn => const [
  FAQModel(
    id: 'child_001',
    question: 'How do I set a spending limit?',
    answer:
        'Open the Home tab and tap the "Limit" area, enter the amount you want to allow, then tap Save. Your balance overview updates against this limit.',
  ),
  FAQModel(
    id: 'child_002',
    question: 'How do I add a transaction?',
    answer:
        'On the Transactions tab, tap the + button, fill in the amount, category and note, then save. The transaction appears in your history right away.',
  ),
  FAQModel(
    id: 'child_003',
    question: 'Can I edit or delete a transaction?',
    answer:
        'Yes. Open a transaction from the Transactions tab to view its details, then choose Edit to change it or Delete to remove it.',
  ),
  FAQModel(
    id: 'child_004',
    question: 'How do I scan a receipt?',
    answer:
        'When adding a transaction, tap the camera icon to take a photo or pick a receipt image from your gallery. The app reads the amount and merchant for you.',
  ),
  FAQModel(
    id: 'child_005',
    question: 'How do I choose the AI model for receipt scanning?',
    answer:
        'Go to Settings and open "Choose AI Model". Pick the model you want to use, and it will be applied the next time you scan a receipt.',
  ),
  FAQModel(
    id: 'child_006',
    question: 'How do I view my transaction history?',
    answer:
        'Open the Transactions tab to see all of your past transactions. You can filter and search to find a specific one.',
  ),
  FAQModel(
    id: 'child_007',
    question: 'How do I read my statistics?',
    answer:
        'Open the Statistics tab to see your spending broken down by category. Tap a category to view the transactions inside it.',
  ),
  FAQModel(
    id: 'child_008',
    question: 'How do I join a family?',
    answer:
        'Go to Settings and open "Join Family". Enter the family code your parent shares, or scan their QR code, to connect your account.',
  ),
  FAQModel(
    id: 'child_009',
    question: 'How do I change the language or dark mode?',
    answer:
        'Open Settings, choose Language to switch between English and Vietnamese, or toggle Dark Mode to change the app appearance.',
  ),
  FAQModel(
    id: 'child_010',
    question: 'How do I change my PIN?',
    answer:
        'Go to Settings, open your Profile, choose Change PIN, then enter your current PIN followed by the new one.',
  ),
];

/// Child FAQs — Vietnamese.
List<FAQModel> get childFaqsVi => const [
  FAQModel(
    id: 'child_001',
    question: 'Làm thế nào để đặt hạn mức chi tiêu?',
    answer:
        'Vào tab Trang chủ, nhấn vào khu vực "Hạn mức", nhập số tiền bạn muốn giới hạn rồi nhấn Lưu. Tổng quan số dư sẽ tính theo hạn mức này.',
  ),
  FAQModel(
    id: 'child_002',
    question: 'Làm thế nào để thêm một giao dịch?',
    answer:
        'Ở tab Giao dịch, nhấn nút +, điền số tiền, danh mục và ghi chú rồi lưu lại. Giao dịch sẽ xuất hiện ngay trong lịch sử của bạn.',
  ),
  FAQModel(
    id: 'child_003',
    question: 'Tôi có thể sửa hoặc xóa giao dịch không?',
    answer:
        'Có. Mở một giao dịch từ tab Giao dịch để xem chi tiết, sau đó chọn Sửa để thay đổi hoặc Xóa để gỡ bỏ.',
  ),
  FAQModel(
    id: 'child_004',
    question: 'Làm thế nào để chụp hóa đơn?',
    answer:
        'Khi thêm giao dịch, nhấn biểu tượng camera để chụp ảnh hoặc chọn ảnh hóa đơn từ thư viện. Ứng dụng sẽ tự đọc số tiền và tên cửa hàng cho bạn.',
  ),
  FAQModel(
    id: 'child_005',
    question: 'Làm thế nào để chọn mô hình AI cho việc quét hóa đơn?',
    answer:
        'Vào Cài đặt và mở "Chọn mô hình AI". Chọn mô hình bạn muốn dùng, nó sẽ được áp dụng cho lần quét hóa đơn tiếp theo.',
  ),
  FAQModel(
    id: 'child_006',
    question: 'Làm sao để xem lịch sử giao dịch?',
    answer:
        'Mở tab Giao dịch để xem toàn bộ giao dịch trước đây. Bạn có thể lọc và tìm kiếm để tìm một giao dịch cụ thể.',
  ),
  FAQModel(
    id: 'child_007',
    question: 'Làm thế nào để xem thống kê của tôi?',
    answer:
        'Mở tab Thống kê để xem chi tiêu được chia theo danh mục. Nhấn vào một danh mục để xem các giao dịch bên trong.',
  ),
  FAQModel(
    id: 'child_008',
    question: 'Làm thế nào để tham gia một gia đình?',
    answer:
        'Vào Cài đặt và mở "Tham gia gia đình". Nhập mã gia đình mà bố mẹ chia sẻ, hoặc quét mã QR của họ, để kết nối tài khoản.',
  ),
  FAQModel(
    id: 'child_009',
    question: 'Làm thế nào để đổi ngôn ngữ hoặc chế độ tối?',
    answer:
        'Mở Cài đặt, chọn Ngôn ngữ để chuyển giữa Tiếng Anh và Tiếng Việt, hoặc bật Chế độ tối để thay đổi giao diện ứng dụng.',
  ),
  FAQModel(
    id: 'child_010',
    question: 'Làm thế nào để đổi mã PIN?',
    answer:
        'Vào Cài đặt, mở Hồ sơ, chọn Đổi PIN, sau đó nhập PIN hiện tại rồi đến PIN mới.',
  ),
];

/// Parent FAQs — English.
List<FAQModel> get parentFaqsEn => const [
  FAQModel(
    id: 'parent_001',
    question: 'How do I create a family?',
    answer:
        'On the Home tab, choose Create Family. Once created, you become the family owner and can invite your children to join.',
  ),
  FAQModel(
    id: 'parent_002',
    question: 'How do I invite my child?',
    answer:
        'From the Home tab, open the invite option to get your family code. Share that code (or its QR) with your child so they can join from their device.',
  ),
  FAQModel(
    id: 'parent_003',
    question: 'How do I see my family members?',
    answer:
        'The Home tab shows the list of family members with their current status, so you can see everyone connected to your family at a glance.',
  ),
  FAQModel(
    id: 'parent_004',
    question: "How do I monitor a child's spending?",
    answer:
        "Open the Statistics tab to view each child's spending by category, with expense and income breakdowns for the selected period.",
  ),
  FAQModel(
    id: 'parent_005',
    question: "How do I view a specific child's transaction details?",
    answer:
        'In the Statistics tab, drill into a child and tap a transaction to see its full details, including category, note and date.',
  ),
  FAQModel(
    id: 'parent_006',
    question: 'How do I see the category breakdown?',
    answer:
        'On the Statistics tab, tap any category to expand it and view the list of transactions that make up that category total.',
  ),
  FAQModel(
    id: 'parent_007',
    question: 'How do I manage or remove family members?',
    answer:
        'Open Settings and choose Manage Family. From there you can add new members or remove someone from the family.',
  ),
  FAQModel(
    id: 'parent_008',
    question: 'How do I configure notifications?',
    answer:
        'Go to Settings, open Notification Settings, and adjust your alerts. You can also schedule when notifications are delivered.',
  ),
  FAQModel(
    id: 'parent_009',
    question: 'How do I edit my profile?',
    answer:
        'Open Settings and choose Edit Profile to update your name, avatar and other account information.',
  ),
  FAQModel(
    id: 'parent_010',
    question: 'How do I change the language or dark mode?',
    answer:
        'Open Settings, choose Language to switch between English and Vietnamese, or toggle Dark Mode to change the app appearance.',
  ),
];

/// Parent FAQs — Vietnamese.
List<FAQModel> get parentFaqsVi => const [
  FAQModel(
    id: 'parent_001',
    question: 'Làm thế nào để tạo một gia đình?',
    answer:
        'Ở tab Trang chủ, chọn Tạo gia đình. Sau khi tạo, bạn trở thành chủ gia đình và có thể mời các con tham gia.',
  ),
  FAQModel(
    id: 'parent_002',
    question: 'Làm thế nào để mời con của tôi?',
    answer:
        'Từ tab Trang chủ, mở tùy chọn mời để lấy mã gia đình. Chia sẻ mã đó (hoặc mã QR) cho con để con tham gia từ thiết bị của mình.',
  ),
  FAQModel(
    id: 'parent_003',
    question: 'Làm thế nào để xem các thành viên trong gia đình?',
    answer:
        'Tab Trang chủ hiển thị danh sách thành viên gia đình cùng trạng thái hiện tại, giúp bạn thấy nhanh mọi người đang kết nối trong gia đình.',
  ),
  FAQModel(
    id: 'parent_004',
    question: 'Làm thế nào để theo dõi chi tiêu của con?',
    answer:
        'Mở tab Thống kê để xem chi tiêu của từng con theo danh mục, kèm phân tích chi và thu trong khoảng thời gian đã chọn.',
  ),
  FAQModel(
    id: 'parent_005',
    question: 'Làm thế nào để xem chi tiết giao dịch của một con cụ thể?',
    answer:
        'Trong tab Thống kê, mở thông tin của một con và nhấn vào một giao dịch để xem đầy đủ chi tiết, gồm danh mục, ghi chú và ngày.',
  ),
  FAQModel(
    id: 'parent_006',
    question: 'Làm thế nào để xem phân tích theo danh mục?',
    answer:
        'Ở tab Thống kê, nhấn vào bất kỳ danh mục nào để mở rộng và xem danh sách các giao dịch tạo nên tổng của danh mục đó.',
  ),
  FAQModel(
    id: 'parent_007',
    question: 'Làm thế nào để quản lý hoặc xóa thành viên gia đình?',
    answer:
        'Mở Cài đặt và chọn Quản lý gia đình. Từ đó bạn có thể thêm thành viên mới hoặc xóa một người khỏi gia đình.',
  ),
  FAQModel(
    id: 'parent_008',
    question: 'Làm thế nào để cấu hình thông báo?',
    answer:
        'Vào Cài đặt, mở Cài đặt thông báo và điều chỉnh các cảnh báo. Bạn cũng có thể lên lịch thời điểm gửi thông báo.',
  ),
  FAQModel(
    id: 'parent_009',
    question: 'Làm thế nào để chỉnh sửa hồ sơ của tôi?',
    answer:
        'Mở Cài đặt và chọn Chỉnh sửa hồ sơ để cập nhật tên, ảnh đại diện và các thông tin tài khoản khác.',
  ),
  FAQModel(
    id: 'parent_010',
    question: 'Làm thế nào để đổi ngôn ngữ hoặc chế độ tối?',
    answer:
        'Mở Cài đặt, chọn Ngôn ngữ để chuyển giữa Tiếng Anh và Tiếng Việt, hoặc bật Chế độ tối để thay đổi giao diện ứng dụng.',
  ),
];

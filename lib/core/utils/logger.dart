import 'package:logger/logger.dart';

/// Khởi tạo Logger global
/// Sử dụng:
/// logger.t("Trace log"); // Log luồng chi tiết (màu xám)
/// logger.d("Debug log"); // Log debug (màu xanh dương)
/// logger.i("Info log");  // Log thông tin (màu xanh lá)
/// logger.w("Warning");   // Log cảnh báo (màu vàng)
/// logger.e("Error", error: e, stackTrace: stack); // Log lỗi (màu đỏ)
/// logger.f("Fatal");     // Log lỗi nghiêm trọng (màu tím)

final logger = Logger(
  // 1. Filter: Quyết định log nào được hiển thị
  // DevelopmentFilter: Chỉ log khi đang chạy debug (kReleaseMode = false)
  // ProductionFilter: Log tất cả (kể cả release).
  filter: DevelopmentFilter(), 

  // 2. Printer: Định dạng log (Màu sắc, dòng kẻ, stack trace)
  printer: PrettyPrinter(
    methodCount: 0, // Số lượng dòng stack trace hiển thị cho log thường (Info/Debug)
    errorMethodCount: 8, // Số lượng dòng stack trace hiển thị cho log lỗi (Error)
    lineLength: 120, // Độ dài dòng kẻ ngang
    colors: true, // Hiển thị màu sắc (Chỉ hoạt động trên Console hỗ trợ màu)
    printEmojis: true, // Hiển thị icon cảm xúc (🐛, 💡, ⛔...)
    
    // Định dạng thời gian (Optional)
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, 
  ),
);

// --- (Tùy chọn) Hàm Log chặn dòng dài ---
// Đôi khi log JSON quá dài bị cắt, dùng hàm này để in hết
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // Cắt mỗi 800 ký tự
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get close => 'Đóng';

  @override
  String get validationEmptyFields => 'Vui lòng điền đủ thông tin (Tên, Email, Mật khẩu)';

  @override
  String registerFailed(String error) {
    return 'Đăng ký thất bại: $error';
  }

  @override
  String get noTransactionsYet => 'Chưa có giao dịch nào.';

  @override
  String errorGeneric(String error) {
    return 'Lỗi: $error';
  }

  @override
  String get settingFQA => 'Câu hỏi thường gặp';

  @override
  String get msgNoData => 'Không có dữ liệu';

  @override
  String get helpStillNeedHelp => 'Vẫn cần trợ giúp?';

  @override
  String get helpContactSupportDesc => 'Nếu bạn không tìm thấy câu trả lời, hãy liên hệ với đội ngũ hỗ trợ của chúng tôi 24/7.';

  @override
  String get actionChatWithUs => 'Chat với chúng tôi';

  @override
  String get actionRetry => 'Thử lại';

  @override
  String get validationEnterAmount => 'Vui lòng nhập số tiền';

  @override
  String get validationAmountGreaterThanZero => 'Số tiền phải lớn hơn 0';

  @override
  String get msgAddTransactionSuccess => 'Thêm giao dịch thành công!';

  @override
  String get msgTransactionDeleted => 'Đã xóa giao dịch';

  @override
  String get actionCancel => 'Hủy';

  @override
  String get actionConfirm => 'Xác nhận';

  @override
  String get validationInvalidAmount => 'Số tiền không hợp lệ';

  @override
  String get msgUpdateSuccess => 'Cập nhật thành công';

  @override
  String get addTransactionFailed => 'Không thể thêm giao dịch. Vui lòng thử lại.';

  @override
  String get updateTransactionFailed => 'Không thể cập nhật giao dịch. Vui lòng thử lại.';

  @override
  String get updateTransactionMissingError => 'Không tìm thấy giao dịch để cập nhật.';

  @override
  String get transactionLoadError => 'Không thể tải giao dịch.';

  @override
  String get transactionCategoryLoadError => 'Không thể tải danh mục. Vui lòng thử lại.';

  @override
  String get transactionUserNotAuthenticated => 'Người dùng chưa được xác thực.';

  @override
  String get transactionAmountLabel => 'Số tiền';

  @override
  String get transactionCategoryLabel => 'Danh mục';

  @override
  String get transactionDateLabel => 'Ngày';

  @override
  String get transactionNoteLabel => 'Ghi chú';

  @override
  String get transactionExpenseType => 'Tiền chi';

  @override
  String get transactionIncomeType => 'Tiền thu';

  @override
  String get transactionSaveAction => 'Lưu giao dịch';

  @override
  String get transactionAiAutoLabel => 'AI tự động';

  @override
  String get addTransactionNoteHint => 'Nhập ghi chú, AI sẽ tự động phân loại...';

  @override
  String get updateTransactionTitle => 'Chỉnh sửa giao dịch';

  @override
  String get updateTransactionAction => 'Cập nhật giao dịch';

  @override
  String get updateTransactionNoteHint => 'Thêm ghi chú...';

  @override
  String get updateTransactionWalletLabel => 'Ví nguồn';

  @override
  String get updateTransactionCashWalletValue => 'Tiền mặt';

  @override
  String get transactionDetailTitle => 'Chi tiết giao dịch';

  @override
  String get transactionDetailNoData => 'Không có dữ liệu giao dịch.';

  @override
  String get transactionDetailTimeLabel => 'THỜI GIAN';

  @override
  String get transactionDetailSourceLabel => 'NGUỒN TIỀN';

  @override
  String get transactionDetailNoteLabel => 'GHI CHÚ';

  @override
  String get transactionEditAction => 'Chỉnh sửa giao dịch';

  @override
  String get transactionDeleteAction => 'Xóa giao dịch';

  @override
  String get transactionEvidenceSectionTitle => 'Ảnh minh chứng';

  @override
  String get transactionEvidenceOptionalLabel => 'Tùy chọn. Thêm 1 ảnh minh chứng cho giao dịch này.';

  @override
  String get transactionEvidenceAddAction => 'Thêm ảnh';

  @override
  String get transactionEvidenceReplaceAction => 'Thay ảnh';

  @override
  String get transactionEvidenceRemoveAction => 'Gỡ ảnh';

  @override
  String get transactionEvidenceSelectedLabel => 'Ảnh đã chọn';

  @override
  String get transactionEvidenceAttachedLabel => 'Đã có ảnh minh chứng';

  @override
  String get transactionEvidenceEmpty => 'Chưa có ảnh minh chứng.';

  @override
  String get transactionEvidenceLoadError => 'Không thể tải ảnh minh chứng.';

  @override
  String get transactionEvidenceUploadTimeout => 'Tải ảnh lên quá lâu. Vui lòng thử lại.';

  @override
  String get profileEditTitle => 'Chỉnh sửa hồ sơ';

  @override
  String get profileEditAvatarLabel => 'Thay đổi ảnh đại diện';

  @override
  String get profileEditFullName => 'Họ và tên';

  @override
  String get profileEditFullNameHint => 'Nhập họ và tên của bạn';

  @override
  String get profileEditPhone => 'Số điện thoại';

  @override
  String get profileEditPhoneHint => 'Nhập số điện thoại';

  @override
  String get profileEditEmail => 'Email';

  @override
  String get profileEditEmailWarning => 'Email không thể thay đổi để bảo mật tài khoản.';

  @override
  String get profileEditDob => 'Ngày sinh';

  @override
  String get profileEditDobHint => 'DD/MM/YYYY';

  @override
  String get actionSaveChanges => 'Lưu thay đổi';

  @override
  String get editRequestTitle => 'Chỉnh sửa yêu cầu';

  @override
  String get requestAmountLabel => 'Số tiền yêu cầu';

  @override
  String get requestReasonLabel => 'Lý do của con';

  @override
  String get categoryBooks => 'Mua sách/vở';

  @override
  String get categorySnacks => 'Ăn vặt';

  @override
  String get categoryGames => 'Nạp game';

  @override
  String get categoryGifts => 'Quà tặng';

  @override
  String get additionalNoteLabel => 'Ghi chú thêm';

  @override
  String get whatDoYouNeedToBuyHint => 'Con cần mua gì?';

  @override
  String get requestRecipientLabel => 'Người nhận yêu cầu';

  @override
  String get recipientDad => 'Bố';

  @override
  String get recipientMom => 'Mẹ';

  @override
  String get actionUpdateRequest => 'Cập nhật yêu cầu';

  @override
  String get actionDeleteRequest => 'Xóa yêu cầu';

  @override
  String get scanbill => 'Quét Hóa Đơn';

  @override
  String get chatting => 'Trò Chuyện';

  @override
  String get requestmoney => 'Xin Tiền';

  @override
  String get takePicture => 'Chụp ảnh';

  @override
  String get chooseFromGallery => 'Tải ảnh lên';

  @override
  String get scanReceiptTitle => 'Quét hoá đơn';

  @override
  String get scanReceiptDesc => 'Chọn cách thêm ảnh hoá đơn để xử lý.';

  @override
  String get authPasswordLabel => 'Mật khẩu';

  @override
  String get authPasswordPlaceholder => 'Nhập mật khẩu của bạn';

  @override
  String get authSignUpAction => 'Đăng ký';

  @override
  String get authSignInAction => 'Đăng nhập';

  @override
  String get authNoAccountPrompt => 'Chưa có tài khoản? ';

  @override
  String get authHaveAccountPrompt => 'Đã có tài khoản? ';

  @override
  String get pinCreateTitle => 'Tạo mã PIN mới';

  @override
  String get pinCreateDescription => 'Tạo mã PIN 6 chữ số để bảo vệ tài khoản của bạn.';

  @override
  String get pinReEnterTitle => 'Xác nhận lại mã PIN';

  @override
  String get pinReEnterDescription => 'Nhập lại mã PIN vừa tạo để xác nhận.';

  @override
  String get pinEnterTitle => 'Nhập mã PIN';

  @override
  String get pinEnterDescription => 'Nhập mã PIN 6 chữ số để tiếp tục.';

  @override
  String get pinMismatchError => 'Mã PIN xác nhận không khớp.';

  @override
  String get pinIncorrectError => 'Mã PIN bạn nhập không đúng.';

  @override
  String pinLockedMessage(int seconds) {
    return 'Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau $seconds giây.';
  }

  @override
  String get pinGenericError => 'Đã xảy ra lỗi với mã PIN. Vui lòng thử lại.';

  @override
  String get pinGatewayLoading => 'Đang kiểm tra bảo mật mã PIN...';

  @override
  String get pinGatewayError => 'Không thể khởi động luồng xác thực mã PIN.';

  @override
  String get homeStudentGreeting => 'Chào buổi sáng,';

  @override
  String get homeStudentDefaultName => 'Học sinh';

  @override
  String homeStudentMonthlySummaryTitleWithMonth(String monthLabel) {
    return 'Tổng quan tháng $monthLabel';
  }

  @override
  String get homeStudentMonthlyIncome => 'Tổng thu';

  @override
  String get homeStudentMonthlyExpense => 'Tổng chi';

  @override
  String get homeStudentRemainingBudget => 'Số dư còn lại';

  @override
  String get homeStudentRecentTransactions => 'Giao dịch gần đây';

  @override
  String get homeStudentViewAll => 'Xem tất cả';

  @override
  String get homeStudentLoadError => 'Không thể tải màn hình chính. Vui lòng thử lại.';

  @override
  String get homeStudentAddTransaction => 'Thêm giao dịch';

  @override
  String get homeStudentSetMonthlyLimit => 'Hạn mức tháng';

  @override
  String get homeStudentMonthlyLimitNotSet => 'Hãy thiết lập hạn mức tháng';

  @override
  String get setMoneyLimitTitle => 'Thiết lập hạn mức tháng';

  @override
  String get setMoneyLimitDescription => 'Hạn mức này giúp bạn kiểm soát chi tiêu tốt hơn mỗi tháng.';

  @override
  String get setMoneyLimitSkipAction => 'Bỏ qua';

  @override
  String get setMoneyLimitUnauthenticated => 'Vui lòng đăng nhập lại để thiết lập hạn mức tháng.';

  @override
  String get setMoneyLimitSaveFailed => 'Không thể lưu hạn mức tháng. Vui lòng thử lại.';

  @override
  String setMoneyLimitQuickAmount(int millionCount) {
    return '+$millionCount.000.000đ';
  }

  @override
  String get statisticTitle => 'Thống kê chi tiêu';

  @override
  String get statisticByWeek => 'Theo tuần';

  @override
  String get statisticByMonth => 'Theo tháng';

  @override
  String get statisticWeekNoun => 'tuần';

  @override
  String get statisticMonthNoun => 'tháng';

  @override
  String get statisticThisWeek => 'Tuần này';

  @override
  String get statisticLastWeek => 'Tuần trước';

  @override
  String get statisticThisMonth => 'Tháng này';

  @override
  String get statisticLastMonth => 'Tháng trước';

  @override
  String get statisticSmartInsightFallback => 'Chưa có biến động chi tiêu nổi bật trong kỳ này.';

  @override
  String statisticSmartInsightMessage(String periodLabel, String percent, String categoryLabel) {
    return '$periodLabel này bạn chi cho $categoryLabel nhiều hơn $percent% so với $periodLabel trước. Đây là danh mục tăng mạnh nhất.';
  }

  @override
  String get statisticSpendingLimitLabel => 'Hạn mức chi tiêu';

  @override
  String get statisticSpentLabel => 'Đã chi';

  @override
  String get statisticRemainingLabel => 'Còn lại';

  @override
  String get statisticBudgetOnTrack => 'Đang trong kế hoạch';

  @override
  String get statisticBudgetWarning => 'Cần chú ý';

  @override
  String get statisticBudgetExceeded => 'Vượt hạn mức';

  @override
  String get statisticBudgetNoLimitTitle => 'Thiết lập hạn mức tháng';

  @override
  String get statisticBudgetNoLimitDescription => 'Thêm hạn mức tháng để so sánh ngân sách với chi tiêu trong kỳ hiện tại.';

  @override
  String statisticSavedComparedToPrevious(String percent, String periodLabel) {
    return 'Tiết kiệm $percent% so với $periodLabel trước';
  }

  @override
  String statisticSpentComparedToPrevious(String percent, String periodLabel) {
    return 'Chi nhiều hơn $percent% so với $periodLabel trước';
  }

  @override
  String statisticNoPreviousData(String periodLabel) {
    return 'Chưa có dữ liệu $periodLabel trước';
  }

  @override
  String get statisticSpendingTrendTitle => 'Xu hướng chi tiêu';

  @override
  String statisticCurrentPeriodTotal(String periodLabel) {
    return 'Tổng chi $periodLabel này';
  }

  @override
  String statisticComparedToPrevious(String periodLabel) {
    return 'So với $periodLabel trước';
  }

  @override
  String get statisticHigher => 'Cao hơn';

  @override
  String get statisticLower => 'Thấp hơn';

  @override
  String get statisticStable => 'Ổn định';

  @override
  String get statisticTopCategoriesTitle => 'Chi tiêu nhiều nhất';

  @override
  String get statisticStrongestIncrease => 'Tăng mạnh nhất';

  @override
  String get statisticStrongestDecrease => 'Giảm nhiều nhất';

  @override
  String get statisticNoCategoryChange => 'Chưa có biến động danh mục';

  @override
  String get statisticSpendingAllocationTitle => 'Phân bổ chi tiêu';

  @override
  String get statisticTotalSpentShort => 'Tổng chi';

  @override
  String statisticTransactionCount(int count) {
    return '$count giao dịch';
  }

  @override
  String get statisticTrendIncrease => 'Tăng mạnh nhất';

  @override
  String get statisticTrendDecrease => 'Giảm';

  @override
  String get statisticTrendStable => 'Ổn định';

  @override
  String get statisticNoDataTitle => 'Chưa có dữ liệu chi tiêu';

  @override
  String get statisticNoDataDescription => 'Hãy thêm giao dịch để xem xu hướng chi tiêu và phân tích danh mục.';

  @override
  String get statisticSelectPeriodTitle => 'Chọn mốc thời gian';
}

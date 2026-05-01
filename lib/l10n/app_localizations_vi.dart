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
  String get validationEmptyFields =>
      'Vui lòng điền đủ thông tin (Tên, Email, Mật khẩu)';

  @override
  String registerFailed(String error) {
    return 'Đăng ký thất bại: $error';
  }

  @override
  String get navChildHome => 'Trang chủ';

  @override
  String get navChildTransactions => 'Giao dịch';

  @override
  String get navChildStatistic => 'Thống kê';

  @override
  String get navChildSettings => 'Cài đặt';

  @override
  String get homeParFamilyMembersLabel => 'Thành viên gia đình';

  @override
  String get homeParNoFamilyTitle => 'Chưa có thành viên gia đình';

  @override
  String get homeParNoFamilySubtitle =>
      'Tạo gia đình để bắt đầu theo dõi chi tiêu của con';

  @override
  String get homeParCreateFamilyBtn => 'Tạo gia đình';

  @override
  String get homeParInviteTitle => 'Thêm thành viên mới';

  @override
  String get homeParInviteCodeLabel => 'Mã liên kết';

  @override
  String get homeParCopyCode => 'Sao chép mã';

  @override
  String get homeParCodeCopied => 'Đã sao chép!';

  @override
  String get homeParManageMembers => 'Quản lý';

  @override
  String get homeParSpendingOverview => 'Chi tiêu tháng này';

  @override
  String get homeParMonthlyExpense => 'Chi tiêu';

  @override
  String get homeParMonthlyIncome => 'Thu nhập';

  @override
  String get homeParTransactionTagNew => 'Mới';

  @override
  String get homeParTransactionTagEdited => 'Đã sửa';

  @override
  String get homeParLoadingMemberData => 'Đang tải dữ liệu...';

  @override
  String get homeParAddMember => 'Thêm';

  @override
  String get homeParRecentTransactionsLabel => 'Giao dịch gần đây';

  @override
  String get homeParSeeAll => 'Xem tất cả';

  @override
  String get homeParAlertsLabel => 'Cảnh báo';

  @override
  String get homeParAlertWeeklyLimitTitle => 'Sắp chạm giới hạn tuần';

  @override
  String get homeParAlertWeeklyLimitBody =>
      'Kiểm tra giới hạn chi tiêu cho các thành viên trong gia đình.';

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
  String get helpContactSupportDesc =>
      'Nếu bạn không tìm thấy câu trả lời, hãy liên hệ với đội ngũ hỗ trợ của chúng tôi 24/7.';

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
  String get actionCancel => 'Hủy';

  @override
  String get actionConfirm => 'Xác nhận';

  @override
  String get validationInvalidAmount => 'Số tiền không hợp lệ';

  @override
  String get msgUpdateSuccess => 'Cập nhật thành công';

  @override
  String get addTransactionFailed =>
      'Không thể thêm giao dịch. Vui lòng thử lại.';

  @override
  String get updateTransactionFailed =>
      'Không thể cập nhật giao dịch. Vui lòng thử lại.';

  @override
  String get updateTransactionMissingError =>
      'Không tìm thấy giao dịch để cập nhật.';

  @override
  String get transactionLoadError => 'Không thể tải giao dịch.';

  @override
  String get transactionCategoryLoadError =>
      'Không thể tải danh mục. Vui lòng thử lại.';

  @override
  String get transactionUserNotAuthenticated =>
      'Người dùng chưa được xác thực.';

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
  String get addTransactionNoteHint =>
      'Nhập ghi chú, AI sẽ tự động phân loại...';

  @override
  String get updateTransactionTitle => 'Chỉnh sửa giao dịch';

  @override
  String get updateTransactionAction => 'Cập nhật giao dịch';

  @override
  String get updateTransactionNoteHint => 'Thêm ghi chú...';

  @override
  String get transactionDetailTitle => 'Chi tiết giao dịch';

  @override
  String get transactionDetailNoData => 'Không có dữ liệu giao dịch.';

  @override
  String get transactionDetailTimeLabel => 'THỜI GIAN';

  @override
  String get transactionDetailNoteLabel => 'GHI CHÚ';

  @override
  String get transactionEditAction => 'Chỉnh sửa giao dịch';

  @override
  String get transactionEvidenceSectionTitle => 'Ảnh minh chứng';

  @override
  String get transactionEvidenceAddOptionalLabel =>
      'Thêm ảnh minh chứng (optional)';

  @override
  String get transactionEvidenceOptionalLabel =>
      'Tùy chọn. Thêm 1 ảnh minh chứng cho giao dịch này.';

  @override
  String get transactionEvidenceUploadAction => 'Tải ảnh';

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
  String get transactionEvidenceLegacyUnavailable =>
      'Ảnh minh chứng này được lưu theo luồng lưu trữ cũ và hiện không còn xem được tại đây.';

  @override
  String get transactionEvidenceUnsupportedFormat =>
      'Chỉ hỗ trợ ảnh JPG và PNG.';

  @override
  String get transactionEvidenceUploadTimeout =>
      'Tải ảnh lên quá lâu. Vui lòng thử lại.';

  @override
  String get transactionEvidencePermissionDenied =>
      'Không thể lưu ảnh minh chứng. Hãy kiểm tra Firestore rules cho evidence_image Cloudinary.';

  @override
  String get transactionPermissionDenied =>
      'Rules hiện tại đang từ chối ghi transaction. Hãy kiểm tra lại schema Firestore và rules.';

  @override
  String get transactionScanAction => 'Quét hóa đơn';

  @override
  String get transactionRescanAction => 'Quét lại';

  @override
  String get transactionScanHint =>
      'Chụp hoặc chọn một ảnh hóa đơn để tự điền số tiền, ngày, danh mục và ghi chú.';

  @override
  String get transactionScanExtracting => 'Đang đọc chữ từ ảnh hóa đơn...';

  @override
  String get transactionScanAnalyzing =>
      'Đang phân tích danh mục và tạo mô tả...';

  @override
  String get transactionScanSuccess =>
      'Đã tự điền xong. Hãy kiểm tra lại các trường trước khi lưu.';

  @override
  String get transactionScanPartial =>
      'Đã điền một phần từ OCR. Hãy kiểm tra lại danh mục và ghi chú nếu cần.';

  @override
  String get transactionScanFailed =>
      'Không thể phân tích hóa đơn này. Bạn có thể thử lại hoặc nhập tay giao dịch.';

  @override
  String get transactionScanNoTextFound =>
      'Không tìm thấy nội dung chữ có thể đọc được trên ảnh hóa đơn này.';

  @override
  String get transactionScanNoSuggestion =>
      'Không tạo được gợi ý tự điền phù hợp. Vui lòng kiểm tra biểu mẫu thủ công.';

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
  String get profileEditEmailWarning =>
      'Email không thể thay đổi để bảo mật tài khoản.';

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
  String get chooseAiModelTitle => 'Chọn AI model';

  @override
  String get chooseAiModelDescription =>
      'Chuẩn bị khu vực AI cho các tích hợp sau này. Gemini hiện chỉ là mock setup, còn model Ollama local sẽ ở trạng thái sắp có.';

  @override
  String get aiModelGeminiName => 'Gemini';

  @override
  String get aiModelGemmaName => 'gemma:2b';

  @override
  String get aiModelApiKeyHint => 'Nhập API key';

  @override
  String get aiModelAddApiKey => 'Thêm API Key';

  @override
  String get aiModelRemoveApiKey => 'Gỡ API Key';

  @override
  String get aiModelApiKeySessionNote =>
      'API key được lưu an toàn trong bộ nhớ thiết bị.';

  @override
  String get aiModelPromptHint => 'Enter a prompt to test Gemini...';

  @override
  String get aiModelSendPrompt => 'Send Prompt';

  @override
  String get aiModelResponseTitle => 'Gemini response';

  @override
  String get aiModelApiKeyRequired => 'Please enter an API key first.';

  @override
  String get aiModelPromptRequired => 'Please enter a prompt before sending.';

  @override
  String get aiModelInvalidApiKey =>
      'The Gemini API key is invalid or does not have access.';

  @override
  String get aiModelRequestTimeout =>
      'The Gemini request timed out. Please try again.';

  @override
  String get aiModelEmptyResponse => 'Gemini returned an empty response.';

  @override
  String get aiModelRequestFailed =>
      'Unable to get a Gemini response right now.';

  @override
  String get aiModelLocalSectionTitle => 'Model local';

  @override
  String get aiModelDownload => 'Download';

  @override
  String get aiModelGemmaDownloadConfirmMessage =>
      'Dung lượng file: ~1.35 GB. Hãy đảm bảo bạn có đủ bộ nhớ và kết nối ổn định trước khi tải xuống.';

  @override
  String get aiModelGemmaDescription =>
      'Source provenance is pinned to the official Google Gemma docs and the google/gemma-2b-it distribution channel. The app download URL will be managed separately later.';

  @override
  String get aiModelComingSoon => 'Sắp có';

  @override
  String get aiModelAnalyzeTransaction => 'Phân tích giao dịch';

  @override
  String get aiModelAnalyzingTransaction => 'Đang phân tích...';

  @override
  String get aiModelSelectModelLabel => 'Chọn model';

  @override
  String get aiModelSelectModelConfirmMessage =>
      'Model nay se duoc dung cho cac yeu cau Gemini tiep theo tren thiet bi nay.';

  @override
  String get aiModelUseThisModel => 'Dung model nay';

  @override
  String get aiModelSavingModelSelection => 'Dang luu model da chon...';

  @override
  String get appBarBrandTitle => 'SmartSpending';

  @override
  String get appBarNotificationsTooltip => 'Thông báo';

  @override
  String get navParentHome => 'Trang chủ';

  @override
  String get navParentStatistic => 'Thống kê';

  @override
  String get navParentSettings => 'Cài đặt';

  @override
  String get parentStatisticTitle => 'Thống kê';

  @override
  String get parentStatisticWeek => 'Tuần';

  @override
  String get parentStatisticMonth => 'Tháng';

  @override
  String get parentStatisticBudgetTitle => 'Ngân sách tuần';

  @override
  String get parentStatisticSpentLabel => 'Đã chi';

  @override
  String get parentStatisticLeftLabel => 'Còn lại';

  @override
  String get parentStatisticTrendTitle => 'Xu hướng chi tiêu';

  @override
  String get parentStatisticTopCategoriesTitle => 'Danh mục hàng đầu';

  @override
  String get parentStatisticNoData => 'Chưa có dữ liệu';

  @override
  String get settingParTitle => 'Cài đặt';

  @override
  String get settingParEditProfile => 'Chỉnh sửa hồ sơ';

  @override
  String get settingParFamilyTitle => 'Quản lý gia đình';

  @override
  String get settingParManageFamilyLabel => 'Quản lý thành viên gia đình';

  @override
  String get settingParChildAccountsLabel => 'Tài khoản con';

  @override
  String get settingParChildAccountsSubtitle => 'Thêm hoặc xóa tài khoản';

  @override
  String get settingParSpendingLimitLabel => 'Hạn mức chi tiêu';

  @override
  String get settingParSpendingLimitSubtitle => 'Thiết lập giới hạn tuần/tháng';

  @override
  String get settingParNotificationsTitle => 'Thông báo';

  @override
  String get settingParPushLabel => 'Thông báo tức thì';

  @override
  String get settingParPushSubtitle => 'Khi con thực hiện giao dịch';

  @override
  String get settingParEmailReportLabel => 'Báo cáo tuần qua Email';

  @override
  String get settingParAccountTitle => 'Tài khoản';

  @override
  String get settingParChangePasswordLabel => 'Đổi mật khẩu';

  @override
  String get settingParHelpLabel => 'Trợ giúp & Phản hồi';

  @override
  String get settingParLogoutLabel => 'Đăng xuất';

  @override
  String get settingParVersion => 'Phiên bản 1.0.2';

  @override
  String get settingStuTitle => 'Cài đặt';

  @override
  String get settingStuSectionGeneral => 'Tổng quát';

  @override
  String get settingStuSectionAccount => 'Tài khoản';

  @override
  String get settingStuBudgetLabel => 'Thiết lập ngân sách';

  @override
  String get settingStuFamilyCodeLabel => 'Mã liên kết gia đình';

  @override
  String get settingSignOutConfirm => 'Bạn có chắc chắn muốn đăng xuất không?';

  @override
  String get settingSignOutFailed => 'Đăng xuất thất bại';

  @override
  String get aiModelApiKeyLabel => 'API Key';

  @override
  String get aiModelGeminiSectionTitle => 'Gemini Google API';

  @override
  String get aiModelBetaLabel => 'Beta';

  @override
  String get aiModelDownloadingNote => 'Không đóng ứng dụng';

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
  String get pinCreateDescription =>
      'Tạo mã PIN 6 chữ số để bảo vệ tài khoản của bạn.';

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
  String get homeStudentLoadError =>
      'Không thể tải màn hình chính. Vui lòng thử lại.';

  @override
  String get homeStudentAddTransaction => 'Thêm giao dịch';

  @override
  String get homeStudentSetMonthlyLimit => 'Hạn mức tháng';

  @override
  String get homeStudentMonthlyLimitNotSet => 'Hãy thiết lập hạn mức tháng';

  @override
  String get setMoneyLimitTitle => 'Thiết lập hạn mức tháng';

  @override
  String get setMoneyLimitDescription =>
      'Hạn mức này giúp bạn kiểm soát chi tiêu tốt hơn mỗi tháng.';

  @override
  String get setMoneyLimitSkipAction => 'Bỏ qua';

  @override
  String get setMoneyLimitUnauthenticated =>
      'Vui lòng đăng nhập lại để thiết lập hạn mức tháng.';

  @override
  String get setMoneyLimitSaveFailed =>
      'Không thể lưu hạn mức tháng. Vui lòng thử lại.';

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
  String get statisticSmartInsightFallback =>
      'Chưa có biến động chi tiêu nổi bật trong kỳ này.';

  @override
  String statisticSmartInsightMessage(
    String periodLabel,
    String percent,
    String categoryLabel,
  ) {
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
  String get statisticBudgetNoLimitDescription =>
      'Thêm hạn mức tháng để so sánh ngân sách với chi tiêu trong kỳ hiện tại.';

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
  String get statisticNoDataDescription =>
      'Hãy thêm giao dịch để xem xu hướng chi tiêu và phân tích danh mục.';

  @override
  String get statisticSelectPeriodTitle => 'Chọn mốc thời gian';

  @override
  String get scanBillAiError =>
      'Không thể phân tích hóa đơn. Vui lòng thử lại hoặc nhập tay.';

  @override
  String get customCategoryAdd => 'Thêm danh mục';

  @override
  String get customCategoryLabelHint => 'Tên danh mục';

  @override
  String get customCategoryTypeExpense => 'Chi tiêu';

  @override
  String get customCategoryTypeIncome => 'Thu nhập';

  @override
  String get customCategoryLimitReached =>
      'Bạn chỉ có thể tạo tối đa 5 danh mục tùy chỉnh';

  @override
  String get customCategoryCreated => 'Đã tạo danh mục';

  @override
  String get customCategoryDeleted => 'Đã xóa danh mục';

  @override
  String get customCategoryConfirmDelete => 'Xóa danh mục này?';

  @override
  String get customCategoryConfirmDeleteBody =>
      'Các giao dịch dùng danh mục này vẫn giữ nhãn cũ.';

  @override
  String get customCategoryCancel => 'Hủy';

  @override
  String get customCategoryConfirm => 'Thêm';
}

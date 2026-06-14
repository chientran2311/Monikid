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
  String get languageVietnameseSubtitle =>
      'Hiển thị toàn bộ ứng dụng bằng tiếng Việt';

  @override
  String get languageEnglishSubtitle => 'Dùng tiếng Anh cho toàn bộ ứng dụng';

  @override
  String get close => 'Đóng';

  @override
  String get actionSkip => 'Bỏ qua';

  @override
  String get onboardingLanguageTitleLeading => 'Chọn';

  @override
  String get onboardingLanguageTitleHighlight => 'ngôn ngữ';

  @override
  String get onboardingLanguageDescription =>
      'Vui lòng chọn ngôn ngữ bạn muốn sử dụng trong ứng dụng.';

  @override
  String get onboardingContinueAction => 'Tiếp tục';

  @override
  String get onboardingLanguageSubtitle =>
      'Bạn có thể đổi lại sau trong phần cài đặt.';

  @override
  String get onboardingLanguageCardTitle => 'Ngôn ngữ hiển thị';

  @override
  String get onboardingLanguageCardDesc =>
      'Monikid sẽ dùng ngôn ngữ này cho bài học và thông báo.';

  @override
  String get onboardingLanguageViDesc => 'Phù hợp cho người dùng tại Việt Nam';

  @override
  String get onboardingLanguageEnDesc =>
      'Dành cho học sinh và phụ huynh song ngữ';

  @override
  String get onboardingLanguageHint =>
      'Bước tiếp theo: Monikid sẽ xin quyền thông báo để nhắc lịch học và cập nhật quan trọng.';

  @override
  String get onboardingSkipLater => 'Để sau';

  @override
  String get onboardingNotificationTitle =>
      'Bật thông báo để theo dõi chi tiêu kịp thời';

  @override
  String get onboardingNotificationSubtitle =>
      'Monikid sẽ gửi cập nhật khi có giao dịch mới, biến động số dư và hoạt động chi tiêu quan trọng để phụ huynh luôn nắm được tình hình của con.';

  @override
  String get onboardingNotificationBenefitsTitle => 'Lợi ích khi bật thông báo';

  @override
  String get onboardingNotificationBenefitsDesc =>
      'Chỉ những cập nhật hữu ích để phụ huynh kiểm soát chi tiêu dễ hơn mỗi ngày.';

  @override
  String get onboardingNotificationEnableBtn => 'Bật thông báo ngay';

  @override
  String get onboardingNotificationBenefit1Title =>
      'Biết ngay khi có giao dịch mới';

  @override
  String get onboardingNotificationBenefit1Desc =>
      'Theo dõi khoản chi của con gần như ngay lập tức sau khi phát sinh.';

  @override
  String get onboardingNotificationBenefit2Title =>
      'Nhận cảnh báo khi số dư thay đổi';

  @override
  String get onboardingNotificationBenefit2Desc =>
      'Giúp kiểm soát ngân sách và phát hiện các biến động đáng chú ý.';

  @override
  String get onboardingNotificationBenefit3Title =>
      'Phụ huynh luôn nắm được tình hình';

  @override
  String get onboardingNotificationBenefit3Desc =>
      'Đồng hành cùng con trong việc học cách quản lý tiền bạc hợp lý hơn.';

  @override
  String get onboardingNotificationSheetTitle =>
      '\"Monikid\" muốn gửi thông báo cho bạn';

  @override
  String get onboardingNotificationSheetDesc =>
      'Thông báo có thể bao gồm giao dịch mới, biến động số dư và các cập nhật quan trọng về chi tiêu.';

  @override
  String get onboardingNotificationSheetRowTitle =>
      'Theo dõi giao dịch đúng lúc';

  @override
  String get onboardingNotificationSheetRowDesc =>
      'Giúp phụ huynh nắm được các khoản chi tiêu của con nhanh hơn.';

  @override
  String get onboardingNotificationSheetDeny => 'Không cho phép';

  @override
  String get onboardingNotificationSheetAllow => 'Cho phép';

  @override
  String get onboardingNotificationMiniAmount => '-120.000đ';

  @override
  String get onboardingNotificationMiniMeta => 'Mua sách • 2 phút trước';

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
  String get homeParNoFamilyTitle => 'Bắt đầu hành trình';

  @override
  String get homeParNoFamilySubtitle =>
      'Chào mừng bạn đến với MoniKid. Hãy thêm thành viên đầu tiên để bắt đầu quản lý chi tiêu gia đình.';

  @override
  String get homeParCreateFamilyBtn => 'Tạo gia đình';

  @override
  String get homeParNoFamilyHintSafe => 'Quản lý an toàn cho con';

  @override
  String get homeParNoFamilyHintChart => 'Theo dõi biểu đồ chi tiêu';

  @override
  String get homeParErrorTitle => 'Đã có lỗi xảy ra';

  @override
  String get homeParErrorDesc =>
      'Không thể tải dữ liệu trang chủ. Vui lòng thử lại.';

  @override
  String get homeParInviteTitle => 'Mời thành viên';

  @override
  String get homeParInviteDesc =>
      'Chia sẻ mã này với con hoặc người thân để họ tham gia vào gia đình MoniKid.';

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
  String homeParTopCategoryAlertTitle(String category) {
    return 'Chi nhiều nhất ở $category';
  }

  @override
  String get homeParTopCategoryAlertBody => 'Nhấn để xem chi tiết giao dịch';

  @override
  String get homeParThisMonth => 'Tháng này';

  @override
  String get homeParViewDetail => 'Xem chi tiết';

  @override
  String homeParSpentPercent(String percent) {
    return 'Đã chi $percent% thu nhập';
  }

  @override
  String get homeParTotalMonthlySpending => 'Tổng chi tiêu tháng này';

  @override
  String get homeParLimitLabel => 'Hạn mức:';

  @override
  String homeParUsedPercent(String percent) {
    return 'Đã dùng $percent%';
  }

  @override
  String get homeParLowBalanceTitle => 'Số dư thấp';

  @override
  String homeParLowBalanceDesc(String name) {
    return 'Tài khoản của $name đang dưới 100.000đ.';
  }

  @override
  String get homeParTransactionSuccess => 'Thành công';

  @override
  String get noTransactionsYet => 'Chưa có giao dịch nào.';

  @override
  String errorGeneric(String error) {
    return 'Lỗi: $error';
  }

  @override
  String get settingFAQ => 'Câu hỏi thường gặp';

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
  String get actionDone => 'Xong';

  @override
  String get actionSelect => 'Chọn';

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
  String get transactionAmountInputLabel => 'Số tiền nhập';

  @override
  String get transactionDetailSectionLabel => 'Chi tiết';

  @override
  String get transactionDateRowLabel => 'Ngày giao dịch';

  @override
  String get transactionExpenseTab => 'Chi tiêu';

  @override
  String get transactionIncomeTab => 'Thu nhập';

  @override
  String get transactionCategoryViewAll => 'Xem tất cả';

  @override
  String get transactionEvidenceRowLabel => 'Ảnh hóa đơn';

  @override
  String get transactionCategoryLabel => 'Danh mục';

  @override
  String get transactionDateLabel => 'Ngày';

  @override
  String get transactionHistorySelectDateTitle => 'Chọn ngày';

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
  String get transactionDetailCreatedAtLabel => 'TẠO LÚC';

  @override
  String get transactionDetailNoteLabel => 'GHI CHÚ';

  @override
  String get transactionDetailEvidenceLabel => 'ẢNH MINH CHỨNG';

  @override
  String get transactionEditAction => 'Chỉnh sửa giao dịch';

  @override
  String get transactionDeleteAction => 'Xóa giao dịch';

  @override
  String get transactionEvidenceSectionTitle => 'Ảnh minh chứng';

  @override
  String get transactionEvidenceAddOptionalLabel =>
      'Thêm ảnh minh chứng (tùy chọn)';

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
  String get profileEditTitle => 'Hồ sơ cá nhân';

  @override
  String get profileEditAvatarLabel => 'Thay đổi ảnh đại diện';

  @override
  String get profileEditAvatarDesc => 'Chụp ảnh mới hoặc chọn từ thư viện';

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
  String get profileEditDobPickerTitle => 'Chọn ngày sinh';

  @override
  String get profileEditDobPickerDone => 'Xong';

  @override
  String get actionSaveChanges => 'Lưu thay đổi';

  @override
  String get profileEditSaveSuccess => 'Cập nhật hồ sơ thành công';

  @override
  String get profileEditErrorNameRequired => 'Họ tên là bắt buộc';

  @override
  String get profileEditErrorNameTooShort => 'Họ tên phải có ít nhất 2 ký tự';

  @override
  String get profileEditErrorInvalidPhone =>
      'Số điện thoại không hợp lệ (VD: 0912345678)';

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
  String get scanReceiptCameraSubtitle => 'Mở camera để chụp trực tiếp';

  @override
  String get scanReceiptGallerySubtitle => 'Chọn từ thư viện ảnh thiết bị';

  @override
  String get chooseAiModelTitle => 'Chọn AI model';

  @override
  String get chooseAiModelDescription =>
      'Chuẩn bị khu vực AI cho các tích hợp sau này. Gemini hiện chỉ là mock setup, còn model Ollama local sẽ ở trạng thái sắp có.';

  @override
  String get aiModelGeminiName => 'Gemini';

  @override
  String get aiModelUseApiKeyModel => 'Dùng API key model';

  @override
  String get aiModelUseLocalModel => 'Dùng model cục bộ';

  @override
  String get aiModelApiKeyAddSuccess => 'API key hợp lệ và đã được lưu';

  @override
  String get aiModelApiKeyInvalid =>
      'API key không hợp lệ. Vui lòng kiểm tra lại.';

  @override
  String get aiModelApiKeyTestFailed =>
      'Không thể xác minh API key. Kiểm tra kết nối internet.';

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
  String get aiModelPromptHint => 'Nhập câu hỏi để kiểm tra Gemini...';

  @override
  String get aiModelSendPrompt => 'Gửi câu hỏi';

  @override
  String get aiModelResponseTitle => 'Phản hồi từ Gemini';

  @override
  String get aiModelApiKeyRequired => 'Vui lòng nhập API key trước.';

  @override
  String get aiModelPromptRequired => 'Vui lòng nhập câu hỏi trước khi gửi.';

  @override
  String get aiModelInvalidApiKey =>
      'API key Gemini không hợp lệ hoặc không có quyền truy cập.';

  @override
  String get aiModelRequestTimeout =>
      'Yêu cầu Gemini đã quá thời gian. Vui lòng thử lại.';

  @override
  String get aiModelEmptyResponse => 'Gemini trả về phản hồi rỗng.';

  @override
  String get aiModelRequestFailed =>
      'Không thể nhận phản hồi từ Gemini lúc này.';

  @override
  String get aiModelLocalSectionTitle => 'Model local';

  @override
  String get aiModelDownload => 'Tải xuống';

  @override
  String get aiModelGemmaDownloadConfirmMessage =>
      'Dung lượng file: ~1.35 GB. Hãy đảm bảo bạn có đủ bộ nhớ và kết nối ổn định trước khi tải xuống.';

  @override
  String get aiModelDeleteModel => 'Xóa model';

  @override
  String get aiModelGemmaDeleteConfirmMessage =>
      'Xóa model AI khỏi thiết bị? Bạn sẽ cần tải lại để sử dụng tiếp.';

  @override
  String get aiModelGemmaDescription =>
      'Nguồn gốc được ghim theo tài liệu chính thức của Google Gemma và kênh phân phối google/gemma-2b-it. URL tải xuống trong ứng dụng sẽ được quản lý riêng sau.';

  @override
  String get aiModelComingSoon => 'Sắp có';

  @override
  String get aiModelAnalyzeTransaction => 'Phân tích giao dịch';

  @override
  String get aiModelAnalyzingTransaction => 'Đang phân tích...';

  @override
  String get aiModelSelectModelLabel => 'Chọn model';

  @override
  String get aiModelHeroEyebrow => 'AI model setup';

  @override
  String get aiModelHeroTitle => 'Chọn mô hình AI để phân tích chi tiêu';

  @override
  String get aiModelHeroSubtitle =>
      'Kết nối Gemini bằng API hoặc tải local model để xử lý trực tiếp trên thiết bị.';

  @override
  String get aiModelGeminiCardDescription =>
      'Dùng AI cloud để phân loại giao dịch, tóm tắt chi tiêu và gợi ý cảnh báo nhanh.';

  @override
  String get aiModelRecommendedBadge => 'Khuyên dùng';

  @override
  String get aiModelGemmaCardDescription =>
      'Xử lý trên thiết bị để tăng riêng tư. Phù hợp khi muốn dữ liệu không rời máy.';

  @override
  String get aiModelPrivateBadge => 'Riêng tư';

  @override
  String get aiModelFooterNote =>
      'Bạn có thể đổi model bất kỳ lúc nào trong phần cài đặt AI.';

  @override
  String get aiModelEnableGemini => 'Bật Gemini';

  @override
  String get aiModelSelectModelConfirmMessage =>
      'Model này sẽ được dùng cho các yêu cầu Gemini tiếp theo trên thiết bị này.';

  @override
  String get aiModelUseThisModel => 'Dùng model này';

  @override
  String get aiModelSavingModelSelection => 'Đang lưu model đã chọn...';

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
  String get parentStatisticYear => 'Năm';

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
  String get parentStatisticTotalSpentTitle => 'Tổng đã chi';

  @override
  String get parentStatisticVsLastMonth => 'so với tháng trước';

  @override
  String parentStatisticSpendingUp(String percent) {
    return '+$percent%';
  }

  @override
  String parentStatisticSpendingDown(String percent) {
    return '-$percent%';
  }

  @override
  String get parentStatisticSpendingStable => 'Ổn định';

  @override
  String get parentStatisticLoading => 'Đang tải thống kê chi tiêu...';

  @override
  String get parentStatisticLoadError => 'Không thể tải thống kê chi tiêu.';

  @override
  String get parentStatisticRetry => 'Thử lại';

  @override
  String get parentStatisticSelectChild =>
      'Chọn một trẻ để xem thống kê chi tiêu.';

  @override
  String parentStatisticTransactionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giao dịch',
      zero: 'Chưa có giao dịch',
    );
    return '$_temp0';
  }

  @override
  String get parentStatisticTotalExpenseLabel => 'TỔNG CHI';

  @override
  String get parentStatisticTxCountLabel => 'SỐ GD';

  @override
  String get parentStatisticPrevPeriodLabel => 'THÁNG TRƯỚC';

  @override
  String get parentStatisticTrendGood => 'Tốt';

  @override
  String get parentStatisticTrendBad => 'Kém';

  @override
  String get parentStatisticEditedBadge => 'Đã sửa';

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
  String get settingParAppearanceTitle => 'Giao diện';

  @override
  String get settingParThemeLabel => 'Giao diện sáng/tối';

  @override
  String get settingThemeDarkLabel => 'Chế độ tối';

  @override
  String get settingThemeDarkSubtitle => 'Bật giao diện nền tối';

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
  String get settingStuEyebrow => 'Tài khoản & ứng dụng';

  @override
  String get settingStuSubtitle =>
      'Quản lý ngôn ngữ, thông báo và kết nối gia đình của bạn.';

  @override
  String get settingStuNotificationsSubtitle => 'Nhận cảnh báo giao dịch mới';

  @override
  String get settingStuAiModelSubtitle => 'Trợ lý phân tích thông minh';

  @override
  String get settingStuFamilyCodeSubtitle => 'Kết nối với tài khoản phụ huynh';

  @override
  String get settingStuProfileEditLabel => 'Chỉnh sửa hồ sơ';

  @override
  String get settingStuProfileEditSubtitle => 'Cập nhật thông tin cá nhân';

  @override
  String get settingStuFaqSubtitle => 'Giải đáp thắc mắc thường gặp';

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
  String get loginWelcomeTitle => 'Chào mừng quay lại';

  @override
  String get loginWelcomeSubtitle => 'Đăng nhập để tiếp tục.';

  @override
  String get loginTagline => 'Quản lý chi tiêu thông minh';

  @override
  String get loginAccountLabel => 'Tài khoản';

  @override
  String get loginEmailPlaceholder => 'Email / số điện thoại';

  @override
  String get loginPasswordLabel => 'Mật khẩu';

  @override
  String get loginPasswordPlaceholder => 'Nhập mật khẩu';

  @override
  String get loginForgotPassword => 'Quên mật khẩu?';

  @override
  String get loginRegisterButton => 'Đăng ký nếu chưa có tài khoản';

  @override
  String get registerTitle => 'Tạo tài khoản mới';

  @override
  String get registerSubtitle => 'Điền thông tin để bắt đầu với Monikid.';

  @override
  String get registerTagline => 'Bắt đầu hành trình tài chính';

  @override
  String get registerEmailPlaceholder => 'you@example.com';

  @override
  String get registerUsernameLabel => 'Tên người dùng';

  @override
  String get registerUsernamePlaceholder => 'Nhập tên người dùng';

  @override
  String get registerPhoneLabel => 'Số điện thoại';

  @override
  String get registerPhonePlaceholder => 'Nhập số điện thoại';

  @override
  String get registerPasswordPlaceholder => 'Tạo mật khẩu';

  @override
  String get registerConfirmPasswordLabel => 'Nhập lại mật khẩu';

  @override
  String get registerConfirmPasswordPlaceholder => 'Nhập lại mật khẩu';

  @override
  String get registerRoleParent => 'Phụ huynh';

  @override
  String get registerRoleStudent => 'Học sinh';

  @override
  String get registerHaveAccountText => 'Bạn đã có tài khoản?';

  @override
  String get validationPasswordMismatch => 'Mật khẩu xác nhận không khớp.';

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
  String get homeStudentSummaryEyebrow => 'Tổng quan tháng này';

  @override
  String homeStudentSummaryTitle(int month) {
    return 'Chi tiêu tháng $month của con';
  }

  @override
  String homeStudentTodayTransactionsSub(int count) {
    return '$count giao dịch hôm nay';
  }

  @override
  String get homeStudentTopCategoryLabel => 'Chi nhiều nhất';

  @override
  String homeStudentMonthPill(int month) {
    return 'Tháng $month';
  }

  @override
  String homeStudentUsedPercent(int percent) {
    return 'Đã dùng $percent%';
  }

  @override
  String get homeStudentTransactionsLabel => 'Giao dịch';

  @override
  String homeStudentTransactionCountLabel(int count) {
    return '$count giao dịch';
  }

  @override
  String homeStudentRemainingAmount(String amount) {
    return 'Còn $amount';
  }

  @override
  String get homeStudentQuickActionsTitle => 'Thao tác nhanh';

  @override
  String get homeStudentScanBillTitle => 'Scan bill AI';

  @override
  String get homeStudentScanBillSubtitle =>
      'Quét hóa đơn và lưu giao dịch nhanh';

  @override
  String get homeStudentSetLimitSubtitle => 'Kiểm soát chi tiêu theo tháng';

  @override
  String get homeStudentMonthlyIncomeLabel => 'Tổng thu';

  @override
  String get homeStudentUsedLabel => 'Đã dùng';

  @override
  String get setMoneyLimitTitle => 'Thiết lập hạn mức tháng';

  @override
  String get setMoneyLimitFieldLabel => 'Hạn mức';

  @override
  String get setMoneyLimitSubtitle =>
      'Nhập số tiền tối đa con được phép chi trong tháng. Thay đổi sẽ áp dụng ngay cho tháng hiện tại.';

  @override
  String get setMoneyLimitDescription =>
      'Hãy kiểm tra mức chi phù hợp với kế hoạch tháng của con.';

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
  String get statisticByYear => 'Theo năm';

  @override
  String get statisticHeaderEyebrow => 'Theo dõi chi tiêu của con';

  @override
  String get statisticHeaderSubhead =>
      'Tổng hợp giao dịch, cảnh báo vượt hạn mức và các danh mục chi tiêu nổi bật.';

  @override
  String get statisticAlertTitle => 'Cảnh báo chi tiêu';

  @override
  String get statisticAlertPriority => 'Ưu tiên kiểm tra';

  @override
  String get statisticProgressUsageLabel => 'Tiến độ sử dụng';

  @override
  String get statisticBudgetAdjustAnytime =>
      'Phụ huynh có thể điều chỉnh hạn mức bất cứ lúc nào';

  @override
  String get statisticChartSectionTitle => 'Biểu đồ chi tiêu';

  @override
  String get statisticChartComparisonTitle => 'So sánh theo thời gian';

  @override
  String get statisticWeekNoun => 'tuần';

  @override
  String get statisticMonthNoun => 'tháng';

  @override
  String get statisticYearNoun => 'năm';

  @override
  String get statisticLoadError =>
      'Không thể tải dữ liệu thống kê. Vui lòng thử lại.';

  @override
  String get statisticThisWeek => 'Tuần này';

  @override
  String get statisticLastWeek => 'Tuần trước';

  @override
  String get statisticThisMonth => 'Tháng này';

  @override
  String get statisticLastMonth => 'Tháng trước';

  @override
  String get statisticThisYear => 'Năm này';

  @override
  String get statisticLastYear => 'Năm ngoái';

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
  String get statisticTopCategoriesTitle => 'Danh mục chi tiêu nhiều nhất';

  @override
  String get statisticTopIncomeCategoriesTitle =>
      'Danh mục thu nhập nhiều nhất';

  @override
  String get statisticCategoryTransactionListTitle => 'Danh sách giao dịch';

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
  String get scanBillNoAiAvailable =>
      'Chưa có AI nào sẵn sàng. Cài đặt API key hoặc tải model AI về.';

  @override
  String get scanBillAiError =>
      'Không thể phân tích hóa đơn. Vui lòng thử lại hoặc nhập tay.';

  @override
  String get scanBillLoadingTitle => 'Đang xử lý hóa đơn';

  @override
  String get scanBillScanningStatus => 'Đang quét hóa đơn...';

  @override
  String get scanBillAnalyzingStatus => 'AI đang phân tích...';

  @override
  String get joinFamilyTitle => 'Tham gia gia đình';

  @override
  String get joinFamilySubtitle => 'Nhập mã mời 6 chữ số từ phụ huynh của bạn';

  @override
  String get joinFamilyInputHint => 'Nhập mã';

  @override
  String get joinFamilyButton => 'Tham gia';

  @override
  String get joinFamilySuccess => 'Bạn đã tham gia gia đình thành công!';

  @override
  String get joinFamilyErrorInvalidCode =>
      'Mã mời không hợp lệ hoặc đã hết hạn';

  @override
  String get joinFamilyErrorAlreadyMember => 'Bạn đã thuộc về một gia đình';

  @override
  String get joinFamilyErrorUnknown => 'Không thể tham gia. Vui lòng thử lại.';

  @override
  String get joinFamilyEyebrow => 'Kết nối tài khoản';

  @override
  String get joinFamilyHeroTitle => 'Nhập mã gia đình để bắt đầu';

  @override
  String get joinFamilyHeroSubtitle =>
      'Tham gia nhóm gia đình để phụ huynh theo dõi giao dịch và quản lý chi tiêu của con an toàn hơn.';

  @override
  String get joinFamilyMiniCardTitle => 'Không gian gia đình';

  @override
  String get joinFamilyMiniCardDesc => 'Minh bạch giao dịch, dễ theo dõi';

  @override
  String get joinFamilyEnterCodeTitle => 'Nhập mã 6 số';

  @override
  String get joinFamilyEnterCodeSubtitle =>
      'Mã này được phụ huynh hoặc người tạo gia đình gửi cho bạn.';

  @override
  String get joinFamilyCodeOnlyDigits => 'Chỉ chấp nhận mã số gồm 6 chữ số';

  @override
  String get joinFamilyJoinNow => 'Tham gia ngay';

  @override
  String get joinFamilyNoCode => 'Bạn chưa có mã?';

  @override
  String get unlinkFamilyTitle => 'Gia đình của tôi';

  @override
  String get unlinkFamilySubtitle => 'Bạn đang kết nối với một gia đình';

  @override
  String get unlinkFamilyButton => 'Hủy liên kết';

  @override
  String get unlinkFamilyConfirmTitle => 'Rời gia đình?';

  @override
  String get unlinkFamilyConfirmBody =>
      'Bạn sẽ rời khỏi gia đình này. Bạn có thể tham gia lại bằng mã mời.';

  @override
  String get unlinkFamilySuccess => 'Bạn đã rời gia đình.';

  @override
  String get unlinkFamilyErrorFailed =>
      'Không thể rời gia đình. Vui lòng thử lại.';

  @override
  String get familyMembersTitle => 'Thành viên gia đình';

  @override
  String get familyStatusJoined => 'Đang tham gia';

  @override
  String get familyLinkedSuccess => 'Liên kết thành công';

  @override
  String get familyMemberListLabel => 'Danh sách thành viên';

  @override
  String get familyMembersUnit => 'người';

  @override
  String get familyRoleParent => 'Phụ huynh';

  @override
  String get familyRoleChild => 'Con';

  @override
  String get familyRoleOwner => 'Chủ gia đình';

  @override
  String get familyMemberYou => 'Bạn';

  @override
  String get familyMemberActive => 'Đang hoạt động';

  @override
  String get unlinkFamilyButtonFull => 'Hủy liên kết gia đình';

  @override
  String get customCategoryAdd => 'Thêm danh mục';

  @override
  String get customCategoryAddSubtitle =>
      'Danh mục sẽ được thêm vào loại chi tiêu';

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
  String get customCategoryCreateFailed =>
      'Không thể tạo danh mục. Vui lòng thử lại.';

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

  @override
  String get customCategorySelectTitleExpense => 'Chọn danh mục chi tiêu';

  @override
  String get customCategorySelectTitleIncome => 'Chọn danh mục thu nhập';

  @override
  String get customCategorySelectTitle => 'Chọn danh mục';

  @override
  String get customCategoryConfirmSelection => 'Xong';

  @override
  String get customCategoryAddNew => 'Thêm mới';

  @override
  String get customCategoryDelete => 'Xóa';

  @override
  String get customCategoryIconHint => 'Chọn biểu tượng';

  @override
  String get customCategoryDropToDelete => 'Thả vào đây để xóa';

  @override
  String get customCategoryDeleteFailed => 'Không thể xóa danh mục';

  @override
  String get setMoneyLimitManagedByParent => 'Hạn mức do phụ huynh quản lý';

  @override
  String get parentSetLimitTitle => 'Thiết lập hạn mức tháng';

  @override
  String get parentSetLimitDescription =>
      'Hạn mức này giúp con kiểm soát chi tiêu tốt hơn mỗi tháng';

  @override
  String get notifTitle => 'Thông báo';

  @override
  String get notifMarkAllRead => 'Đánh dấu tất cả đã đọc';

  @override
  String get notifEmpty => 'Chưa có thông báo nào';

  @override
  String get notifOverspend80Title => 'Sắp đạt hạn mức';

  @override
  String notifOverspend80Body(Object amount, Object month) {
    return 'Bạn đã chi $amount — 80% hạn mức tháng $month.';
  }

  @override
  String get notifOverspend100Title => 'Đã vượt hạn mức';

  @override
  String notifOverspend100Body(Object amount, Object month) {
    return 'Bạn đã chi $amount — vượt hạn mức tháng $month.';
  }

  @override
  String get notifWeeklyOverspendTitle => 'Chi tiêu tăng cao';

  @override
  String notifWeeklyOverspendBody(Object percent) {
    return 'Tuần này bạn chi nhiều hơn $percent% so với tuần trước.';
  }

  @override
  String notifParentOverspend80Body(Object childName, Object month) {
    return 'Con $childName đã chi 80% hạn mức tháng $month.';
  }

  @override
  String notifParentOverspend100Body(Object childName, Object month) {
    return 'Con $childName đã vượt hạn mức tháng $month.';
  }

  @override
  String notifParentWeeklyOverspendBody(Object childName, Object percent) {
    return 'Con $childName tuần này chi nhiều hơn $percent% so với tuần trước.';
  }

  @override
  String get familyManagementTitle => 'Quản lý gia đình';

  @override
  String get familyManagementEmptyMessage => 'Không tìm thấy gia đình';

  @override
  String get familyManagementErrorMessage =>
      'Có lỗi xảy ra khi tải dữ liệu gia đình';

  @override
  String get familyManagementHostBadge => 'Chủ';

  @override
  String get familyManagementHostSubtitle => 'Chủ';

  @override
  String get familyManagementParentSubtitle => 'Thành viên gia đình';

  @override
  String get familyManagementInviteCodeLabel => 'Mã mời gia đình';

  @override
  String get familyManagementCopyTooltip => 'Sao chép';

  @override
  String get familyManagementCopySuccess => 'Đã sao chép mã mời';

  @override
  String get familyManagementSectionMembers => 'THÀNH VIÊN';

  @override
  String get familyManagementChildrenSection => 'Trẻ em';

  @override
  String get familyManagementParentsSection => 'Phụ huynh';

  @override
  String get familyManagementHostParentLabel => '(Người tạo gia đình)';

  @override
  String get familyManagementNonHostParentLabel => '(Phụ huynh phụ)';

  @override
  String get familyManagementSetLimit => 'Đặt hạn mức';

  @override
  String get familyManagementUnlinkChild => 'Hủy';

  @override
  String get familyManagementUnlinkParent => 'Hủy liên kết';

  @override
  String get familyManagementNoLimit => 'Chưa đặt';

  @override
  String get familyManagementEmptyChildren => 'Chưa có thành viên nào';

  @override
  String get familyManagementUnlinkButton => 'Gỡ liên kết';

  @override
  String get familyManagementSetLimitButton => 'Đặt hạn mức';

  @override
  String get familyManagementRemoveLimitButton => 'Xóa hạn mức';

  @override
  String get familyManagementLimitDialogTitle => 'Đặt hạn mức';

  @override
  String get familyManagementLimitInputHint => '0';

  @override
  String get familyManagementRemoveLimit => 'Xóa hạn mức';

  @override
  String get familyManagementSave => 'Lưu';

  @override
  String get familyManagementCancel => 'Không';

  @override
  String get familyManagementUnlinkConfirmTitle => 'Hủy liên kết?';

  @override
  String familyManagementUnlinkConfirmBody(Object name) {
    return 'Bạn có chắc muốn hủy liên kết $name?';
  }

  @override
  String get familyManagementUnlinkConfirmButton => 'Hủy liên kết';

  @override
  String get familyManagementConfirmUnlinkChildTitle => 'Xác nhận gỡ liên kết';

  @override
  String familyManagementConfirmUnlinkChildMessage(Object childName) {
    return 'Bạn có chắc muốn gỡ liên kết $childName?';
  }

  @override
  String get familyManagementConfirmUnlinkParentTitle => 'Xác nhận gỡ liên kết';

  @override
  String familyManagementConfirmUnlinkParentMessage(Object parentName) {
    return 'Bạn có chắc muốn gỡ liên kết $parentName?';
  }

  @override
  String get familyManagementLimitSetSuccess => 'Đã cập nhật hạn mức';

  @override
  String get familyManagementLimitRemovedSuccess => 'Đã xóa hạn mức';

  @override
  String get familyManagementUnlinkSuccess => 'Đã gỡ liên kết thành công';

  @override
  String get familyManagementUnlinkError => 'Lỗi khi gỡ liên kết';

  @override
  String get familyManagementSetLimitSuccess => 'Đã đặt hạn mức thành công';

  @override
  String get familyManagementSetLimitError => 'Lỗi khi đặt hạn mức';

  @override
  String get familyManagementRemoveLimitSuccess => 'Đã xóa hạn mức thành công';

  @override
  String get familyManagementRemoveLimitError => 'Lỗi khi xóa hạn mức';

  @override
  String get familyManagementBannerTitle => 'Xây dựng tương lai cùng con';

  @override
  String get familyManagementBannerSubtitle =>
      'Dạy trẻ cách quản lý chi tiêu thông minh từ hôm nay.';

  @override
  String get notificationSettingsTitle => 'Thông báo';

  @override
  String get notificationSettingsDailySection => 'THÔNG BÁO HÀNG NGÀY';

  @override
  String get notificationSettingsEnableLabel => 'Bật thông báo';

  @override
  String get notificationSettingsTimeLabel => 'Giờ nhận thông báo';

  @override
  String get notificationSettingsAboutSection => 'VỀ THÔNG BÁO';

  @override
  String get notificationSettingsDescription =>
      'Thông báo sẽ nhắc bạn kiểm tra chi tiêu mỗi ngày vào giờ đã chọn. Điều này giúp bạn duy trì thói quen quản lý tài chính tốt hơn.';

  @override
  String get settingNotificationsLabel => 'Thông báo';

  @override
  String get scheduleNotificationSmartTitle => 'Tiết kiệm 15% hiệu quả hơn';

  @override
  String get scheduleNotificationSmartSubtitle =>
      'Dựa trên thói quen của 500 người dùng khác';

  @override
  String get notificationSettingsEyebrow => 'Theo dõi chi tiêu';

  @override
  String get notificationSettingsHeroTitle =>
      'Bật thông báo để không bỏ lỡ giao dịch của con';

  @override
  String get notificationSettingsHeroSubtitle =>
      'Nhận cảnh báo ngay khi có chi tiêu mới, đúng khung giờ bạn muốn theo dõi để việc quản lý nhẹ nhàng hơn.';

  @override
  String get notificationSettingsEnableHint =>
      'Thông báo khi con thanh toán, chuyển tiền hoặc phát sinh biến động số dư.';

  @override
  String get notificationSettingsScheduleSection => 'Lịch nhận thông báo';

  @override
  String get notificationSettingsScheduleNote => 'Có thể thay đổi';

  @override
  String get notificationSettingsTimeHint =>
      'Ứng dụng sẽ ưu tiên gửi thông báo trong khung giờ này để tránh làm phiền ngoài giờ nghỉ.';

  @override
  String get notificationSettingsInstructionTitle =>
      'Thông báo giúp phụ huynh theo dõi chi tiêu kịp thời';

  @override
  String get notificationSettingsInstructionDesc =>
      'Khi bật tính năng này, bạn sẽ nhận được cảnh báo ngay khi có giao dịch mới hoặc khi số dư của con thay đổi bất thường.';

  @override
  String get notificationSettingsTip1 =>
      'Nhấn Cho phép khi hệ thống hỏi quyền gửi thông báo để hệ thống hoạt động đầy đủ.';

  @override
  String get notificationSettingsTip2 =>
      'Chọn giờ nhận phù hợp để không bị làm phiền vào buổi tối nhưng vẫn nắm được giao dịch quan trọng.';

  @override
  String get notificationSettingsTip3 =>
      'Bạn vẫn sẽ nhận cảnh báo ngay lập tức với các giao dịch cần chú ý như chi tiêu vượt hạn mức hoặc thanh toán bất thường.';

  @override
  String get onboardingWelcomeTitle => 'Tài chính gia đình\ntrong tầm tay';

  @override
  String get onboardingWelcomeSubtitle =>
      'Ứng dụng thông minh kết nối phụ huynh và con cái, xây dựng thói quen chi tiêu từ hôm nay.';

  @override
  String get onboardingWelcomeFeature1Title => 'Quản lý thông minh';

  @override
  String get onboardingWelcomeFeature1Desc =>
      'Kiểm soát thu chi, thiết lập hạn mức và theo dõi ngân sách trực quan.';

  @override
  String get onboardingWelcomeFeature2Title => 'Quét AI hóa đơn';

  @override
  String get onboardingWelcomeFeature2Desc =>
      'Nhập liệu tự động siêu tốc chỉ qua một thao tác chụp màn hình.';

  @override
  String get onboardingWelcomeFeature3Title => 'Đồng hành cùng con';

  @override
  String get onboardingWelcomeFeature3Desc =>
      'Giáo dục giá trị đồng tiền và khuyến khích tiết kiệm mỗi ngày.';

  @override
  String get onboardingWelcomeStartBtn => 'Bắt đầu với MoniKid';

  @override
  String get validationEmailEmpty => 'Vui lòng nhập email';

  @override
  String get validationEmailInvalid => 'Email không hợp lệ';

  @override
  String get validationPasswordEmpty => 'Vui lòng nhập mật khẩu';

  @override
  String get validationPasswordTooShort => 'Mật khẩu tối thiểu 6 ký tự';

  @override
  String get validationPasswordTooLong => 'Mật khẩu tối đa 128 ký tự';

  @override
  String get validationUsernameEmpty => 'Vui lòng nhập họ tên';

  @override
  String get validationUsernameTooShort => 'Họ tên tối thiểu 2 ký tự';

  @override
  String get validationUsernameTooLong => 'Họ tên tối đa 50 ký tự';

  @override
  String get validationPhoneInvalid => 'Số điện thoại không hợp lệ';

  @override
  String get validationConfirmPasswordEmpty => 'Vui lòng xác nhận mật khẩu';

  @override
  String get validationConfirmPasswordMismatch =>
      'Mật khẩu xác nhận không khớp';

  @override
  String get forgotPasswordTitle => 'Quên mật khẩu?';

  @override
  String get forgotPasswordDescription =>
      'Đừng lo lắng! Hãy nhập email đã đăng ký, chúng tôi sẽ gửi link đặt lại mật khẩu để bạn thay đổi mật khẩu.';

  @override
  String get forgotPasswordEmailPlaceholder => 'Nhập email của bạn';

  @override
  String get forgotPasswordSubmitBtn => 'Nhận link đặt mật khẩu';

  @override
  String get forgotPasswordBackToLogin => 'Quay về đăng nhập';

  @override
  String get forgotPasswordEmailSentTitle => 'Email đã được gửi!';

  @override
  String forgotPasswordEmailSentMessage(String email) {
    return 'Chúng tôi đã gửi link đặt lại mật khẩu đến\n$email\n\nVui lòng kiểm tra hộp thư rồi nhấn vào link để đổi mật khẩu.';
  }

  @override
  String get forgotPasswordEmailSentBtn => 'Quay về đăng nhập';

  @override
  String get forgotPasswordEmailHint =>
      'Mã xác thực sẽ được gửi về email của bạn. Vui lòng kiểm tra cả hộp thư chính và thư rác.';

  @override
  String get forgotPasswordChipLabel => 'Gửi mã xác thực';

  @override
  String get forgotPasswordRememberPassword => 'Bạn nhớ lại mật khẩu?';

  @override
  String get forgotPasswordLoginAction => 'Đăng nhập';

  @override
  String get txStatusSuccess => 'Thành công';

  @override
  String get txStatusCompleted => 'Hoàn tất';

  @override
  String get dateToday => 'Hôm nay';

  @override
  String get dateYesterday => 'Hôm qua';

  @override
  String get transactionViewAllCategories => 'Xem tất cả';

  @override
  String get transactionDetailsSection => 'Chi tiết';

  @override
  String get transactionReceiptLabel => 'Ảnh hóa đơn';

  @override
  String get transactionAddPhoto => 'Thêm ảnh';

  @override
  String get transactionChangePhoto => 'Đổi ảnh';

  @override
  String get transactionReceiptEmptyTitle => 'Ảnh hóa đơn sẽ hiển thị ở đây';

  @override
  String get faqCommonQuestions => 'Câu hỏi thường gặp';

  @override
  String get transactionReceiptScanHint => 'Hệ thống sẽ tự động quét thông tin';

  @override
  String get transactionDateToday => 'Hôm nay';

  @override
  String get successDialogDefaultTitle => 'Thành công!';

  @override
  String get successDialogDefaultMessage => 'Thao tác đã hoàn thành.';

  @override
  String get successDialogDefaultButton => 'OK';

  @override
  String get transactionHistoryEyebrow => 'Quản lý chi tiêu';

  @override
  String get transactionHistoryTitle => 'Lịch sử giao dịch';

  @override
  String get transactionHistorySubhead =>
      'Tất cả khoản thu chi của bạn theo thời gian.';

  @override
  String get splashStatusLoading => 'Đang tải tài nguyên cần thiết...';

  @override
  String get notifChildDailyTitle => 'Báo cáo chi tiêu hôm nay';

  @override
  String notifChildDailyBody(int pct, String expense, String month) {
    return 'Bạn còn $pct% hạn mức, bạn đã tiêu $expense trong tháng $month';
  }

  @override
  String notifChildNoLimitBody(String expense, String month) {
    return 'Bạn đã tiêu $expense trong tháng $month';
  }

  @override
  String get notifParentDailyTitle => 'Báo cáo chi tiêu gia đình';

  @override
  String notifParentChildBody(String name, int pct, String expense) {
    return 'Con bạn $name chỉ còn $pct% theo hạn mức, đã tiêu $expense';
  }

  @override
  String get notifScheduleError =>
      'Không thể lên lịch thông báo. Vui lòng thử lại.';
}

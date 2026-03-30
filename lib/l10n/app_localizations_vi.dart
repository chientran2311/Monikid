// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class SVi extends S {
  SVi([String locale = 'vi']) : super(locale);

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
}

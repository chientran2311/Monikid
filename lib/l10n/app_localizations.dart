import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @vietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Anh'**
  String get english;

  /// No description provided for @close.
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get close;

  /// No description provided for @validationEmptyFields.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng điền đủ thông tin (Tên, Email, Mật khẩu)'**
  String get validationEmptyFields;

  /// No description provided for @registerFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại: {error}'**
  String registerFailed(String error);

  /// No description provided for @noTransactionsYet.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có giao dịch nào.'**
  String get noTransactionsYet;

  /// No description provided for @errorGeneric.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi: {error}'**
  String errorGeneric(String error);

  /// No description provided for @settingFQA.
  ///
  /// In vi, this message translates to:
  /// **'Câu hỏi thường gặp'**
  String get settingFQA;

  /// No description provided for @msgNoData.
  ///
  /// In vi, this message translates to:
  /// **'Không có dữ liệu'**
  String get msgNoData;

  /// No description provided for @helpStillNeedHelp.
  ///
  /// In vi, this message translates to:
  /// **'Vẫn cần trợ giúp?'**
  String get helpStillNeedHelp;

  /// No description provided for @helpContactSupportDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nếu bạn không tìm thấy câu trả lời, hãy liên hệ với đội ngũ hỗ trợ của chúng tôi 24/7.'**
  String get helpContactSupportDesc;

  /// No description provided for @actionChatWithUs.
  ///
  /// In vi, this message translates to:
  /// **'Chat với chúng tôi'**
  String get actionChatWithUs;

  /// No description provided for @actionRetry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get actionRetry;

  /// No description provided for @validationEnterAmount.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập số tiền'**
  String get validationEnterAmount;

  /// No description provided for @validationAmountGreaterThanZero.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền phải lớn hơn 0'**
  String get validationAmountGreaterThanZero;

  /// No description provided for @msgAddTransactionSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Thêm giao dịch thành công!'**
  String get msgAddTransactionSuccess;

  /// No description provided for @msgTransactionDeleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa giao dịch'**
  String get msgTransactionDeleted;

  /// No description provided for @actionCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get actionCancel;

  /// No description provided for @actionConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get actionConfirm;

  /// No description provided for @validationInvalidAmount.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền không hợp lệ'**
  String get validationInvalidAmount;

  /// No description provided for @msgUpdateSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thành công'**
  String get msgUpdateSuccess;

  /// No description provided for @profileEditTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa hồ sơ'**
  String get profileEditTitle;

  /// No description provided for @profileEditAvatarLabel.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi ảnh đại diện'**
  String get profileEditAvatarLabel;

  /// No description provided for @profileEditFullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get profileEditFullName;

  /// No description provided for @profileEditFullNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ và tên của bạn'**
  String get profileEditFullNameHint;

  /// No description provided for @profileEditPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get profileEditPhone;

  /// No description provided for @profileEditPhoneHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số điện thoại'**
  String get profileEditPhoneHint;

  /// No description provided for @profileEditEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get profileEditEmail;

  /// No description provided for @profileEditEmailWarning.
  ///
  /// In vi, this message translates to:
  /// **'Email không thể thay đổi để bảo mật tài khoản.'**
  String get profileEditEmailWarning;

  /// No description provided for @profileEditDob.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get profileEditDob;

  /// No description provided for @profileEditDobHint.
  ///
  /// In vi, this message translates to:
  /// **'DD/MM/YYYY'**
  String get profileEditDobHint;

  /// No description provided for @actionSaveChanges.
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get actionSaveChanges;

  /// No description provided for @editRequestTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa yêu cầu'**
  String get editRequestTitle;

  /// No description provided for @requestAmountLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền yêu cầu'**
  String get requestAmountLabel;

  /// No description provided for @requestReasonLabel.
  ///
  /// In vi, this message translates to:
  /// **'Lý do của con'**
  String get requestReasonLabel;

  /// No description provided for @categoryBooks.
  ///
  /// In vi, this message translates to:
  /// **'Mua sách/vở'**
  String get categoryBooks;

  /// No description provided for @categorySnacks.
  ///
  /// In vi, this message translates to:
  /// **'Ăn vặt'**
  String get categorySnacks;

  /// No description provided for @categoryGames.
  ///
  /// In vi, this message translates to:
  /// **'Nạp game'**
  String get categoryGames;

  /// No description provided for @categoryGifts.
  ///
  /// In vi, this message translates to:
  /// **'Quà tặng'**
  String get categoryGifts;

  /// No description provided for @additionalNoteLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú thêm'**
  String get additionalNoteLabel;

  /// No description provided for @whatDoYouNeedToBuyHint.
  ///
  /// In vi, this message translates to:
  /// **'Con cần mua gì?'**
  String get whatDoYouNeedToBuyHint;

  /// No description provided for @requestRecipientLabel.
  ///
  /// In vi, this message translates to:
  /// **'Người nhận yêu cầu'**
  String get requestRecipientLabel;

  /// No description provided for @recipientDad.
  ///
  /// In vi, this message translates to:
  /// **'Bố'**
  String get recipientDad;

  /// No description provided for @recipientMom.
  ///
  /// In vi, this message translates to:
  /// **'Mẹ'**
  String get recipientMom;

  /// No description provided for @actionUpdateRequest.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật yêu cầu'**
  String get actionUpdateRequest;

  /// No description provided for @actionDeleteRequest.
  ///
  /// In vi, this message translates to:
  /// **'Xóa yêu cầu'**
  String get actionDeleteRequest;

  /// No description provided for @scanbill.
  ///
  /// In vi, this message translates to:
  /// **'Quét Hóa Đơn'**
  String get scanbill;

  /// No description provided for @chatting.
  ///
  /// In vi, this message translates to:
  /// **'Trò Chuyện'**
  String get chatting;

  /// No description provided for @requestmoney.
  ///
  /// In vi, this message translates to:
  /// **'Xin Tiền'**
  String get requestmoney;

  /// No description provided for @takePicture.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh'**
  String get takePicture;

  /// No description provided for @chooseFromGallery.
  ///
  /// In vi, this message translates to:
  /// **'Tải ảnh lên'**
  String get chooseFromGallery;

  /// No description provided for @scanReceiptTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quét hoá đơn'**
  String get scanReceiptTitle;

  /// No description provided for @scanReceiptDesc.
  ///
  /// In vi, this message translates to:
  /// **'Chọn cách thêm ảnh hoá đơn để xử lý.'**
  String get scanReceiptDesc;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'vi':
      return SVi();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

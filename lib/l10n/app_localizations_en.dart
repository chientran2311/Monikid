// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';

  @override
  String get close => 'Close';

  @override
  String get validationEmptyFields =>
      'Please fill in all fields (Name, Email, Password)';

  @override
  String registerFailed(String error) {
    return 'Registration failed: $error';
  }

  @override
  String get noTransactionsYet => 'No transactions yet.';

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get settingFQA => 'Frequently Asked Questions';

  @override
  String get msgNoData => 'No data found';

  @override
  String get helpStillNeedHelp => 'Still need help?';

  @override
  String get helpContactSupportDesc =>
      'If you cannot find the answer, contact our support team 24/7.';

  @override
  String get actionChatWithUs => 'Chat with us';

  @override
  String get actionRetry => 'Retry';

  @override
  String get validationEnterAmount => 'Please enter amount';

  @override
  String get validationAmountGreaterThanZero => 'Amount must be greater than 0';

  @override
  String get msgAddTransactionSuccess => 'Transaction added successfully!';

  @override
  String get msgTransactionDeleted => 'Transaction deleted';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get validationInvalidAmount => 'Invalid amount';

  @override
  String get msgUpdateSuccess => 'Update successful';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String get profileEditAvatarLabel => 'Change Avatar';

  @override
  String get profileEditFullName => 'Full Name';

  @override
  String get profileEditFullNameHint => 'Enter your full name';

  @override
  String get profileEditPhone => 'Phone Number';

  @override
  String get profileEditPhoneHint => 'Enter phone number';

  @override
  String get profileEditEmail => 'Email';

  @override
  String get profileEditEmailWarning =>
      'Email cannot be changed for security reasons.';

  @override
  String get profileEditDob => 'Date of Birth';

  @override
  String get profileEditDobHint => 'DD/MM/YYYY';

  @override
  String get actionSaveChanges => 'Save Changes';

  @override
  String get editRequestTitle => 'Edit Request';

  @override
  String get requestAmountLabel => 'Requested Amount';

  @override
  String get requestReasonLabel => 'Reason';

  @override
  String get categoryBooks => 'Buy books/notebooks';

  @override
  String get categorySnacks => 'Snacks';

  @override
  String get categoryGames => 'Top up games';

  @override
  String get categoryGifts => 'Gifts';

  @override
  String get additionalNoteLabel => 'Additional Note';

  @override
  String get whatDoYouNeedToBuyHint => 'What do you need to buy?';

  @override
  String get requestRecipientLabel => 'Recipients';

  @override
  String get recipientDad => 'Dad';

  @override
  String get recipientMom => 'Mom';

  @override
  String get actionUpdateRequest => 'Update Request';

  @override
  String get actionDeleteRequest => 'Delete Request';

  @override
  String get scanbill => 'Scan Bill';

  @override
  String get chatting => 'Family Chat';

  @override
  String get requestmoney => 'Request Money';

  @override
  String get takePicture => 'Take Photo';

  @override
  String get chooseFromGallery => 'Upload from Gallery';

  @override
  String get scanReceiptTitle => 'Scan Receipt';

  @override
  String get scanReceiptDesc => 'Choose how to add receipt image to process.';
}

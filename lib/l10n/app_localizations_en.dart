// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';

  @override
  String get languageVietnameseSubtitle =>
      'Display the entire app in Vietnamese';

  @override
  String get languageEnglishSubtitle => 'Use English across the app interface';

  @override
  String get close => 'Close';

  @override
  String get actionSkip => 'Skip';

  @override
  String get onboardingLanguageTitleLeading => 'Choose';

  @override
  String get onboardingLanguageTitleHighlight => 'language';

  @override
  String get onboardingLanguageDescription =>
      'Please choose the language you want to use in the app.';

  @override
  String get onboardingContinueAction => 'Continue';

  @override
  String get onboardingLanguageSubtitle =>
      'You can change this later in settings.';

  @override
  String get onboardingLanguageCardTitle => 'Display language';

  @override
  String get onboardingLanguageCardDesc =>
      'Monikid will use this language for lessons and notifications.';

  @override
  String get onboardingLanguageViDesc => 'For users in Vietnam';

  @override
  String get onboardingLanguageEnDesc => 'For bilingual learners and parents';

  @override
  String get onboardingLanguageHint =>
      'Next step: Monikid will ask for notification permission to remind you of schedules and important updates.';

  @override
  String get onboardingSkipLater => 'Later';

  @override
  String get onboardingNotificationTitle =>
      'Enable notifications to track spending on time';

  @override
  String get onboardingNotificationSubtitle =>
      'Monikid will send updates when there are new transactions, balance changes, and important spending activities so parents always stay informed.';

  @override
  String get onboardingNotificationBenefitsTitle =>
      'Benefits of enabling notifications';

  @override
  String get onboardingNotificationBenefitsDesc =>
      'Only useful updates to help parents manage spending more easily every day.';

  @override
  String get onboardingNotificationEnableBtn => 'Enable notifications';

  @override
  String get onboardingNotificationBenefit1Title =>
      'Know instantly about new transactions';

  @override
  String get onboardingNotificationBenefit1Desc =>
      'Track your child\'s spending almost immediately after it happens.';

  @override
  String get onboardingNotificationBenefit2Title =>
      'Get alerts when balance changes';

  @override
  String get onboardingNotificationBenefit2Desc =>
      'Helps control budget and detect notable fluctuations.';

  @override
  String get onboardingNotificationBenefit3Title =>
      'Parents always stay informed';

  @override
  String get onboardingNotificationBenefit3Desc =>
      'Support your child in learning how to manage money wisely.';

  @override
  String get onboardingNotificationSheetTitle =>
      '\"Monikid\" wants to send you notifications';

  @override
  String get onboardingNotificationSheetDesc =>
      'Notifications may include new transactions, balance changes, and important spending updates.';

  @override
  String get onboardingNotificationSheetRowTitle =>
      'Track transactions on time';

  @override
  String get onboardingNotificationSheetRowDesc =>
      'Helps parents know about their child\'s spending faster.';

  @override
  String get onboardingNotificationSheetDeny => 'Don\'t allow';

  @override
  String get onboardingNotificationSheetAllow => 'Allow';

  @override
  String get onboardingNotificationMiniAmount => '-120.000đ';

  @override
  String get onboardingNotificationMiniMeta => 'Buy books • 2 minutes ago';

  @override
  String get validationEmptyFields =>
      'Please fill in all fields (Name, Email, Password)';

  @override
  String registerFailed(String error) {
    return 'Registration failed: $error';
  }

  @override
  String get navChildHome => 'Home';

  @override
  String get navChildTransactions => 'Transactions';

  @override
  String get navChildStatistic => 'Statistics';

  @override
  String get navChildSettings => 'Settings';

  @override
  String get homeParFamilyMembersLabel => 'Family Members';

  @override
  String get homeParNoFamilyTitle => 'Start your journey';

  @override
  String get homeParNoFamilySubtitle =>
      'Welcome to MoniKid. Add your first member to start managing family spending.';

  @override
  String get homeParCreateFamilyBtn => 'Create Family';

  @override
  String get homeParNoFamilyHintSafe => 'Safe management for your kids';

  @override
  String get homeParNoFamilyHintChart => 'Track spending charts';

  @override
  String get homeParErrorTitle => 'Something went wrong';

  @override
  String get homeParErrorDesc => 'Couldn\'t load your home. Please try again.';

  @override
  String get homeParInviteTitle => 'Invite Member';

  @override
  String get homeParInviteDesc =>
      'Share this code with your child or family member to join your MoniKid family.';

  @override
  String get homeParInviteCodeLabel => 'Link Code';

  @override
  String get homeParInviteCodeLoadError =>
      'Couldn\'t load the invite code. Please try again.';

  @override
  String get homeParCopyCode => 'Copy Code';

  @override
  String get homeParCodeCopied => 'Copied!';

  @override
  String get homeParManageMembers => 'Manage';

  @override
  String get homeParSpendingOverview => 'This Month';

  @override
  String get homeParMonthlyExpense => 'Spent';

  @override
  String get homeParMonthlyIncome => 'Income';

  @override
  String get homeParTransactionTagNew => 'New';

  @override
  String get homeParTransactionTagEdited => 'Edited';

  @override
  String get homeParLoadingMemberData => 'Loading...';

  @override
  String get homeParAddMember => 'Add';

  @override
  String get homeParRecentTransactionsLabel => 'Recent Transactions';

  @override
  String get homeParSeeAll => 'See All';

  @override
  String get homeParAlertsLabel => 'Alerts';

  @override
  String get homeParAlertWeeklyLimitTitle => 'Approaching Weekly Limit';

  @override
  String get homeParAlertWeeklyLimitBody =>
      'Check spending limits for your family members.';

  @override
  String homeParTopCategoryAlertTitle(String category) {
    return 'Highest spending in $category';
  }

  @override
  String get homeParTopCategoryAlertBody => 'Tap to view transaction details';

  @override
  String get homeParThisMonth => 'This month';

  @override
  String get homeParViewDetail => 'View details';

  @override
  String homeParSpentPercent(String percent) {
    return 'Spent $percent% of income';
  }

  @override
  String get homeParTotalMonthlySpending => 'Total spending this month';

  @override
  String get homeParLimitLabel => 'Limit:';

  @override
  String homeParUsedPercent(String percent) {
    return 'Used $percent%';
  }

  @override
  String get homeParLowBalanceTitle => 'Low balance';

  @override
  String homeParLowBalanceDesc(String name) {
    return '$name\'s account is below 100,000₫.';
  }

  @override
  String get homeParSpendingWarningTitle => 'Daily spending over threshold';

  @override
  String homeParSpendingWarningDesc(
    String name,
    String todayAmount,
    String threshold,
  ) {
    return '$name spent $todayAmount today — over the 5% daily threshold ($threshold).';
  }

  @override
  String get homeParSpendingSafeTitle => 'Daily spending on track';

  @override
  String homeParSpendingSafeDesc(String name) {
    return '$name is within safe spending limits today.';
  }

  @override
  String get homeParTransactionSuccess => 'Success';

  @override
  String get noTransactionsYet => 'No transactions yet.';

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get settingFAQ => 'Frequently Asked Questions';

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
  String get actionCancel => 'Cancel';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionDone => 'Done';

  @override
  String get actionSelect => 'Select';

  @override
  String get validationInvalidAmount => 'Invalid amount';

  @override
  String get msgUpdateSuccess => 'Update successful';

  @override
  String get addTransactionFailed =>
      'Unable to add transaction. Please try again.';

  @override
  String get updateTransactionFailed =>
      'Unable to update transaction. Please try again.';

  @override
  String get updateTransactionMissingError => 'Missing transaction to update.';

  @override
  String get transactionLoadError => 'Unable to load transaction.';

  @override
  String get transactionCategoryLoadError =>
      'Unable to load categories. Please try again.';

  @override
  String get transactionUserNotAuthenticated => 'User is not authenticated.';

  @override
  String get transactionAmountLabel => 'Amount';

  @override
  String get transactionAmountInputLabel => 'Enter amount';

  @override
  String get transactionDetailSectionLabel => 'Details';

  @override
  String get transactionDateRowLabel => 'Transaction date';

  @override
  String get transactionExpenseTab => 'Expense';

  @override
  String get transactionIncomeTab => 'Income';

  @override
  String get transactionCategoryViewAll => 'View all';

  @override
  String get transactionEvidenceRowLabel => 'Receipt photo';

  @override
  String get transactionCategoryLabel => 'Category';

  @override
  String get transactionDateLabel => 'Date';

  @override
  String get transactionHistorySelectDateTitle => 'Select date';

  @override
  String get transactionNoteLabel => 'Note';

  @override
  String get transactionExpenseType => 'Expense';

  @override
  String get transactionIncomeType => 'Income';

  @override
  String get transactionSaveAction => 'Save transaction';

  @override
  String get transactionAiAutoLabel => 'AI auto';

  @override
  String get addTransactionNoteHint =>
      'Enter a note, AI will categorize it automatically...';

  @override
  String get updateTransactionTitle => 'Edit transaction';

  @override
  String get updateTransactionAction => 'Update transaction';

  @override
  String get updateTransactionNoteHint => 'Add a note...';

  @override
  String get transactionDetailTitle => 'Transaction details';

  @override
  String get transactionDetailNoData => 'No transaction data available.';

  @override
  String get transactionDetailTimeLabel => 'TIME';

  @override
  String get transactionDetailCreatedAtLabel => 'CREATED AT';

  @override
  String get transactionDetailNoteLabel => 'NOTE';

  @override
  String get transactionDetailEvidenceLabel => 'EVIDENCE IMAGE';

  @override
  String get transactionEditAction => 'Edit transaction';

  @override
  String get transactionDeleteAction => 'Delete transaction';

  @override
  String get transactionEvidenceSectionTitle => 'Evidence image';

  @override
  String get transactionEvidenceAddOptionalLabel =>
      'Add evidence image (optional)';

  @override
  String get transactionEvidenceOptionalLabel =>
      'Optional. Add one proof image for this transaction.';

  @override
  String get transactionEvidenceUploadAction => 'Upload image';

  @override
  String get transactionEvidenceAddAction => 'Add image';

  @override
  String get transactionEvidenceReplaceAction => 'Replace image';

  @override
  String get transactionEvidenceRemoveAction => 'Remove image';

  @override
  String get transactionEvidenceSelectedLabel => 'Selected image';

  @override
  String get transactionEvidenceAttachedLabel => 'Image attached';

  @override
  String get transactionEvidenceEmpty => 'No evidence image attached yet.';

  @override
  String get transactionEvidenceLoadError =>
      'Unable to load the evidence image.';

  @override
  String get transactionEvidenceLegacyUnavailable =>
      'This evidence image was stored with the old storage flow and is no longer available here.';

  @override
  String get transactionEvidenceUnsupportedFormat =>
      'Only JPG and PNG images are supported.';

  @override
  String get transactionEvidenceUploadTimeout =>
      'Image upload timed out. Please try again.';

  @override
  String get transactionEvidencePermissionDenied =>
      'Unable to save the evidence image. Check the Firestore rules for Cloudinary evidence_image.';

  @override
  String get transactionPermissionDenied =>
      'Current rules are blocking the transaction write. Check the Firestore schema and rules again.';

  @override
  String get transactionScanAction => 'Scan receipt';

  @override
  String get transactionRescanAction => 'Scan again';

  @override
  String get transactionScanHint =>
      'Take or choose one receipt image to autofill amount, date, category, and note.';

  @override
  String get transactionScanExtracting =>
      'Reading text from the receipt image...';

  @override
  String get transactionScanAnalyzing =>
      'Analyzing category and writing description...';

  @override
  String get transactionScanSuccess =>
      'Autofill complete. Review every suggested field before saving.';

  @override
  String get transactionScanPartial =>
      'Basic fields were filled from OCR. Review category and note manually if needed.';

  @override
  String get transactionScanFailed =>
      'Unable to analyze this receipt. You can try again or enter the transaction manually.';

  @override
  String get transactionScanNoTextFound =>
      'No readable text was found in this receipt image.';

  @override
  String get transactionScanNoSuggestion =>
      'No usable autofill suggestion was found. Please review the form manually.';

  @override
  String get profileEditTitle => 'Personal Profile';

  @override
  String get profileEditAvatarLabel => 'Change Avatar';

  @override
  String get profileEditAvatarDesc => 'Take a new photo or choose from gallery';

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
  String get profileEditDobPickerTitle => 'Select Date of Birth';

  @override
  String get profileEditDobPickerDone => 'Done';

  @override
  String get actionSaveChanges => 'Save Changes';

  @override
  String get profileEditSaveSuccess => 'Profile updated successfully';

  @override
  String get profileEditErrorNameRequired => 'Full name is required';

  @override
  String get profileEditErrorNameTooShort =>
      'Name must be at least 2 characters';

  @override
  String get profileEditErrorInvalidPhone =>
      'Invalid Vietnamese phone number (e.g. 0912345678)';

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

  @override
  String get scanReceiptCameraSubtitle => 'Open camera to take photo directly';

  @override
  String get scanReceiptGallerySubtitle => 'Choose from device photo library';

  @override
  String get chooseAiModelTitle => 'Choose AI model';

  @override
  String get chooseAiModelDescription =>
      'Use your Gemini API key to test a real AI request in this screen. The local gemma 2b download path is still being prepared separately.';

  @override
  String get aiModelGeminiName => 'Gemini';

  @override
  String get aiModelUseApiKeyModel => 'Use API key model';

  @override
  String get aiModelUseLocalModel => 'Use local model';

  @override
  String get aiModelApiKeyAddSuccess => 'API key verified and saved';

  @override
  String get aiModelApiKeyInvalid =>
      'Invalid API key. Please check and try again.';

  @override
  String get aiModelApiKeyTestFailed =>
      'Could not verify API key. Check your internet connection.';

  @override
  String get aiModelGemmaName => 'gemma 2b';

  @override
  String get aiModelApiKeyHint => 'Enter API key';

  @override
  String get aiModelAddApiKey => 'Add API Key';

  @override
  String get aiModelRemoveApiKey => 'Remove API Key';

  @override
  String get aiModelApiKeySessionNote =>
      'API key is securely stored on this device.';

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
  String get aiModelLocalSectionTitle => 'Local model';

  @override
  String get aiModelDownload => 'Download';

  @override
  String get aiModelGemmaDownloadConfirmMessage =>
      'File size: ~1.35 GB. Make sure you have enough storage and a stable connection before downloading.';

  @override
  String get aiModelDeleteModel => 'Delete model';

  @override
  String get aiModelGemmaDeleteConfirmMessage =>
      'Delete AI model from device? You will need to re-download it to use it again.';

  @override
  String get aiModelGemmaDescription =>
      'Source provenance is pinned to the official Google Gemma docs and the google/gemma-2b-it distribution channel. The app download URL will be managed separately later.';

  @override
  String get aiModelComingSoon => 'Coming soon';

  @override
  String get aiModelAnalyzeTransaction => 'Analyze Transaction';

  @override
  String get aiModelAnalyzingTransaction => 'Analyzing...';

  @override
  String get aiModelSelectModelLabel => 'Select model';

  @override
  String get aiModelHeroEyebrow => 'AI model setup';

  @override
  String get aiModelHeroTitle => 'Choose your AI analysis model';

  @override
  String get aiModelHeroSubtitle =>
      'Connect via Gemini API or download a local model for on-device processing.';

  @override
  String get aiModelGeminiCardDescription =>
      'Use cloud AI to categorize transactions and get quick spending insights.';

  @override
  String get aiModelRecommendedBadge => 'Recommended';

  @override
  String get aiModelGemmaCardDescription =>
      'Runs on-device for enhanced privacy. Keeps all data on your phone.';

  @override
  String get aiModelPrivateBadge => 'Private';

  @override
  String get aiModelFooterNote =>
      'You can switch models anytime in AI settings.';

  @override
  String get aiModelEnableGemini => 'Enable Gemini';

  @override
  String get aiModelSelectModelConfirmMessage =>
      'This model will be used for the next Gemini requests on this device.';

  @override
  String get aiModelUseThisModel => 'Use this model';

  @override
  String get aiModelSavingModelSelection => 'Saving selected model...';

  @override
  String get appBarBrandTitle => 'SmartSpending';

  @override
  String get appBarNotificationsTooltip => 'Notifications';

  @override
  String get navParentHome => 'Home';

  @override
  String get navParentStatistic => 'Statistics';

  @override
  String get navParentSettings => 'Settings';

  @override
  String get parentStatisticTitle => 'Statistics';

  @override
  String get parentStatisticWeek => 'Week';

  @override
  String get parentStatisticMonth => 'Month';

  @override
  String get parentStatisticYear => 'Year';

  @override
  String get parentStatisticBudgetTitle => 'Weekly Budget';

  @override
  String get parentStatisticSpentLabel => 'Spent';

  @override
  String get parentStatisticLeftLabel => 'Left';

  @override
  String get parentStatisticTrendTitle => 'Spending Trend';

  @override
  String get parentStatisticTopCategoriesTitle => 'Top Categories';

  @override
  String get parentStatisticNoData => 'No data available yet';

  @override
  String get parentStatisticTotalSpentTitle => 'Total spent';

  @override
  String get parentStatisticVsLastMonth => 'vs last month';

  @override
  String parentStatisticSpendingUp(String percent) {
    return '+$percent%';
  }

  @override
  String parentStatisticSpendingDown(String percent) {
    return '-$percent%';
  }

  @override
  String get parentStatisticSpendingStable => 'Stable';

  @override
  String get parentStatisticLoading => 'Loading spending statistics...';

  @override
  String get parentStatisticLoadError => 'Could not load spending statistics.';

  @override
  String get parentStatisticRetry => 'Retry';

  @override
  String get parentStatisticSelectChild =>
      'Select a child to view spending statistics.';

  @override
  String parentStatisticTransactionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
      zero: 'No transactions',
    );
    return '$_temp0';
  }

  @override
  String get parentStatisticTotalExpenseLabel => 'TOTAL SPENT';

  @override
  String get parentStatisticTxCountLabel => 'TX COUNT';

  @override
  String get parentStatisticPrevPeriodLabel => 'PREV PERIOD';

  @override
  String get parentStatisticTrendGood => 'Good';

  @override
  String get parentStatisticTrendBad => 'Bad';

  @override
  String get parentStatisticHeatmapTitle => 'Spending Calendar';

  @override
  String get parentStatisticHeatmapNoData => 'No data for this period';

  @override
  String get parentStatisticTopCategoryTitle => 'Top Category';

  @override
  String get parentStatisticTopCategorySubtitle => 'Top spending';

  @override
  String parentStatisticTopCategoryShare(String percent) {
    return '$percent% of total';
  }

  @override
  String get parentStatisticBalanceTitle => 'Balance';

  @override
  String get parentStatisticBalanceIncome => 'Income';

  @override
  String get parentStatisticBalanceExpense => 'Expense';

  @override
  String get parentStatisticInsightsAvgPerDay => 'Avg / day';

  @override
  String get parentStatisticInsightsPeakDay => 'Peak day';

  @override
  String get parentStatisticInsightsStreak => 'Spend streak';

  @override
  String parentStatisticInsightsStreakDays(int days) {
    return '${days}d';
  }

  @override
  String get parentStatisticInsightsNoPeak => '—';

  @override
  String get parentStatisticEditedBadge => 'Edited';

  @override
  String get settingParTitle => 'Settings';

  @override
  String get settingParEditProfile => 'Edit profile';

  @override
  String get settingParFamilyTitle => 'Family management';

  @override
  String get settingParManageFamilyLabel => 'Manage Family Member';

  @override
  String get settingParChildAccountsLabel => 'Child accounts';

  @override
  String get settingParChildAccountsSubtitle => 'Add or remove accounts';

  @override
  String get settingParSpendingLimitLabel => 'Spending limit';

  @override
  String get settingParSpendingLimitSubtitle => 'Set weekly/monthly limits';

  @override
  String get settingParAppearanceTitle => 'Appearance';

  @override
  String get settingParThemeLabel => 'Light/Dark mode';

  @override
  String get settingThemeDarkLabel => 'Dark mode';

  @override
  String get settingThemeDarkSubtitle => 'Switch to a dark interface';

  @override
  String get settingParNotificationsTitle => 'Notifications';

  @override
  String get settingParPushLabel => 'Push notifications';

  @override
  String get settingParPushSubtitle => 'When child makes a transaction';

  @override
  String get settingParEmailReportLabel => 'Weekly email report';

  @override
  String get settingParAccountTitle => 'Account';

  @override
  String get settingParChangePasswordLabel => 'Change password';

  @override
  String get settingParHelpLabel => 'Help & Feedback';

  @override
  String get settingParLogoutLabel => 'Sign out';

  @override
  String get settingParVersion => 'Version 1.0.2';

  @override
  String get settingStuTitle => 'Settings';

  @override
  String get settingStuSectionGeneral => 'General';

  @override
  String get settingStuSectionAccount => 'Account';

  @override
  String get settingStuBudgetLabel => 'Budget Setup';

  @override
  String get settingStuFamilyCodeLabel => 'Family Code';

  @override
  String get settingStuEyebrow => 'Account & App';

  @override
  String get settingStuSubtitle =>
      'Manage your language, notifications and family connection.';

  @override
  String get settingStuNotificationsSubtitle =>
      'Receive new transaction alerts';

  @override
  String get settingStuAiModelSubtitle => 'Smart budget assistant';

  @override
  String get settingStuFamilyCodeSubtitle => 'Connect with parent account';

  @override
  String get settingStuProfileEditLabel => 'Edit Profile';

  @override
  String get settingStuProfileEditSubtitle => 'Update your personal info';

  @override
  String get settingStuFaqSubtitle => 'Answers to common questions';

  @override
  String get settingSignOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get settingSignOutFailed => 'Sign out failed';

  @override
  String get aiModelApiKeyLabel => 'API Key';

  @override
  String get aiModelGeminiSectionTitle => 'Gemini Google API';

  @override
  String get aiModelBetaLabel => 'Beta';

  @override
  String get aiModelDownloadingNote => 'Do not close the app';

  @override
  String get loginWelcomeTitle => 'Welcome back';

  @override
  String get loginWelcomeSubtitle => 'Sign in to continue.';

  @override
  String get loginTagline => 'Smart family finance';

  @override
  String get loginAccountLabel => 'Account';

  @override
  String get loginEmailPlaceholder => 'Email / phone number';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordPlaceholder => 'Enter password';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginRegisterButton => 'Sign up if you don\'t have an account';

  @override
  String get registerTitle => 'Create new account';

  @override
  String get registerSubtitle =>
      'Fill in your details to get started with Monikid.';

  @override
  String get registerTagline => 'Begin your financial journey';

  @override
  String get registerEmailPlaceholder => 'you@example.com';

  @override
  String get registerUsernameLabel => 'Username';

  @override
  String get registerUsernamePlaceholder => 'Enter your name';

  @override
  String get registerPhoneLabel => 'Phone number';

  @override
  String get registerPhonePlaceholder => 'Enter phone number';

  @override
  String get registerPasswordPlaceholder => 'Create a password';

  @override
  String get registerConfirmPasswordLabel => 'Confirm password';

  @override
  String get registerConfirmPasswordPlaceholder => 'Re-enter your password';

  @override
  String get registerRoleParent => 'Parent';

  @override
  String get registerRoleStudent => 'Student';

  @override
  String get registerHaveAccountText => 'Already have an account?';

  @override
  String get validationPasswordMismatch => 'Passwords do not match.';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordPlaceholder => 'Enter your password';

  @override
  String get authSignUpAction => 'Sign up';

  @override
  String get authSignInAction => 'Sign in';

  @override
  String get authNoAccountPrompt => 'Don\'t have an account? ';

  @override
  String get authHaveAccountPrompt => 'Already have an account? ';

  @override
  String get pinCreateTitle => 'Create a new PIN';

  @override
  String get pinCreateDescription =>
      'Create a 6-digit PIN to protect your account.';

  @override
  String get pinReEnterTitle => 'Confirm your PIN';

  @override
  String get pinReEnterDescription => 'Enter your new PIN again to confirm it.';

  @override
  String get pinEnterTitle => 'Enter your PIN';

  @override
  String get pinEnterDescription => 'Enter your 6-digit PIN to continue.';

  @override
  String get pinMismatchError => 'The PIN confirmation does not match.';

  @override
  String get pinIncorrectError => 'The PIN you entered is incorrect.';

  @override
  String pinLockedMessage(int seconds) {
    return 'Too many incorrect attempts. Try again in ${seconds}s.';
  }

  @override
  String get pinGenericError => 'A PIN error occurred. Please try again.';

  @override
  String get pinGatewayLoading => 'Checking your PIN security...';

  @override
  String get pinGatewayError => 'Unable to start the PIN verification flow.';

  @override
  String get homeStudentGreeting => 'Good morning,';

  @override
  String get homeStudentDefaultName => 'Student';

  @override
  String homeStudentMonthlySummaryTitleWithMonth(String monthLabel) {
    return 'Overview for $monthLabel';
  }

  @override
  String get homeStudentMonthlyIncome => 'Income';

  @override
  String get homeStudentMonthlyExpense => 'Expense';

  @override
  String get homeStudentRemainingBudget => 'Remaining budget';

  @override
  String get homeStudentRecentTransactions => 'Recent transactions';

  @override
  String get homeStudentViewAll => 'View all';

  @override
  String get homeStudentLoadError =>
      'Unable to load the home dashboard. Please try again.';

  @override
  String get homeStudentAddTransaction => 'Add transaction';

  @override
  String get homeStudentSetMonthlyLimit => 'Set limit';

  @override
  String get homeStudentMonthlyLimitNotSet => 'Set your monthly limit';

  @override
  String get homeStudentSummaryEyebrow => 'Monthly overview';

  @override
  String homeStudentSummaryTitle(int month) {
    return 'Month $month spending';
  }

  @override
  String homeStudentTodayTransactionsSub(int count) {
    return '$count transactions today';
  }

  @override
  String get homeStudentTopCategoryLabel => 'Top spending';

  @override
  String homeStudentMonthPill(int month) {
    return 'Month $month';
  }

  @override
  String homeStudentUsedPercent(int percent) {
    return 'Used $percent%';
  }

  @override
  String get homeStudentTransactionsLabel => 'Transactions';

  @override
  String homeStudentTransactionCountLabel(int count) {
    return '$count transactions';
  }

  @override
  String homeStudentRemainingAmount(String amount) {
    return 'Left: $amount';
  }

  @override
  String get homeStudentQuickActionsTitle => 'Quick actions';

  @override
  String get homeStudentScanBillTitle => 'Scan bill AI';

  @override
  String get homeStudentScanBillSubtitle => 'Scan receipts and save quickly';

  @override
  String get homeStudentSetLimitSubtitle => 'Control monthly spending';

  @override
  String get homeStudentMonthlyIncomeLabel => 'Income';

  @override
  String get homeStudentUsedLabel => 'Used';

  @override
  String get setMoneyLimitTitle => 'Set monthly limit';

  @override
  String get setMoneyLimitFieldLabel => 'Limit';

  @override
  String get setMoneyLimitSubtitle =>
      'Enter the maximum amount your child can spend this month. Changes will apply immediately to the current month.';

  @override
  String get setMoneyLimitDescription =>
      'Check that the limit fits your child\'s plan for the month.';

  @override
  String get setMoneyLimitSkipAction => 'Skip';

  @override
  String get setMoneyLimitUnauthenticated =>
      'Please sign in again to set a monthly limit.';

  @override
  String get setMoneyLimitSaveFailed =>
      'Unable to save the monthly limit. Please try again.';

  @override
  String setMoneyLimitQuickAmount(int millionCount) {
    return '+$millionCount,000,000đ';
  }

  @override
  String get statisticTitle => 'Spending statistics';

  @override
  String get statisticByWeek => 'By week';

  @override
  String get statisticByMonth => 'By month';

  @override
  String get statisticByYear => 'Yearly';

  @override
  String get statisticHeaderEyebrow => 'Track your child\'s spending';

  @override
  String get statisticHeaderSubhead =>
      'Transaction summary, budget alerts, and top spending categories at a glance.';

  @override
  String get statisticAlertTitle => 'Spending Alert';

  @override
  String get statisticAlertPriority => 'Priority Check';

  @override
  String get statisticProgressUsageLabel => 'Usage progress';

  @override
  String get statisticBudgetAdjustAnytime =>
      'Parents can adjust the limit at any time';

  @override
  String get statisticChartSectionTitle => 'Spending Chart';

  @override
  String get statisticChartComparisonTitle => 'Compare Over Time';

  @override
  String get statisticWeekNoun => 'week';

  @override
  String get statisticMonthNoun => 'month';

  @override
  String get statisticYearNoun => 'year';

  @override
  String get statisticLoadError =>
      'Unable to load statistic data. Please try again.';

  @override
  String get statisticThisWeek => 'This week';

  @override
  String get statisticLastWeek => 'Last week';

  @override
  String get statisticThisMonth => 'This month';

  @override
  String get statisticLastMonth => 'Last month';

  @override
  String get statisticThisYear => 'This year';

  @override
  String get statisticLastYear => 'Last year';

  @override
  String get statisticSmartInsightFallback =>
      'No standout spending insight yet for this period.';

  @override
  String statisticSmartInsightMessage(
    String periodLabel,
    String percent,
    String categoryLabel,
  ) {
    return 'This $periodLabel, you spent $percent% more on $categoryLabel than the previous $periodLabel. This category increased the most.';
  }

  @override
  String get statisticSpendingLimitLabel => 'Spending limit';

  @override
  String get statisticSpentLabel => 'Spent';

  @override
  String get statisticRemainingLabel => 'Remaining';

  @override
  String get statisticBudgetOnTrack => 'On track';

  @override
  String get statisticBudgetWarning => 'Needs attention';

  @override
  String get statisticBudgetExceeded => 'Limit exceeded';

  @override
  String get statisticBudgetNoLimitTitle => 'Set your monthly limit';

  @override
  String get statisticBudgetNoLimitDescription =>
      'Add a monthly limit to compare your budget against this period\'s spending.';

  @override
  String statisticSavedComparedToPrevious(String percent, String periodLabel) {
    return 'Saved $percent% compared to the previous $periodLabel';
  }

  @override
  String statisticSpentComparedToPrevious(String percent, String periodLabel) {
    return 'Spent $percent% more than the previous $periodLabel';
  }

  @override
  String statisticNoPreviousData(String periodLabel) {
    return 'No previous $periodLabel data';
  }

  @override
  String get statisticSpendingTrendTitle => 'Spending trend';

  @override
  String statisticCurrentPeriodTotal(String periodLabel) {
    return 'Total spent this $periodLabel';
  }

  @override
  String statisticComparedToPrevious(String periodLabel) {
    return 'Compared to previous $periodLabel';
  }

  @override
  String get statisticHigher => 'Higher';

  @override
  String get statisticLower => 'Lower';

  @override
  String get statisticStable => 'Stable';

  @override
  String get statisticTopCategoriesTitle => 'Top spending categories';

  @override
  String get statisticTopIncomeCategoriesTitle => 'Top income categories';

  @override
  String get statisticCategoryTransactionListTitle => 'Transaction List';

  @override
  String get statisticStrongestIncrease => 'Strongest increase';

  @override
  String get statisticStrongestDecrease => 'Biggest decrease';

  @override
  String get statisticNoCategoryChange => 'No category change yet';

  @override
  String get statisticSpendingAllocationTitle => 'Spending allocation';

  @override
  String get statisticTotalSpentShort => 'Total spent';

  @override
  String statisticTransactionCount(int count) {
    return '$count transactions';
  }

  @override
  String get statisticTrendIncrease => 'Biggest increase';

  @override
  String get statisticTopBadge => 'Top';

  @override
  String get statisticTrendDecrease => 'Decrease';

  @override
  String get statisticTrendStable => 'Stable';

  @override
  String get statisticNoDataTitle => 'No spending data yet';

  @override
  String get statisticNoDataDescription =>
      'Add transactions to see your spending trends and category insights.';

  @override
  String get statisticSelectPeriodTitle => 'Select period';

  @override
  String get scanBillNoAiAvailable =>
      'No AI available. Set up an API key or download the local AI model.';

  @override
  String get scanBillAiError =>
      'Unable to analyze the bill. Please try again or enter manually.';

  @override
  String get scanBillLoadingTitle => 'Processing Receipt';

  @override
  String get scanBillScanningStatus => 'Scanning receipt...';

  @override
  String get scanBillAnalyzingStatus => 'AI is analyzing...';

  @override
  String get joinFamilyTitle => 'Join Family';

  @override
  String get joinFamilySubtitle =>
      'Enter the 6-digit invite code from your parent';

  @override
  String get joinFamilyInputHint => 'Enter code';

  @override
  String get joinFamilyButton => 'Join Family';

  @override
  String get joinFamilySuccess => 'You have joined the family!';

  @override
  String get joinFamilyErrorInvalidCode => 'Invalid or expired invite code';

  @override
  String get joinFamilyErrorAlreadyMember => 'You are already part of a family';

  @override
  String get joinFamilyErrorUnknown => 'Failed to join. Please try again.';

  @override
  String get joinFamilyEyebrow => 'Connect Account';

  @override
  String get joinFamilyHeroTitle => 'Enter family code to get started';

  @override
  String get joinFamilyHeroSubtitle =>
      'Join your family group so parents can safely monitor transactions and manage your spending.';

  @override
  String get joinFamilyMiniCardTitle => 'Family Space';

  @override
  String get joinFamilyMiniCardDesc =>
      'Transparent transactions, easy to track';

  @override
  String get joinFamilyEnterCodeTitle => 'Enter 6-digit code';

  @override
  String get joinFamilyEnterCodeSubtitle =>
      'This code is sent to you by the parent or family creator.';

  @override
  String get joinFamilyCodeOnlyDigits => 'Only accepts a 6-digit numeric code';

  @override
  String get joinFamilyJoinNow => 'Join now';

  @override
  String get joinFamilyNoCode => 'Don\'t have a code?';

  @override
  String get unlinkFamilyTitle => 'My Family';

  @override
  String get unlinkFamilySubtitle => 'You are currently connected to a family';

  @override
  String get unlinkFamilyButton => 'Leave Family';

  @override
  String get unlinkFamilyConfirmTitle => 'Leave family?';

  @override
  String get unlinkFamilyConfirmBody =>
      'You will leave this family. You can rejoin later with an invite code.';

  @override
  String get unlinkFamilySuccess => 'You have left the family.';

  @override
  String get unlinkFamilyErrorFailed =>
      'Failed to leave family. Please try again.';

  @override
  String get familyMembersTitle => 'Family Members';

  @override
  String get familyStatusJoined => 'Currently Joined';

  @override
  String get familyLinkedSuccess => 'Linked Successfully';

  @override
  String get familyMemberListLabel => 'Members';

  @override
  String get familyMembersUnit => 'members';

  @override
  String get familyRoleParent => 'Parent';

  @override
  String get familyRoleChild => 'Child';

  @override
  String get familyRoleOwner => 'Family Owner';

  @override
  String get familyMemberYou => 'You';

  @override
  String get familyMemberActive => 'Active';

  @override
  String get unlinkFamilyButtonFull => 'Leave Family';

  @override
  String get customCategoryAdd => 'Add custom category';

  @override
  String get customCategoryAddSubtitle =>
      'Category will be added as expense type';

  @override
  String get customCategoryLabelHint => 'Category name';

  @override
  String get customCategoryTypeExpense => 'Expense';

  @override
  String get customCategoryTypeIncome => 'Income';

  @override
  String get customCategoryLimitReached =>
      'You can have at most 5 custom categories';

  @override
  String get customCategoryCreated => 'Category created';

  @override
  String get customCategoryCreateFailed =>
      'Could not create category. Please try again.';

  @override
  String get customCategoryDeleted => 'Category deleted';

  @override
  String get customCategoryConfirmDelete => 'Delete this category?';

  @override
  String get customCategoryConfirmDeleteBody =>
      'Transactions using this category will keep their existing label.';

  @override
  String get customCategoryCancel => 'Cancel';

  @override
  String get customCategoryConfirm => 'Add';

  @override
  String get customCategorySelectTitleExpense => 'Select expense category';

  @override
  String get customCategorySelectTitleIncome => 'Select income category';

  @override
  String get customCategorySelectTitle => 'Select category';

  @override
  String get customCategoryConfirmSelection => 'Done';

  @override
  String get customCategoryAddNew => 'Add new';

  @override
  String get customCategoryDelete => 'Delete';

  @override
  String get customCategoryIconHint => 'Pick an icon';

  @override
  String get customCategoryDropToDelete => 'Drop here to delete';

  @override
  String get customCategoryDeleteFailed => 'Could not delete category';

  @override
  String get setMoneyLimitManagedByParent =>
      'Spending limit is managed by parent';

  @override
  String get parentSetLimitTitle => 'Set monthly spending limit';

  @override
  String get parentSetLimitDescription =>
      'This limit helps your child stay in control of their spending each month';

  @override
  String get notifTitle => 'Notifications';

  @override
  String get notifMarkAllRead => 'Mark all as read';

  @override
  String get notifEmpty => 'No notifications yet';

  @override
  String get notifOverspend80Title => 'Approaching limit';

  @override
  String notifOverspend80Body(Object amount, Object month) {
    return 'You\'ve spent $amount — 80% of your $month limit.';
  }

  @override
  String get notifOverspend100Title => 'Limit exceeded';

  @override
  String notifOverspend100Body(Object amount, Object month) {
    return 'You\'ve spent $amount — exceeded your $month limit.';
  }

  @override
  String get notifWeeklyOverspendTitle => 'Spending spike';

  @override
  String notifWeeklyOverspendBody(Object percent) {
    return 'You spent $percent% more this week than last week.';
  }

  @override
  String notifParentOverspend80Body(Object childName, Object month) {
    return '$childName has spent 80% of the $month limit.';
  }

  @override
  String notifParentOverspend100Body(Object childName, Object month) {
    return '$childName has exceeded the $month limit.';
  }

  @override
  String notifParentWeeklyOverspendBody(Object childName, Object percent) {
    return '$childName spent $percent% more this week than last week.';
  }

  @override
  String get familyManagementTitle => 'Manage Family';

  @override
  String get familyManagementEmptyMessage => 'No family found';

  @override
  String get familyManagementErrorMessage => 'Error loading family data';

  @override
  String get familyManagementHostBadge => 'Host';

  @override
  String get familyManagementHostSubtitle => 'Host';

  @override
  String get familyManagementParentSubtitle => 'Family member';

  @override
  String get familyManagementInviteCodeLabel => 'Family invite code';

  @override
  String get familyManagementCopyTooltip => 'Copy';

  @override
  String get familyManagementCopySuccess => 'Invite code copied';

  @override
  String get familyManagementSectionMembers => 'MEMBERS';

  @override
  String get familyManagementChildrenSection => 'Children';

  @override
  String get familyManagementParentsSection => 'Parents';

  @override
  String get familyManagementHostParentLabel => '(Host Parent)';

  @override
  String get familyManagementNonHostParentLabel => '(Non-host Parent)';

  @override
  String get familyManagementSetLimit => 'Set limit';

  @override
  String get familyManagementUnlinkChild => 'Unlink';

  @override
  String get familyManagementUnlinkParent => 'Unlink';

  @override
  String get familyManagementNoLimit => 'No limit';

  @override
  String get familyManagementEmptyChildren => 'No members yet';

  @override
  String get familyManagementUnlinkButton => 'Unlink';

  @override
  String get familyManagementSetLimitButton => 'Set Limit';

  @override
  String get familyManagementRemoveLimitButton => 'Remove Limit';

  @override
  String get familyManagementLimitDialogTitle => 'Set spending limit';

  @override
  String get familyManagementLimitInputHint => '0';

  @override
  String get familyManagementRemoveLimit => 'Remove limit';

  @override
  String get familyManagementSave => 'Save';

  @override
  String get familyManagementCancel => 'Cancel';

  @override
  String get familyManagementUnlinkConfirmTitle => 'Unlink member?';

  @override
  String familyManagementUnlinkConfirmBody(Object name) {
    return 'Are you sure you want to unlink $name?';
  }

  @override
  String get familyManagementUnlinkConfirmButton => 'Unlink';

  @override
  String get familyManagementConfirmUnlinkChildTitle => 'Confirm Unlink';

  @override
  String familyManagementConfirmUnlinkChildMessage(Object childName) {
    return 'Are you sure you want to unlink $childName?';
  }

  @override
  String get familyManagementConfirmUnlinkParentTitle => 'Confirm Unlink';

  @override
  String familyManagementConfirmUnlinkParentMessage(Object parentName) {
    return 'Are you sure you want to unlink $parentName?';
  }

  @override
  String get familyManagementLimitSetSuccess => 'Spending limit updated';

  @override
  String get familyManagementLimitRemovedSuccess => 'Spending limit removed';

  @override
  String get familyManagementUnlinkSuccess => 'Unlinked successfully';

  @override
  String get familyManagementUnlinkError => 'Error unlinking';

  @override
  String get familyManagementSetLimitSuccess => 'Limit set successfully';

  @override
  String get familyManagementSetLimitError => 'Error setting limit';

  @override
  String get familyManagementRemoveLimitSuccess => 'Limit removed successfully';

  @override
  String get familyManagementRemoveLimitError => 'Error removing limit';

  @override
  String get familyManagementBannerTitle => 'Building a future together';

  @override
  String get familyManagementBannerSubtitle =>
      'Teach your children to manage money wisely from today.';

  @override
  String get familyManagementSectionFamily => 'YOUR FAMILY';

  @override
  String familyManagementFamilyName(Object host) {
    return '$host\'s family';
  }

  @override
  String get familyManagementFamilyCardSubtitle => 'Host family • Owner';

  @override
  String familyManagementSectionMembersCount(int count) {
    return 'FAMILY MEMBERS ($count)';
  }

  @override
  String get familyManagementRoleHost => 'Parent • Host';

  @override
  String get familyManagementRoleParent => 'Parent';

  @override
  String get familyManagementRoleChild => 'Child';

  @override
  String get familyManagementYouSuffix => ' (You)';

  @override
  String familyManagementUnlinkSheetTitle(Object name) {
    return 'Unlink $name';
  }

  @override
  String familyManagementUnlinkSheetDesc(Object name) {
    return 'Are you sure you want to unlink $name from the family?';
  }

  @override
  String get familyManagementUnlinkSheetConfirm => 'Confirm';

  @override
  String get familyManagementUnlinkSheetCancel => 'Cancel';

  @override
  String get notificationSettingsTitle => 'Notifications';

  @override
  String get notificationSettingsDailySection => 'DAILY NOTIFICATIONS';

  @override
  String get notificationSettingsEnableLabel => 'Enable notifications';

  @override
  String get notificationSettingsTimeLabel => 'Notification time';

  @override
  String get notificationSettingsAboutSection => 'ABOUT NOTIFICATIONS';

  @override
  String get notificationSettingsDescription =>
      'Notifications will remind you to check your spending every day at the selected time. This helps you maintain better financial management habits.';

  @override
  String get settingNotificationsLabel => 'Notifications';

  @override
  String get scheduleNotificationSmartTitle => 'Save 15% more effectively';

  @override
  String get scheduleNotificationSmartSubtitle =>
      'Based on the habits of 500 other users';

  @override
  String get notificationSettingsEyebrow => 'Track spending';

  @override
  String get notificationSettingsHeroTitle =>
      'Enable notifications to stay on top of your child\'s transactions';

  @override
  String get notificationSettingsHeroSubtitle =>
      'Get instant alerts when new spending occurs, at the time you choose to stay informed — so managing finances feels effortless.';

  @override
  String get notificationSettingsEnableHint =>
      'Notify when your child makes payments, transfers, or balance changes.';

  @override
  String get notificationSettingsScheduleSection => 'Notification schedule';

  @override
  String get notificationSettingsScheduleNote => 'Can be changed';

  @override
  String get notificationSettingsTimeHint =>
      'The app will prioritize sending notifications during this time window to avoid interruptions during rest hours.';

  @override
  String get notificationSettingsInstructionTitle =>
      'Notifications help parents track spending in time';

  @override
  String get notificationSettingsInstructionDesc =>
      'When you enable this feature, you will receive alerts whenever a new transaction occurs or your child\'s balance changes unusually.';

  @override
  String get notificationSettingsTip1 =>
      'Tap Allow when the system asks for notification permission so everything works properly.';

  @override
  String get notificationSettingsTip2 =>
      'Choose a suitable time to avoid evening interruptions while still catching important transactions.';

  @override
  String get notificationSettingsTip3 =>
      'You will still receive instant alerts for transactions that need attention, such as over-limit spending or unusual payments.';

  @override
  String get onboardingWelcomeTitle => 'Family finances\nat your fingertips';

  @override
  String get onboardingWelcomeSubtitle =>
      'The smart app connecting parents and children, building healthy spending habits from today.';

  @override
  String get onboardingWelcomeFeature1Title => 'Smart management';

  @override
  String get onboardingWelcomeFeature1Desc =>
      'Track income and expenses, set spending limits and monitor budgets visually.';

  @override
  String get onboardingWelcomeFeature2Title => 'AI receipt scanning';

  @override
  String get onboardingWelcomeFeature2Desc =>
      'Automatic super-fast data entry with just a single screenshot.';

  @override
  String get onboardingWelcomeFeature3Title => 'Grow with your child';

  @override
  String get onboardingWelcomeFeature3Desc =>
      'Teach the value of money and encourage daily savings.';

  @override
  String get onboardingWelcomeStartBtn => 'Get started with MoniKid';

  @override
  String get validationEmailEmpty => 'Please enter your email';

  @override
  String get validationEmailInvalid => 'Invalid email address';

  @override
  String get validationPasswordEmpty => 'Please enter your password';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 6 characters';

  @override
  String get validationPasswordTooLong =>
      'Password must be 128 characters or fewer';

  @override
  String get validationUsernameEmpty => 'Please enter your name';

  @override
  String get validationUsernameTooShort => 'Name must be at least 2 characters';

  @override
  String get validationUsernameTooLong => 'Name must be 50 characters or fewer';

  @override
  String get validationPhoneInvalid => 'Invalid phone number';

  @override
  String get validationConfirmPasswordEmpty => 'Please confirm your password';

  @override
  String get validationConfirmPasswordMismatch => 'Passwords do not match';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordDescription =>
      'Don\'t worry! Enter your registered email and we\'ll send a reset link to help you change your password.';

  @override
  String get forgotPasswordEmailPlaceholder => 'Enter your email';

  @override
  String get forgotPasswordSubmitBtn => 'Get reset link';

  @override
  String get forgotPasswordBackToLogin => 'Back to Login';

  @override
  String get forgotPasswordEmailSentTitle => 'Email sent!';

  @override
  String forgotPasswordEmailSentMessage(String email) {
    return 'We sent a password reset link to\n$email\n\nPlease check your inbox and click the link to change your password.';
  }

  @override
  String get forgotPasswordEmailSentBtn => 'Back to Login';

  @override
  String get forgotPasswordEmailHint =>
      'The verification code will be sent to your email. Please check both your inbox and spam folder.';

  @override
  String get forgotPasswordChipLabel => 'Send verification code';

  @override
  String get forgotPasswordRememberPassword => 'Remember your password?';

  @override
  String get forgotPasswordLoginAction => 'Log in';

  @override
  String get txStatusSuccess => 'Success';

  @override
  String get txStatusCompleted => 'Completed';

  @override
  String get dateToday => 'Today';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String get transactionViewAllCategories => 'View all';

  @override
  String get transactionDetailsSection => 'Details';

  @override
  String get transactionReceiptLabel => 'Receipt photo';

  @override
  String get transactionAddPhoto => 'Add photo';

  @override
  String get transactionChangePhoto => 'Change photo';

  @override
  String get transactionReceiptEmptyTitle => 'Receipt will appear here';

  @override
  String get faqCommonQuestions => 'Frequently Asked Questions';

  @override
  String get transactionReceiptScanHint => 'System will scan automatically';

  @override
  String get transactionDateToday => 'Today';

  @override
  String get successDialogDefaultTitle => 'Success!';

  @override
  String get successDialogDefaultMessage => 'Operation completed.';

  @override
  String get successDialogDefaultButton => 'OK';

  @override
  String get transactionHistoryEyebrow => 'Spending management';

  @override
  String get transactionHistoryTitle => 'Transaction history';

  @override
  String get transactionHistorySubhead =>
      'All your income and expenses over time.';

  @override
  String get splashStatusLoading => 'Setting up wallet...';

  @override
  String get notifChildDailyTitle => 'Spending report today';

  @override
  String notifChildDailyBody(int pct, String expense, String month) {
    return 'You have $pct% of your limit left, you spent $expense in $month';
  }

  @override
  String notifChildNoLimitBody(String expense, String month) {
    return 'You spent $expense in $month';
  }

  @override
  String get notifParentDailyTitle => 'Family spending report';

  @override
  String notifParentChildBody(String name, int pct, String expense) {
    return 'Your child $name has $pct% of limit left, spent $expense';
  }

  @override
  String get notifScheduleError =>
      'Cannot schedule notification. Please try again.';
}

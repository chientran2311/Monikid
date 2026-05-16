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
  String get onboardingCurrencyTitle => 'Choose currency';

  @override
  String get onboardingCurrencyDescription =>
      'Please choose the currency you want to use to manage transactions in the app.';

  @override
  String get onboardingCurrencyVnd => 'Vietnamese Dong (VND)';

  @override
  String get onboardingCurrencyUsd => 'US Dollar (USD)';

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
  String get homeParNoFamilyTitle => 'No family members yet';

  @override
  String get homeParNoFamilySubtitle =>
      'Create a family to start tracking your child\'s spending';

  @override
  String get homeParCreateFamilyBtn => 'Create Family';

  @override
  String get homeParInviteTitle => 'Add New Member';

  @override
  String get homeParInviteCodeLabel => 'Link Code';

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
  String get profileEditTitle => 'Edit Profile';

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
  String get setMoneyLimitTitle => 'Set monthly limit';

  @override
  String get setMoneyLimitDescription =>
      'This limit helps you stay in control of your spending every month.';

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
  String get statisticWeekNoun => 'week';

  @override
  String get statisticMonthNoun => 'month';

  @override
  String get statisticThisWeek => 'This week';

  @override
  String get statisticLastWeek => 'Last week';

  @override
  String get statisticThisMonth => 'This month';

  @override
  String get statisticLastMonth => 'Last month';

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
  String get customCategoryAdd => 'Add custom category';

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
  String get customCategoryConfirmSelection => 'Confirm';

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
}

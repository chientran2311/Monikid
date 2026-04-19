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
  String get validationEmptyFields => 'Please fill in all fields (Name, Email, Password)';

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
  String get helpContactSupportDesc => 'If you cannot find the answer, contact our support team 24/7.';

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
  String get addTransactionFailed => 'Unable to add transaction. Please try again.';

  @override
  String get updateTransactionFailed => 'Unable to update transaction. Please try again.';

  @override
  String get updateTransactionMissingError => 'Missing transaction to update.';

  @override
  String get transactionLoadError => 'Unable to load transaction.';

  @override
  String get transactionCategoryLoadError => 'Unable to load categories. Please try again.';

  @override
  String get transactionUserNotAuthenticated => 'User is not authenticated.';

  @override
  String get transactionAmountLabel => 'Amount';

  @override
  String get transactionCategoryLabel => 'Category';

  @override
  String get transactionDateLabel => 'Date';

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
  String get addTransactionNoteHint => 'Enter a note, AI will categorize it automatically...';

  @override
  String get updateTransactionTitle => 'Edit transaction';

  @override
  String get updateTransactionAction => 'Update transaction';

  @override
  String get updateTransactionNoteHint => 'Add a note...';

  @override
  String get updateTransactionWalletLabel => 'Source wallet';

  @override
  String get updateTransactionCashWalletValue => 'Cash';

  @override
  String get transactionDetailTitle => 'Transaction details';

  @override
  String get transactionDetailNoData => 'No transaction data available.';

  @override
  String get transactionDetailTimeLabel => 'TIME';

  @override
  String get transactionDetailSourceLabel => 'SOURCE';

  @override
  String get transactionDetailNoteLabel => 'NOTE';

  @override
  String get transactionEditAction => 'Edit transaction';

  @override
  String get transactionDeleteAction => 'Delete transaction';

  @override
  String get transactionEvidenceSectionTitle => 'Evidence image';

  @override
  String get transactionEvidenceOptionalLabel => 'Optional. Add one proof image for this transaction.';

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
  String get transactionEvidenceLoadError => 'Unable to load the evidence image.';

  @override
  String get transactionEvidenceUploadTimeout => 'Image upload timed out. Please try again.';

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
  String get profileEditEmailWarning => 'Email cannot be changed for security reasons.';

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
  String get pinCreateDescription => 'Create a 6-digit PIN to protect your account.';

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
  String get homeStudentLoadError => 'Unable to load the home dashboard. Please try again.';

  @override
  String get homeStudentAddTransaction => 'Add transaction';

  @override
  String get homeStudentSetMonthlyLimit => 'Set limit';

  @override
  String get homeStudentMonthlyLimitNotSet => 'Set your monthly limit';

  @override
  String get setMoneyLimitTitle => 'Set monthly limit';

  @override
  String get setMoneyLimitDescription => 'This limit helps you stay in control of your spending every month.';

  @override
  String get setMoneyLimitSkipAction => 'Skip';

  @override
  String get setMoneyLimitUnauthenticated => 'Please sign in again to set a monthly limit.';

  @override
  String get setMoneyLimitSaveFailed => 'Unable to save the monthly limit. Please try again.';

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
  String get statisticSmartInsightFallback => 'No standout spending insight yet for this period.';

  @override
  String statisticSmartInsightMessage(String periodLabel, String percent, String categoryLabel) {
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
  String get statisticBudgetNoLimitDescription => 'Add a monthly limit to compare your budget against this period\'s spending.';

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
  String get statisticNoDataDescription => 'Add transactions to see your spending trends and category insights.';

  @override
  String get statisticSelectPeriodTitle => 'Select period';
}

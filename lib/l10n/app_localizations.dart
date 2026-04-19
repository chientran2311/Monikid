import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @validationEmptyFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields (Name, Email, Password)'**
  String get validationEmptyFields;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed: {error}'**
  String registerFailed(String error);

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet.'**
  String get noTransactionsYet;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(String error);

  /// No description provided for @settingFQA.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get settingFQA;

  /// No description provided for @msgNoData.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get msgNoData;

  /// No description provided for @helpStillNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Still need help?'**
  String get helpStillNeedHelp;

  /// No description provided for @helpContactSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'If you cannot find the answer, contact our support team 24/7.'**
  String get helpContactSupportDesc;

  /// No description provided for @actionChatWithUs.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get actionChatWithUs;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @validationEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get validationEnterAmount;

  /// No description provided for @validationAmountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 0'**
  String get validationAmountGreaterThanZero;

  /// No description provided for @msgAddTransactionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction added successfully!'**
  String get msgAddTransactionSuccess;

  /// No description provided for @msgTransactionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted'**
  String get msgTransactionDeleted;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @validationInvalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get validationInvalidAmount;

  /// No description provided for @msgUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update successful'**
  String get msgUpdateSuccess;

  /// No description provided for @addTransactionFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to add transaction. Please try again.'**
  String get addTransactionFailed;

  /// No description provided for @updateTransactionFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to update transaction. Please try again.'**
  String get updateTransactionFailed;

  /// No description provided for @updateTransactionMissingError.
  ///
  /// In en, this message translates to:
  /// **'Missing transaction to update.'**
  String get updateTransactionMissingError;

  /// No description provided for @transactionLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load transaction.'**
  String get transactionLoadError;

  /// No description provided for @transactionCategoryLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load categories. Please try again.'**
  String get transactionCategoryLoadError;

  /// No description provided for @transactionUserNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User is not authenticated.'**
  String get transactionUserNotAuthenticated;

  /// No description provided for @transactionAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get transactionAmountLabel;

  /// No description provided for @transactionCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get transactionCategoryLabel;

  /// No description provided for @transactionDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transactionDateLabel;

  /// No description provided for @transactionNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get transactionNoteLabel;

  /// No description provided for @transactionExpenseType.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get transactionExpenseType;

  /// No description provided for @transactionIncomeType.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get transactionIncomeType;

  /// No description provided for @transactionSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Save transaction'**
  String get transactionSaveAction;

  /// No description provided for @transactionAiAutoLabel.
  ///
  /// In en, this message translates to:
  /// **'AI auto'**
  String get transactionAiAutoLabel;

  /// No description provided for @addTransactionNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a note, AI will categorize it automatically...'**
  String get addTransactionNoteHint;

  /// No description provided for @updateTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit transaction'**
  String get updateTransactionTitle;

  /// No description provided for @updateTransactionAction.
  ///
  /// In en, this message translates to:
  /// **'Update transaction'**
  String get updateTransactionAction;

  /// No description provided for @updateTransactionNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note...'**
  String get updateTransactionNoteHint;

  /// No description provided for @updateTransactionWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'Source wallet'**
  String get updateTransactionWalletLabel;

  /// No description provided for @updateTransactionCashWalletValue.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get updateTransactionCashWalletValue;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditAvatarLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Avatar'**
  String get profileEditAvatarLabel;

  /// No description provided for @profileEditFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileEditFullName;

  /// No description provided for @profileEditFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get profileEditFullNameHint;

  /// No description provided for @profileEditPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profileEditPhone;

  /// No description provided for @profileEditPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get profileEditPhoneHint;

  /// No description provided for @profileEditEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEditEmail;

  /// No description provided for @profileEditEmailWarning.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be changed for security reasons.'**
  String get profileEditEmailWarning;

  /// No description provided for @profileEditDob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileEditDob;

  /// No description provided for @profileEditDobHint.
  ///
  /// In en, this message translates to:
  /// **'DD/MM/YYYY'**
  String get profileEditDobHint;

  /// No description provided for @actionSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get actionSaveChanges;

  /// No description provided for @editRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Request'**
  String get editRequestTitle;

  /// No description provided for @requestAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Requested Amount'**
  String get requestAmountLabel;

  /// No description provided for @requestReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get requestReasonLabel;

  /// No description provided for @categoryBooks.
  ///
  /// In en, this message translates to:
  /// **'Buy books/notebooks'**
  String get categoryBooks;

  /// No description provided for @categorySnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get categorySnacks;

  /// No description provided for @categoryGames.
  ///
  /// In en, this message translates to:
  /// **'Top up games'**
  String get categoryGames;

  /// No description provided for @categoryGifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get categoryGifts;

  /// No description provided for @additionalNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional Note'**
  String get additionalNoteLabel;

  /// No description provided for @whatDoYouNeedToBuyHint.
  ///
  /// In en, this message translates to:
  /// **'What do you need to buy?'**
  String get whatDoYouNeedToBuyHint;

  /// No description provided for @requestRecipientLabel.
  ///
  /// In en, this message translates to:
  /// **'Recipients'**
  String get requestRecipientLabel;

  /// No description provided for @recipientDad.
  ///
  /// In en, this message translates to:
  /// **'Dad'**
  String get recipientDad;

  /// No description provided for @recipientMom.
  ///
  /// In en, this message translates to:
  /// **'Mom'**
  String get recipientMom;

  /// No description provided for @actionUpdateRequest.
  ///
  /// In en, this message translates to:
  /// **'Update Request'**
  String get actionUpdateRequest;

  /// No description provided for @actionDeleteRequest.
  ///
  /// In en, this message translates to:
  /// **'Delete Request'**
  String get actionDeleteRequest;

  /// No description provided for @scanbill.
  ///
  /// In en, this message translates to:
  /// **'Scan Bill'**
  String get scanbill;

  /// No description provided for @chatting.
  ///
  /// In en, this message translates to:
  /// **'Family Chat'**
  String get chatting;

  /// No description provided for @requestmoney.
  ///
  /// In en, this message translates to:
  /// **'Request Money'**
  String get requestmoney;

  /// No description provided for @takePicture.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePicture;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @scanReceiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Receipt'**
  String get scanReceiptTitle;

  /// No description provided for @scanReceiptDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose how to add receipt image to process.'**
  String get scanReceiptDesc;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authPasswordPlaceholder;

  /// No description provided for @authSignUpAction.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get authSignUpAction;

  /// No description provided for @authSignInAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInAction;

  /// No description provided for @authNoAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get authNoAccountPrompt;

  /// No description provided for @authHaveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authHaveAccountPrompt;

  /// No description provided for @pinCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new PIN'**
  String get pinCreateTitle;

  /// No description provided for @pinCreateDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a 6-digit PIN to protect your account.'**
  String get pinCreateDescription;

  /// No description provided for @pinReEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get pinReEnterTitle;

  /// No description provided for @pinReEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your new PIN again to confirm it.'**
  String get pinReEnterDescription;

  /// No description provided for @pinEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get pinEnterTitle;

  /// No description provided for @pinEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your 6-digit PIN to continue.'**
  String get pinEnterDescription;

  /// No description provided for @pinMismatchError.
  ///
  /// In en, this message translates to:
  /// **'The PIN confirmation does not match.'**
  String get pinMismatchError;

  /// No description provided for @pinIncorrectError.
  ///
  /// In en, this message translates to:
  /// **'The PIN you entered is incorrect.'**
  String get pinIncorrectError;

  /// No description provided for @pinLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Too many incorrect attempts. Try again in {seconds}s.'**
  String pinLockedMessage(int seconds);

  /// No description provided for @pinGenericError.
  ///
  /// In en, this message translates to:
  /// **'A PIN error occurred. Please try again.'**
  String get pinGenericError;

  /// No description provided for @pinGatewayLoading.
  ///
  /// In en, this message translates to:
  /// **'Checking your PIN security...'**
  String get pinGatewayLoading;

  /// No description provided for @pinGatewayError.
  ///
  /// In en, this message translates to:
  /// **'Unable to start the PIN verification flow.'**
  String get pinGatewayError;

  /// No description provided for @homeStudentGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get homeStudentGreeting;

  /// No description provided for @homeStudentDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get homeStudentDefaultName;

  /// No description provided for @homeStudentMonthlySummaryTitleWithMonth.
  ///
  /// In en, this message translates to:
  /// **'Overview for {monthLabel}'**
  String homeStudentMonthlySummaryTitleWithMonth(String monthLabel);

  /// No description provided for @homeStudentMonthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get homeStudentMonthlyIncome;

  /// No description provided for @homeStudentMonthlyExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get homeStudentMonthlyExpense;

  /// No description provided for @homeStudentRemainingBudget.
  ///
  /// In en, this message translates to:
  /// **'Remaining budget'**
  String get homeStudentRemainingBudget;

  /// No description provided for @homeStudentRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent transactions'**
  String get homeStudentRecentTransactions;

  /// No description provided for @homeStudentViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeStudentViewAll;

  /// No description provided for @homeStudentLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the home dashboard. Please try again.'**
  String get homeStudentLoadError;

  /// No description provided for @homeStudentAddTransaction.
  ///
  /// In en, this message translates to:
  /// **'Add transaction'**
  String get homeStudentAddTransaction;

  /// No description provided for @homeStudentSetMonthlyLimit.
  ///
  /// In en, this message translates to:
  /// **'Set limit'**
  String get homeStudentSetMonthlyLimit;

  /// No description provided for @homeStudentMonthlyLimitNotSet.
  ///
  /// In en, this message translates to:
  /// **'Set your monthly limit'**
  String get homeStudentMonthlyLimitNotSet;

  /// No description provided for @setMoneyLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Set monthly limit'**
  String get setMoneyLimitTitle;

  /// No description provided for @setMoneyLimitDescription.
  ///
  /// In en, this message translates to:
  /// **'This limit helps you stay in control of your spending every month.'**
  String get setMoneyLimitDescription;

  /// No description provided for @setMoneyLimitSkipAction.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get setMoneyLimitSkipAction;

  /// No description provided for @setMoneyLimitUnauthenticated.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again to set a monthly limit.'**
  String get setMoneyLimitUnauthenticated;

  /// No description provided for @setMoneyLimitSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to save the monthly limit. Please try again.'**
  String get setMoneyLimitSaveFailed;

  /// No description provided for @setMoneyLimitQuickAmount.
  ///
  /// In en, this message translates to:
  /// **'+{millionCount},000,000đ'**
  String setMoneyLimitQuickAmount(int millionCount);

  /// No description provided for @statisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending statistics'**
  String get statisticTitle;

  /// No description provided for @statisticByWeek.
  ///
  /// In en, this message translates to:
  /// **'By week'**
  String get statisticByWeek;

  /// No description provided for @statisticByMonth.
  ///
  /// In en, this message translates to:
  /// **'By month'**
  String get statisticByMonth;

  /// No description provided for @statisticWeekNoun.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get statisticWeekNoun;

  /// No description provided for @statisticMonthNoun.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get statisticMonthNoun;

  /// No description provided for @statisticThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get statisticThisWeek;

  /// No description provided for @statisticLastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last week'**
  String get statisticLastWeek;

  /// No description provided for @statisticThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get statisticThisMonth;

  /// No description provided for @statisticLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get statisticLastMonth;

  /// No description provided for @statisticSmartInsightFallback.
  ///
  /// In en, this message translates to:
  /// **'No standout spending insight yet for this period.'**
  String get statisticSmartInsightFallback;

  /// No description provided for @statisticSmartInsightMessage.
  ///
  /// In en, this message translates to:
  /// **'This {periodLabel}, you spent {percent}% more on {categoryLabel} than the previous {periodLabel}. This category increased the most.'**
  String statisticSmartInsightMessage(String periodLabel, String percent, String categoryLabel);

  /// No description provided for @statisticSpendingLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Spending limit'**
  String get statisticSpendingLimitLabel;

  /// No description provided for @statisticSpentLabel.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get statisticSpentLabel;

  /// No description provided for @statisticRemainingLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get statisticRemainingLabel;

  /// No description provided for @statisticBudgetOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get statisticBudgetOnTrack;

  /// No description provided for @statisticBudgetWarning.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get statisticBudgetWarning;

  /// No description provided for @statisticBudgetExceeded.
  ///
  /// In en, this message translates to:
  /// **'Limit exceeded'**
  String get statisticBudgetExceeded;

  /// No description provided for @statisticBudgetNoLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your monthly limit'**
  String get statisticBudgetNoLimitTitle;

  /// No description provided for @statisticBudgetNoLimitDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a monthly limit to compare your budget against this period\'s spending.'**
  String get statisticBudgetNoLimitDescription;

  /// No description provided for @statisticSavedComparedToPrevious.
  ///
  /// In en, this message translates to:
  /// **'Saved {percent}% compared to the previous {periodLabel}'**
  String statisticSavedComparedToPrevious(String percent, String periodLabel);

  /// No description provided for @statisticSpentComparedToPrevious.
  ///
  /// In en, this message translates to:
  /// **'Spent {percent}% more than the previous {periodLabel}'**
  String statisticSpentComparedToPrevious(String percent, String periodLabel);

  /// No description provided for @statisticNoPreviousData.
  ///
  /// In en, this message translates to:
  /// **'No previous {periodLabel} data'**
  String statisticNoPreviousData(String periodLabel);

  /// No description provided for @statisticSpendingTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending trend'**
  String get statisticSpendingTrendTitle;

  /// No description provided for @statisticCurrentPeriodTotal.
  ///
  /// In en, this message translates to:
  /// **'Total spent this {periodLabel}'**
  String statisticCurrentPeriodTotal(String periodLabel);

  /// No description provided for @statisticComparedToPrevious.
  ///
  /// In en, this message translates to:
  /// **'Compared to previous {periodLabel}'**
  String statisticComparedToPrevious(String periodLabel);

  /// No description provided for @statisticHigher.
  ///
  /// In en, this message translates to:
  /// **'Higher'**
  String get statisticHigher;

  /// No description provided for @statisticLower.
  ///
  /// In en, this message translates to:
  /// **'Lower'**
  String get statisticLower;

  /// No description provided for @statisticStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get statisticStable;

  /// No description provided for @statisticTopCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Top spending categories'**
  String get statisticTopCategoriesTitle;

  /// No description provided for @statisticStrongestIncrease.
  ///
  /// In en, this message translates to:
  /// **'Strongest increase'**
  String get statisticStrongestIncrease;

  /// No description provided for @statisticStrongestDecrease.
  ///
  /// In en, this message translates to:
  /// **'Biggest decrease'**
  String get statisticStrongestDecrease;

  /// No description provided for @statisticNoCategoryChange.
  ///
  /// In en, this message translates to:
  /// **'No category change yet'**
  String get statisticNoCategoryChange;

  /// No description provided for @statisticSpendingAllocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending allocation'**
  String get statisticSpendingAllocationTitle;

  /// No description provided for @statisticTotalSpentShort.
  ///
  /// In en, this message translates to:
  /// **'Total spent'**
  String get statisticTotalSpentShort;

  /// No description provided for @statisticTransactionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} transactions'**
  String statisticTransactionCount(int count);

  /// No description provided for @statisticTrendIncrease.
  ///
  /// In en, this message translates to:
  /// **'Biggest increase'**
  String get statisticTrendIncrease;

  /// No description provided for @statisticTrendDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get statisticTrendDecrease;

  /// No description provided for @statisticTrendStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get statisticTrendStable;

  /// No description provided for @statisticNoDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No spending data yet'**
  String get statisticNoDataTitle;

  /// No description provided for @statisticNoDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Add transactions to see your spending trends and category insights.'**
  String get statisticNoDataDescription;

  /// No description provided for @statisticSelectPeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'Select period'**
  String get statisticSelectPeriodTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

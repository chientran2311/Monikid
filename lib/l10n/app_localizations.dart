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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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

  /// No description provided for @languageVietnameseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display the entire app in Vietnamese'**
  String get languageVietnameseSubtitle;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use English across the app interface'**
  String get languageEnglishSubtitle;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @onboardingLanguageTitleLeading.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get onboardingLanguageTitleLeading;

  /// No description provided for @onboardingLanguageTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get onboardingLanguageTitleHighlight;

  /// No description provided for @onboardingLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Please choose the language you want to use in the app.'**
  String get onboardingLanguageDescription;

  /// No description provided for @onboardingContinueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinueAction;

  /// No description provided for @onboardingLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in settings.'**
  String get onboardingLanguageSubtitle;

  /// No description provided for @onboardingLanguageCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Display language'**
  String get onboardingLanguageCardTitle;

  /// No description provided for @onboardingLanguageCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Monikid will use this language for lessons and notifications.'**
  String get onboardingLanguageCardDesc;

  /// No description provided for @onboardingLanguageViDesc.
  ///
  /// In en, this message translates to:
  /// **'For users in Vietnam'**
  String get onboardingLanguageViDesc;

  /// No description provided for @onboardingLanguageEnDesc.
  ///
  /// In en, this message translates to:
  /// **'For bilingual learners and parents'**
  String get onboardingLanguageEnDesc;

  /// No description provided for @onboardingLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Next step: Monikid will ask for notification permission to remind you of schedules and important updates.'**
  String get onboardingLanguageHint;

  /// No description provided for @onboardingSkipLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get onboardingSkipLater;

  /// No description provided for @onboardingNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications to track spending on time'**
  String get onboardingNotificationTitle;

  /// No description provided for @onboardingNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monikid will send updates when there are new transactions, balance changes, and important spending activities so parents always stay informed.'**
  String get onboardingNotificationSubtitle;

  /// No description provided for @onboardingNotificationBenefitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Benefits of enabling notifications'**
  String get onboardingNotificationBenefitsTitle;

  /// No description provided for @onboardingNotificationBenefitsDesc.
  ///
  /// In en, this message translates to:
  /// **'Only useful updates to help parents manage spending more easily every day.'**
  String get onboardingNotificationBenefitsDesc;

  /// No description provided for @onboardingNotificationEnableBtn.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get onboardingNotificationEnableBtn;

  /// No description provided for @onboardingNotificationBenefit1Title.
  ///
  /// In en, this message translates to:
  /// **'Know instantly about new transactions'**
  String get onboardingNotificationBenefit1Title;

  /// No description provided for @onboardingNotificationBenefit1Desc.
  ///
  /// In en, this message translates to:
  /// **'Track your child\'s spending almost immediately after it happens.'**
  String get onboardingNotificationBenefit1Desc;

  /// No description provided for @onboardingNotificationBenefit2Title.
  ///
  /// In en, this message translates to:
  /// **'Get alerts when balance changes'**
  String get onboardingNotificationBenefit2Title;

  /// No description provided for @onboardingNotificationBenefit2Desc.
  ///
  /// In en, this message translates to:
  /// **'Helps control budget and detect notable fluctuations.'**
  String get onboardingNotificationBenefit2Desc;

  /// No description provided for @onboardingNotificationBenefit3Title.
  ///
  /// In en, this message translates to:
  /// **'Parents always stay informed'**
  String get onboardingNotificationBenefit3Title;

  /// No description provided for @onboardingNotificationBenefit3Desc.
  ///
  /// In en, this message translates to:
  /// **'Support your child in learning how to manage money wisely.'**
  String get onboardingNotificationBenefit3Desc;

  /// No description provided for @onboardingNotificationSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'\"Monikid\" wants to send you notifications'**
  String get onboardingNotificationSheetTitle;

  /// No description provided for @onboardingNotificationSheetDesc.
  ///
  /// In en, this message translates to:
  /// **'Notifications may include new transactions, balance changes, and important spending updates.'**
  String get onboardingNotificationSheetDesc;

  /// No description provided for @onboardingNotificationSheetRowTitle.
  ///
  /// In en, this message translates to:
  /// **'Track transactions on time'**
  String get onboardingNotificationSheetRowTitle;

  /// No description provided for @onboardingNotificationSheetRowDesc.
  ///
  /// In en, this message translates to:
  /// **'Helps parents know about their child\'s spending faster.'**
  String get onboardingNotificationSheetRowDesc;

  /// No description provided for @onboardingNotificationSheetDeny.
  ///
  /// In en, this message translates to:
  /// **'Don\'t allow'**
  String get onboardingNotificationSheetDeny;

  /// No description provided for @onboardingNotificationSheetAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get onboardingNotificationSheetAllow;

  /// No description provided for @onboardingNotificationMiniAmount.
  ///
  /// In en, this message translates to:
  /// **'-120.000đ'**
  String get onboardingNotificationMiniAmount;

  /// No description provided for @onboardingNotificationMiniMeta.
  ///
  /// In en, this message translates to:
  /// **'Buy books • 2 minutes ago'**
  String get onboardingNotificationMiniMeta;

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

  /// No description provided for @navChildHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navChildHome;

  /// No description provided for @navChildTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get navChildTransactions;

  /// No description provided for @navChildStatistic.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get navChildStatistic;

  /// No description provided for @navChildSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navChildSettings;

  /// No description provided for @homeParFamilyMembersLabel.
  ///
  /// In en, this message translates to:
  /// **'Family Members'**
  String get homeParFamilyMembersLabel;

  /// No description provided for @homeParNoFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Start your journey'**
  String get homeParNoFamilyTitle;

  /// No description provided for @homeParNoFamilySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to MoniKid. Add your first member to start managing family spending.'**
  String get homeParNoFamilySubtitle;

  /// No description provided for @homeParCreateFamilyBtn.
  ///
  /// In en, this message translates to:
  /// **'Create Family'**
  String get homeParCreateFamilyBtn;

  /// No description provided for @homeParNoFamilyHintSafe.
  ///
  /// In en, this message translates to:
  /// **'Safe management for your kids'**
  String get homeParNoFamilyHintSafe;

  /// No description provided for @homeParNoFamilyHintChart.
  ///
  /// In en, this message translates to:
  /// **'Track spending charts'**
  String get homeParNoFamilyHintChart;

  /// No description provided for @homeParErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get homeParErrorTitle;

  /// No description provided for @homeParErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your home. Please try again.'**
  String get homeParErrorDesc;

  /// No description provided for @homeParInviteTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite Member'**
  String get homeParInviteTitle;

  /// No description provided for @homeParInviteDesc.
  ///
  /// In en, this message translates to:
  /// **'Share this code with your child or family member to join your MoniKid family.'**
  String get homeParInviteDesc;

  /// No description provided for @homeParInviteCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Link Code'**
  String get homeParInviteCodeLabel;

  /// No description provided for @homeParCopyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy Code'**
  String get homeParCopyCode;

  /// No description provided for @homeParCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get homeParCodeCopied;

  /// No description provided for @homeParManageMembers.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get homeParManageMembers;

  /// No description provided for @homeParSpendingOverview.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get homeParSpendingOverview;

  /// No description provided for @homeParMonthlyExpense.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get homeParMonthlyExpense;

  /// No description provided for @homeParMonthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get homeParMonthlyIncome;

  /// No description provided for @homeParTransactionTagNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get homeParTransactionTagNew;

  /// No description provided for @homeParTransactionTagEdited.
  ///
  /// In en, this message translates to:
  /// **'Edited'**
  String get homeParTransactionTagEdited;

  /// No description provided for @homeParLoadingMemberData.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get homeParLoadingMemberData;

  /// No description provided for @homeParAddMember.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get homeParAddMember;

  /// No description provided for @homeParRecentTransactionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get homeParRecentTransactionsLabel;

  /// No description provided for @homeParSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeParSeeAll;

  /// No description provided for @homeParAlertsLabel.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get homeParAlertsLabel;

  /// No description provided for @homeParAlertWeeklyLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Approaching Weekly Limit'**
  String get homeParAlertWeeklyLimitTitle;

  /// No description provided for @homeParAlertWeeklyLimitBody.
  ///
  /// In en, this message translates to:
  /// **'Check spending limits for your family members.'**
  String get homeParAlertWeeklyLimitBody;

  /// No description provided for @homeParTopCategoryAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Highest spending in {category}'**
  String homeParTopCategoryAlertTitle(String category);

  /// No description provided for @homeParTopCategoryAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Tap to view transaction details'**
  String get homeParTopCategoryAlertBody;

  /// No description provided for @homeParThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get homeParThisMonth;

  /// No description provided for @homeParViewDetail.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get homeParViewDetail;

  /// No description provided for @homeParSpentPercent.
  ///
  /// In en, this message translates to:
  /// **'Spent {percent}% of income'**
  String homeParSpentPercent(String percent);

  /// No description provided for @homeParTotalMonthlySpending.
  ///
  /// In en, this message translates to:
  /// **'Total spending this month'**
  String get homeParTotalMonthlySpending;

  /// No description provided for @homeParLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Limit:'**
  String get homeParLimitLabel;

  /// No description provided for @homeParUsedPercent.
  ///
  /// In en, this message translates to:
  /// **'Used {percent}%'**
  String homeParUsedPercent(String percent);

  /// No description provided for @homeParLowBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Low balance'**
  String get homeParLowBalanceTitle;

  /// No description provided for @homeParLowBalanceDesc.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s account is below 100,000₫.'**
  String homeParLowBalanceDesc(String name);

  /// No description provided for @homeParTransactionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get homeParTransactionSuccess;

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

  /// No description provided for @settingFAQ.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get settingFAQ;

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

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @actionSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get actionSelect;

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

  /// No description provided for @transactionAmountInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get transactionAmountInputLabel;

  /// No description provided for @transactionDetailSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get transactionDetailSectionLabel;

  /// No description provided for @transactionDateRowLabel.
  ///
  /// In en, this message translates to:
  /// **'Transaction date'**
  String get transactionDateRowLabel;

  /// No description provided for @transactionExpenseTab.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get transactionExpenseTab;

  /// No description provided for @transactionIncomeTab.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get transactionIncomeTab;

  /// No description provided for @transactionCategoryViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get transactionCategoryViewAll;

  /// No description provided for @transactionEvidenceRowLabel.
  ///
  /// In en, this message translates to:
  /// **'Receipt photo'**
  String get transactionEvidenceRowLabel;

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

  /// No description provided for @transactionHistorySelectDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get transactionHistorySelectDateTitle;

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

  /// No description provided for @transactionDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction details'**
  String get transactionDetailTitle;

  /// No description provided for @transactionDetailNoData.
  ///
  /// In en, this message translates to:
  /// **'No transaction data available.'**
  String get transactionDetailNoData;

  /// No description provided for @transactionDetailTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get transactionDetailTimeLabel;

  /// No description provided for @transactionDetailCreatedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'CREATED AT'**
  String get transactionDetailCreatedAtLabel;

  /// No description provided for @transactionDetailNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'NOTE'**
  String get transactionDetailNoteLabel;

  /// No description provided for @transactionDetailEvidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'EVIDENCE IMAGE'**
  String get transactionDetailEvidenceLabel;

  /// No description provided for @transactionEditAction.
  ///
  /// In en, this message translates to:
  /// **'Edit transaction'**
  String get transactionEditAction;

  /// No description provided for @transactionDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete transaction'**
  String get transactionDeleteAction;

  /// No description provided for @transactionEvidenceSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Evidence image'**
  String get transactionEvidenceSectionTitle;

  /// No description provided for @transactionEvidenceAddOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Add evidence image (optional)'**
  String get transactionEvidenceAddOptionalLabel;

  /// No description provided for @transactionEvidenceOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Optional. Add one proof image for this transaction.'**
  String get transactionEvidenceOptionalLabel;

  /// No description provided for @transactionEvidenceUploadAction.
  ///
  /// In en, this message translates to:
  /// **'Upload image'**
  String get transactionEvidenceUploadAction;

  /// No description provided for @transactionEvidenceAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get transactionEvidenceAddAction;

  /// No description provided for @transactionEvidenceReplaceAction.
  ///
  /// In en, this message translates to:
  /// **'Replace image'**
  String get transactionEvidenceReplaceAction;

  /// No description provided for @transactionEvidenceRemoveAction.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get transactionEvidenceRemoveAction;

  /// No description provided for @transactionEvidenceSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected image'**
  String get transactionEvidenceSelectedLabel;

  /// No description provided for @transactionEvidenceAttachedLabel.
  ///
  /// In en, this message translates to:
  /// **'Image attached'**
  String get transactionEvidenceAttachedLabel;

  /// No description provided for @transactionEvidenceEmpty.
  ///
  /// In en, this message translates to:
  /// **'No evidence image attached yet.'**
  String get transactionEvidenceEmpty;

  /// No description provided for @transactionEvidenceLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the evidence image.'**
  String get transactionEvidenceLoadError;

  /// No description provided for @transactionEvidenceLegacyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This evidence image was stored with the old storage flow and is no longer available here.'**
  String get transactionEvidenceLegacyUnavailable;

  /// No description provided for @transactionEvidenceUnsupportedFormat.
  ///
  /// In en, this message translates to:
  /// **'Only JPG and PNG images are supported.'**
  String get transactionEvidenceUnsupportedFormat;

  /// No description provided for @transactionEvidenceUploadTimeout.
  ///
  /// In en, this message translates to:
  /// **'Image upload timed out. Please try again.'**
  String get transactionEvidenceUploadTimeout;

  /// No description provided for @transactionEvidencePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Unable to save the evidence image. Check the Firestore rules for Cloudinary evidence_image.'**
  String get transactionEvidencePermissionDenied;

  /// No description provided for @transactionPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Current rules are blocking the transaction write. Check the Firestore schema and rules again.'**
  String get transactionPermissionDenied;

  /// No description provided for @transactionScanAction.
  ///
  /// In en, this message translates to:
  /// **'Scan receipt'**
  String get transactionScanAction;

  /// No description provided for @transactionRescanAction.
  ///
  /// In en, this message translates to:
  /// **'Scan again'**
  String get transactionRescanAction;

  /// No description provided for @transactionScanHint.
  ///
  /// In en, this message translates to:
  /// **'Take or choose one receipt image to autofill amount, date, category, and note.'**
  String get transactionScanHint;

  /// No description provided for @transactionScanExtracting.
  ///
  /// In en, this message translates to:
  /// **'Reading text from the receipt image...'**
  String get transactionScanExtracting;

  /// No description provided for @transactionScanAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing category and writing description...'**
  String get transactionScanAnalyzing;

  /// No description provided for @transactionScanSuccess.
  ///
  /// In en, this message translates to:
  /// **'Autofill complete. Review every suggested field before saving.'**
  String get transactionScanSuccess;

  /// No description provided for @transactionScanPartial.
  ///
  /// In en, this message translates to:
  /// **'Basic fields were filled from OCR. Review category and note manually if needed.'**
  String get transactionScanPartial;

  /// No description provided for @transactionScanFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to analyze this receipt. You can try again or enter the transaction manually.'**
  String get transactionScanFailed;

  /// No description provided for @transactionScanNoTextFound.
  ///
  /// In en, this message translates to:
  /// **'No readable text was found in this receipt image.'**
  String get transactionScanNoTextFound;

  /// No description provided for @transactionScanNoSuggestion.
  ///
  /// In en, this message translates to:
  /// **'No usable autofill suggestion was found. Please review the form manually.'**
  String get transactionScanNoSuggestion;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Profile'**
  String get profileEditTitle;

  /// No description provided for @profileEditAvatarLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Avatar'**
  String get profileEditAvatarLabel;

  /// No description provided for @profileEditAvatarDesc.
  ///
  /// In en, this message translates to:
  /// **'Take a new photo or choose from gallery'**
  String get profileEditAvatarDesc;

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

  /// No description provided for @profileEditDobPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Date of Birth'**
  String get profileEditDobPickerTitle;

  /// No description provided for @profileEditDobPickerDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get profileEditDobPickerDone;

  /// No description provided for @actionSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get actionSaveChanges;

  /// No description provided for @profileEditSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileEditSaveSuccess;

  /// No description provided for @profileEditErrorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get profileEditErrorNameRequired;

  /// No description provided for @profileEditErrorNameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get profileEditErrorNameTooShort;

  /// No description provided for @profileEditErrorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid Vietnamese phone number (e.g. 0912345678)'**
  String get profileEditErrorInvalidPhone;

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

  /// No description provided for @scanReceiptCameraSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open camera to take photo directly'**
  String get scanReceiptCameraSubtitle;

  /// No description provided for @scanReceiptGallerySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose from device photo library'**
  String get scanReceiptGallerySubtitle;

  /// No description provided for @chooseAiModelTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose AI model'**
  String get chooseAiModelTitle;

  /// No description provided for @chooseAiModelDescription.
  ///
  /// In en, this message translates to:
  /// **'Use your Gemini API key to test a real AI request in this screen. The local gemma 2b download path is still being prepared separately.'**
  String get chooseAiModelDescription;

  /// No description provided for @aiModelGeminiName.
  ///
  /// In en, this message translates to:
  /// **'Gemini'**
  String get aiModelGeminiName;

  /// No description provided for @aiModelUseApiKeyModel.
  ///
  /// In en, this message translates to:
  /// **'Use API key model'**
  String get aiModelUseApiKeyModel;

  /// No description provided for @aiModelUseLocalModel.
  ///
  /// In en, this message translates to:
  /// **'Use local model'**
  String get aiModelUseLocalModel;

  /// No description provided for @aiModelApiKeyAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'API key verified and saved'**
  String get aiModelApiKeyAddSuccess;

  /// No description provided for @aiModelApiKeyInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid API key. Please check and try again.'**
  String get aiModelApiKeyInvalid;

  /// No description provided for @aiModelApiKeyTestFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not verify API key. Check your internet connection.'**
  String get aiModelApiKeyTestFailed;

  /// No description provided for @aiModelGemmaName.
  ///
  /// In en, this message translates to:
  /// **'gemma 2b'**
  String get aiModelGemmaName;

  /// No description provided for @aiModelApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter API key'**
  String get aiModelApiKeyHint;

  /// No description provided for @aiModelAddApiKey.
  ///
  /// In en, this message translates to:
  /// **'Add API Key'**
  String get aiModelAddApiKey;

  /// No description provided for @aiModelRemoveApiKey.
  ///
  /// In en, this message translates to:
  /// **'Remove API Key'**
  String get aiModelRemoveApiKey;

  /// No description provided for @aiModelApiKeySessionNote.
  ///
  /// In en, this message translates to:
  /// **'API key is securely stored on this device.'**
  String get aiModelApiKeySessionNote;

  /// No description provided for @aiModelPromptHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a prompt to test Gemini...'**
  String get aiModelPromptHint;

  /// No description provided for @aiModelSendPrompt.
  ///
  /// In en, this message translates to:
  /// **'Send Prompt'**
  String get aiModelSendPrompt;

  /// No description provided for @aiModelResponseTitle.
  ///
  /// In en, this message translates to:
  /// **'Gemini response'**
  String get aiModelResponseTitle;

  /// No description provided for @aiModelApiKeyRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an API key first.'**
  String get aiModelApiKeyRequired;

  /// No description provided for @aiModelPromptRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a prompt before sending.'**
  String get aiModelPromptRequired;

  /// No description provided for @aiModelInvalidApiKey.
  ///
  /// In en, this message translates to:
  /// **'The Gemini API key is invalid or does not have access.'**
  String get aiModelInvalidApiKey;

  /// No description provided for @aiModelRequestTimeout.
  ///
  /// In en, this message translates to:
  /// **'The Gemini request timed out. Please try again.'**
  String get aiModelRequestTimeout;

  /// No description provided for @aiModelEmptyResponse.
  ///
  /// In en, this message translates to:
  /// **'Gemini returned an empty response.'**
  String get aiModelEmptyResponse;

  /// No description provided for @aiModelRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to get a Gemini response right now.'**
  String get aiModelRequestFailed;

  /// No description provided for @aiModelLocalSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Local model'**
  String get aiModelLocalSectionTitle;

  /// No description provided for @aiModelDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get aiModelDownload;

  /// No description provided for @aiModelGemmaDownloadConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'File size: ~1.35 GB. Make sure you have enough storage and a stable connection before downloading.'**
  String get aiModelGemmaDownloadConfirmMessage;

  /// No description provided for @aiModelDeleteModel.
  ///
  /// In en, this message translates to:
  /// **'Delete model'**
  String get aiModelDeleteModel;

  /// No description provided for @aiModelGemmaDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete AI model from device? You will need to re-download it to use it again.'**
  String get aiModelGemmaDeleteConfirmMessage;

  /// No description provided for @aiModelGemmaDescription.
  ///
  /// In en, this message translates to:
  /// **'Source provenance is pinned to the official Google Gemma docs and the google/gemma-2b-it distribution channel. The app download URL will be managed separately later.'**
  String get aiModelGemmaDescription;

  /// No description provided for @aiModelComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get aiModelComingSoon;

  /// No description provided for @aiModelAnalyzeTransaction.
  ///
  /// In en, this message translates to:
  /// **'Analyze Transaction'**
  String get aiModelAnalyzeTransaction;

  /// No description provided for @aiModelAnalyzingTransaction.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get aiModelAnalyzingTransaction;

  /// No description provided for @aiModelSelectModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Select model'**
  String get aiModelSelectModelLabel;

  /// No description provided for @aiModelHeroEyebrow.
  ///
  /// In en, this message translates to:
  /// **'AI model setup'**
  String get aiModelHeroEyebrow;

  /// No description provided for @aiModelHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your AI analysis model'**
  String get aiModelHeroTitle;

  /// No description provided for @aiModelHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect via Gemini API or download a local model for on-device processing.'**
  String get aiModelHeroSubtitle;

  /// No description provided for @aiModelGeminiCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Use cloud AI to categorize transactions and get quick spending insights.'**
  String get aiModelGeminiCardDescription;

  /// No description provided for @aiModelRecommendedBadge.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get aiModelRecommendedBadge;

  /// No description provided for @aiModelGemmaCardDescription.
  ///
  /// In en, this message translates to:
  /// **'Runs on-device for enhanced privacy. Keeps all data on your phone.'**
  String get aiModelGemmaCardDescription;

  /// No description provided for @aiModelPrivateBadge.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get aiModelPrivateBadge;

  /// No description provided for @aiModelFooterNote.
  ///
  /// In en, this message translates to:
  /// **'You can switch models anytime in AI settings.'**
  String get aiModelFooterNote;

  /// No description provided for @aiModelEnableGemini.
  ///
  /// In en, this message translates to:
  /// **'Enable Gemini'**
  String get aiModelEnableGemini;

  /// No description provided for @aiModelSelectModelConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This model will be used for the next Gemini requests on this device.'**
  String get aiModelSelectModelConfirmMessage;

  /// No description provided for @aiModelUseThisModel.
  ///
  /// In en, this message translates to:
  /// **'Use this model'**
  String get aiModelUseThisModel;

  /// No description provided for @aiModelSavingModelSelection.
  ///
  /// In en, this message translates to:
  /// **'Saving selected model...'**
  String get aiModelSavingModelSelection;

  /// No description provided for @appBarBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'SmartSpending'**
  String get appBarBrandTitle;

  /// No description provided for @appBarNotificationsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get appBarNotificationsTooltip;

  /// No description provided for @navParentHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navParentHome;

  /// No description provided for @navParentStatistic.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get navParentStatistic;

  /// No description provided for @navParentSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navParentSettings;

  /// No description provided for @parentStatisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get parentStatisticTitle;

  /// No description provided for @parentStatisticWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get parentStatisticWeek;

  /// No description provided for @parentStatisticMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get parentStatisticMonth;

  /// No description provided for @parentStatisticYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get parentStatisticYear;

  /// No description provided for @parentStatisticBudgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Budget'**
  String get parentStatisticBudgetTitle;

  /// No description provided for @parentStatisticSpentLabel.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get parentStatisticSpentLabel;

  /// No description provided for @parentStatisticLeftLabel.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get parentStatisticLeftLabel;

  /// No description provided for @parentStatisticTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending Trend'**
  String get parentStatisticTrendTitle;

  /// No description provided for @parentStatisticTopCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get parentStatisticTopCategoriesTitle;

  /// No description provided for @parentStatisticNoData.
  ///
  /// In en, this message translates to:
  /// **'No data available yet'**
  String get parentStatisticNoData;

  /// No description provided for @parentStatisticTotalSpentTitle.
  ///
  /// In en, this message translates to:
  /// **'Total spent'**
  String get parentStatisticTotalSpentTitle;

  /// No description provided for @parentStatisticVsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'vs last month'**
  String get parentStatisticVsLastMonth;

  /// No description provided for @parentStatisticSpendingUp.
  ///
  /// In en, this message translates to:
  /// **'+{percent}%'**
  String parentStatisticSpendingUp(String percent);

  /// No description provided for @parentStatisticSpendingDown.
  ///
  /// In en, this message translates to:
  /// **'-{percent}%'**
  String parentStatisticSpendingDown(String percent);

  /// No description provided for @parentStatisticSpendingStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get parentStatisticSpendingStable;

  /// No description provided for @parentStatisticLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading spending statistics...'**
  String get parentStatisticLoading;

  /// No description provided for @parentStatisticLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load spending statistics.'**
  String get parentStatisticLoadError;

  /// No description provided for @parentStatisticRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get parentStatisticRetry;

  /// No description provided for @parentStatisticSelectChild.
  ///
  /// In en, this message translates to:
  /// **'Select a child to view spending statistics.'**
  String get parentStatisticSelectChild;

  /// No description provided for @parentStatisticTransactionCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No transactions} =1{1 transaction} other{{count} transactions}}'**
  String parentStatisticTransactionCount(int count);

  /// No description provided for @parentStatisticTotalExpenseLabel.
  ///
  /// In en, this message translates to:
  /// **'TOTAL SPENT'**
  String get parentStatisticTotalExpenseLabel;

  /// No description provided for @parentStatisticTxCountLabel.
  ///
  /// In en, this message translates to:
  /// **'TX COUNT'**
  String get parentStatisticTxCountLabel;

  /// No description provided for @parentStatisticPrevPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'PREV PERIOD'**
  String get parentStatisticPrevPeriodLabel;

  /// No description provided for @parentStatisticTrendGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get parentStatisticTrendGood;

  /// No description provided for @parentStatisticTrendBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get parentStatisticTrendBad;

  /// No description provided for @parentStatisticEditedBadge.
  ///
  /// In en, this message translates to:
  /// **'Edited'**
  String get parentStatisticEditedBadge;

  /// No description provided for @settingParTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingParTitle;

  /// No description provided for @settingParEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get settingParEditProfile;

  /// No description provided for @settingParFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family management'**
  String get settingParFamilyTitle;

  /// No description provided for @settingParManageFamilyLabel.
  ///
  /// In en, this message translates to:
  /// **'Manage Family Member'**
  String get settingParManageFamilyLabel;

  /// No description provided for @settingParChildAccountsLabel.
  ///
  /// In en, this message translates to:
  /// **'Child accounts'**
  String get settingParChildAccountsLabel;

  /// No description provided for @settingParChildAccountsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or remove accounts'**
  String get settingParChildAccountsSubtitle;

  /// No description provided for @settingParSpendingLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Spending limit'**
  String get settingParSpendingLimitLabel;

  /// No description provided for @settingParSpendingLimitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set weekly/monthly limits'**
  String get settingParSpendingLimitSubtitle;

  /// No description provided for @settingParAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingParAppearanceTitle;

  /// No description provided for @settingParThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Light/Dark mode'**
  String get settingParThemeLabel;

  /// No description provided for @settingThemeDarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settingThemeDarkLabel;

  /// No description provided for @settingThemeDarkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch to a dark interface'**
  String get settingThemeDarkSubtitle;

  /// No description provided for @settingParNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingParNotificationsTitle;

  /// No description provided for @settingParPushLabel.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingParPushLabel;

  /// No description provided for @settingParPushSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When child makes a transaction'**
  String get settingParPushSubtitle;

  /// No description provided for @settingParEmailReportLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly email report'**
  String get settingParEmailReportLabel;

  /// No description provided for @settingParAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingParAccountTitle;

  /// No description provided for @settingParChangePasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingParChangePasswordLabel;

  /// No description provided for @settingParHelpLabel.
  ///
  /// In en, this message translates to:
  /// **'Help & Feedback'**
  String get settingParHelpLabel;

  /// No description provided for @settingParLogoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingParLogoutLabel;

  /// No description provided for @settingParVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.2'**
  String get settingParVersion;

  /// No description provided for @settingStuTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingStuTitle;

  /// No description provided for @settingStuSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingStuSectionGeneral;

  /// No description provided for @settingStuSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingStuSectionAccount;

  /// No description provided for @settingStuBudgetLabel.
  ///
  /// In en, this message translates to:
  /// **'Budget Setup'**
  String get settingStuBudgetLabel;

  /// No description provided for @settingStuFamilyCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Family Code'**
  String get settingStuFamilyCodeLabel;

  /// No description provided for @settingStuEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Account & App'**
  String get settingStuEyebrow;

  /// No description provided for @settingStuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your language, notifications and family connection.'**
  String get settingStuSubtitle;

  /// No description provided for @settingStuNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive new transaction alerts'**
  String get settingStuNotificationsSubtitle;

  /// No description provided for @settingStuAiModelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Smart budget assistant'**
  String get settingStuAiModelSubtitle;

  /// No description provided for @settingStuFamilyCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect with parent account'**
  String get settingStuFamilyCodeSubtitle;

  /// No description provided for @settingStuProfileEditLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingStuProfileEditLabel;

  /// No description provided for @settingStuProfileEditSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your personal info'**
  String get settingStuProfileEditSubtitle;

  /// No description provided for @settingStuFaqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answers to common questions'**
  String get settingStuFaqSubtitle;

  /// No description provided for @settingSignOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get settingSignOutConfirm;

  /// No description provided for @settingSignOutFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign out failed'**
  String get settingSignOutFailed;

  /// No description provided for @aiModelApiKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get aiModelApiKeyLabel;

  /// No description provided for @aiModelGeminiSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Gemini Google API'**
  String get aiModelGeminiSectionTitle;

  /// No description provided for @aiModelBetaLabel.
  ///
  /// In en, this message translates to:
  /// **'Beta'**
  String get aiModelBetaLabel;

  /// No description provided for @aiModelDownloadingNote.
  ///
  /// In en, this message translates to:
  /// **'Do not close the app'**
  String get aiModelDownloadingNote;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @loginTagline.
  ///
  /// In en, this message translates to:
  /// **'Smart family finance'**
  String get loginTagline;

  /// No description provided for @loginAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get loginAccountLabel;

  /// No description provided for @loginEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Email / phone number'**
  String get loginEmailPlaceholder;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get loginPasswordPlaceholder;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginRegisterButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up if you don\'t have an account'**
  String get loginRegisterButton;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to get started with Monikid.'**
  String get registerSubtitle;

  /// No description provided for @registerTagline.
  ///
  /// In en, this message translates to:
  /// **'Begin your financial journey'**
  String get registerTagline;

  /// No description provided for @registerEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get registerEmailPlaceholder;

  /// No description provided for @registerUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get registerUsernameLabel;

  /// No description provided for @registerUsernamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get registerUsernamePlaceholder;

  /// No description provided for @registerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get registerPhoneLabel;

  /// No description provided for @registerPhonePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get registerPhonePlaceholder;

  /// No description provided for @registerPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get registerPasswordPlaceholder;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerConfirmPasswordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get registerConfirmPasswordPlaceholder;

  /// No description provided for @registerRoleParent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get registerRoleParent;

  /// No description provided for @registerRoleStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get registerRoleStudent;

  /// No description provided for @registerHaveAccountText.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerHaveAccountText;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get validationPasswordMismatch;

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

  /// No description provided for @homeStudentSummaryEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Monthly overview'**
  String get homeStudentSummaryEyebrow;

  /// No description provided for @homeStudentSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Month {month} spending'**
  String homeStudentSummaryTitle(int month);

  /// No description provided for @homeStudentTodayTransactionsSub.
  ///
  /// In en, this message translates to:
  /// **'{count} transactions today'**
  String homeStudentTodayTransactionsSub(int count);

  /// No description provided for @homeStudentTopCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Top spending'**
  String get homeStudentTopCategoryLabel;

  /// No description provided for @homeStudentMonthPill.
  ///
  /// In en, this message translates to:
  /// **'Month {month}'**
  String homeStudentMonthPill(int month);

  /// No description provided for @homeStudentUsedPercent.
  ///
  /// In en, this message translates to:
  /// **'Used {percent}%'**
  String homeStudentUsedPercent(int percent);

  /// No description provided for @homeStudentTransactionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get homeStudentTransactionsLabel;

  /// No description provided for @homeStudentTransactionCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} transactions'**
  String homeStudentTransactionCountLabel(int count);

  /// No description provided for @homeStudentRemainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Left: {amount}'**
  String homeStudentRemainingAmount(String amount);

  /// No description provided for @homeStudentQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get homeStudentQuickActionsTitle;

  /// No description provided for @homeStudentScanBillTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan bill AI'**
  String get homeStudentScanBillTitle;

  /// No description provided for @homeStudentScanBillSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan receipts and save quickly'**
  String get homeStudentScanBillSubtitle;

  /// No description provided for @homeStudentSetLimitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control monthly spending'**
  String get homeStudentSetLimitSubtitle;

  /// No description provided for @homeStudentMonthlyIncomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get homeStudentMonthlyIncomeLabel;

  /// No description provided for @homeStudentUsedLabel.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get homeStudentUsedLabel;

  /// No description provided for @setMoneyLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Set monthly limit'**
  String get setMoneyLimitTitle;

  /// No description provided for @setMoneyLimitFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get setMoneyLimitFieldLabel;

  /// No description provided for @setMoneyLimitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the maximum amount your child can spend this month. Changes will apply immediately to the current month.'**
  String get setMoneyLimitSubtitle;

  /// No description provided for @setMoneyLimitDescription.
  ///
  /// In en, this message translates to:
  /// **'Check that the limit fits your child\'s plan for the month.'**
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

  /// No description provided for @statisticByYear.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get statisticByYear;

  /// No description provided for @statisticHeaderEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Track your child\'s spending'**
  String get statisticHeaderEyebrow;

  /// No description provided for @statisticHeaderSubhead.
  ///
  /// In en, this message translates to:
  /// **'Transaction summary, budget alerts, and top spending categories at a glance.'**
  String get statisticHeaderSubhead;

  /// No description provided for @statisticAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending Alert'**
  String get statisticAlertTitle;

  /// No description provided for @statisticAlertPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority Check'**
  String get statisticAlertPriority;

  /// No description provided for @statisticProgressUsageLabel.
  ///
  /// In en, this message translates to:
  /// **'Usage progress'**
  String get statisticProgressUsageLabel;

  /// No description provided for @statisticBudgetAdjustAnytime.
  ///
  /// In en, this message translates to:
  /// **'Parents can adjust the limit at any time'**
  String get statisticBudgetAdjustAnytime;

  /// No description provided for @statisticChartSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending Chart'**
  String get statisticChartSectionTitle;

  /// No description provided for @statisticChartComparisonTitle.
  ///
  /// In en, this message translates to:
  /// **'Compare Over Time'**
  String get statisticChartComparisonTitle;

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

  /// No description provided for @statisticYearNoun.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get statisticYearNoun;

  /// No description provided for @statisticLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load statistic data. Please try again.'**
  String get statisticLoadError;

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

  /// No description provided for @statisticThisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get statisticThisYear;

  /// No description provided for @statisticLastYear.
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get statisticLastYear;

  /// No description provided for @statisticSmartInsightFallback.
  ///
  /// In en, this message translates to:
  /// **'No standout spending insight yet for this period.'**
  String get statisticSmartInsightFallback;

  /// No description provided for @statisticSmartInsightMessage.
  ///
  /// In en, this message translates to:
  /// **'This {periodLabel}, you spent {percent}% more on {categoryLabel} than the previous {periodLabel}. This category increased the most.'**
  String statisticSmartInsightMessage(
    String periodLabel,
    String percent,
    String categoryLabel,
  );

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

  /// No description provided for @statisticTopIncomeCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Top income categories'**
  String get statisticTopIncomeCategoriesTitle;

  /// No description provided for @statisticCategoryTransactionListTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction List'**
  String get statisticCategoryTransactionListTitle;

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

  /// No description provided for @scanBillNoAiAvailable.
  ///
  /// In en, this message translates to:
  /// **'No AI available. Set up an API key or download the local AI model.'**
  String get scanBillNoAiAvailable;

  /// No description provided for @scanBillAiError.
  ///
  /// In en, this message translates to:
  /// **'Unable to analyze the bill. Please try again or enter manually.'**
  String get scanBillAiError;

  /// No description provided for @scanBillLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing Receipt'**
  String get scanBillLoadingTitle;

  /// No description provided for @scanBillScanningStatus.
  ///
  /// In en, this message translates to:
  /// **'Scanning receipt...'**
  String get scanBillScanningStatus;

  /// No description provided for @scanBillAnalyzingStatus.
  ///
  /// In en, this message translates to:
  /// **'AI is analyzing...'**
  String get scanBillAnalyzingStatus;

  /// No description provided for @joinFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Family'**
  String get joinFamilyTitle;

  /// No description provided for @joinFamilySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit invite code from your parent'**
  String get joinFamilySubtitle;

  /// No description provided for @joinFamilyInputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get joinFamilyInputHint;

  /// No description provided for @joinFamilyButton.
  ///
  /// In en, this message translates to:
  /// **'Join Family'**
  String get joinFamilyButton;

  /// No description provided for @joinFamilySuccess.
  ///
  /// In en, this message translates to:
  /// **'You have joined the family!'**
  String get joinFamilySuccess;

  /// No description provided for @joinFamilyErrorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired invite code'**
  String get joinFamilyErrorInvalidCode;

  /// No description provided for @joinFamilyErrorAlreadyMember.
  ///
  /// In en, this message translates to:
  /// **'You are already part of a family'**
  String get joinFamilyErrorAlreadyMember;

  /// No description provided for @joinFamilyErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Failed to join. Please try again.'**
  String get joinFamilyErrorUnknown;

  /// No description provided for @joinFamilyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Connect Account'**
  String get joinFamilyEyebrow;

  /// No description provided for @joinFamilyHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter family code to get started'**
  String get joinFamilyHeroTitle;

  /// No description provided for @joinFamilyHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join your family group so parents can safely monitor transactions and manage your spending.'**
  String get joinFamilyHeroSubtitle;

  /// No description provided for @joinFamilyMiniCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Space'**
  String get joinFamilyMiniCardTitle;

  /// No description provided for @joinFamilyMiniCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Transparent transactions, easy to track'**
  String get joinFamilyMiniCardDesc;

  /// No description provided for @joinFamilyEnterCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit code'**
  String get joinFamilyEnterCodeTitle;

  /// No description provided for @joinFamilyEnterCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This code is sent to you by the parent or family creator.'**
  String get joinFamilyEnterCodeSubtitle;

  /// No description provided for @joinFamilyCodeOnlyDigits.
  ///
  /// In en, this message translates to:
  /// **'Only accepts a 6-digit numeric code'**
  String get joinFamilyCodeOnlyDigits;

  /// No description provided for @joinFamilyJoinNow.
  ///
  /// In en, this message translates to:
  /// **'Join now'**
  String get joinFamilyJoinNow;

  /// No description provided for @joinFamilyNoCode.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have a code?'**
  String get joinFamilyNoCode;

  /// No description provided for @unlinkFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'My Family'**
  String get unlinkFamilyTitle;

  /// No description provided for @unlinkFamilySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You are currently connected to a family'**
  String get unlinkFamilySubtitle;

  /// No description provided for @unlinkFamilyButton.
  ///
  /// In en, this message translates to:
  /// **'Leave Family'**
  String get unlinkFamilyButton;

  /// No description provided for @unlinkFamilyConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave family?'**
  String get unlinkFamilyConfirmTitle;

  /// No description provided for @unlinkFamilyConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You will leave this family. You can rejoin later with an invite code.'**
  String get unlinkFamilyConfirmBody;

  /// No description provided for @unlinkFamilySuccess.
  ///
  /// In en, this message translates to:
  /// **'You have left the family.'**
  String get unlinkFamilySuccess;

  /// No description provided for @unlinkFamilyErrorFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to leave family. Please try again.'**
  String get unlinkFamilyErrorFailed;

  /// No description provided for @familyMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Members'**
  String get familyMembersTitle;

  /// No description provided for @familyStatusJoined.
  ///
  /// In en, this message translates to:
  /// **'Currently Joined'**
  String get familyStatusJoined;

  /// No description provided for @familyLinkedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Linked Successfully'**
  String get familyLinkedSuccess;

  /// No description provided for @familyMemberListLabel.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get familyMemberListLabel;

  /// No description provided for @familyMembersUnit.
  ///
  /// In en, this message translates to:
  /// **'members'**
  String get familyMembersUnit;

  /// No description provided for @familyRoleParent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get familyRoleParent;

  /// No description provided for @familyRoleChild.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get familyRoleChild;

  /// No description provided for @familyRoleOwner.
  ///
  /// In en, this message translates to:
  /// **'Family Owner'**
  String get familyRoleOwner;

  /// No description provided for @familyMemberYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get familyMemberYou;

  /// No description provided for @familyMemberActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get familyMemberActive;

  /// No description provided for @unlinkFamilyButtonFull.
  ///
  /// In en, this message translates to:
  /// **'Leave Family'**
  String get unlinkFamilyButtonFull;

  /// No description provided for @customCategoryAdd.
  ///
  /// In en, this message translates to:
  /// **'Add custom category'**
  String get customCategoryAdd;

  /// No description provided for @customCategoryAddSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Category will be added as expense type'**
  String get customCategoryAddSubtitle;

  /// No description provided for @customCategoryLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get customCategoryLabelHint;

  /// No description provided for @customCategoryTypeExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get customCategoryTypeExpense;

  /// No description provided for @customCategoryTypeIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get customCategoryTypeIncome;

  /// No description provided for @customCategoryLimitReached.
  ///
  /// In en, this message translates to:
  /// **'You can have at most 5 custom categories'**
  String get customCategoryLimitReached;

  /// No description provided for @customCategoryCreated.
  ///
  /// In en, this message translates to:
  /// **'Category created'**
  String get customCategoryCreated;

  /// No description provided for @customCategoryCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create category. Please try again.'**
  String get customCategoryCreateFailed;

  /// No description provided for @customCategoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted'**
  String get customCategoryDeleted;

  /// No description provided for @customCategoryConfirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete this category?'**
  String get customCategoryConfirmDelete;

  /// No description provided for @customCategoryConfirmDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Transactions using this category will keep their existing label.'**
  String get customCategoryConfirmDeleteBody;

  /// No description provided for @customCategoryCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get customCategoryCancel;

  /// No description provided for @customCategoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get customCategoryConfirm;

  /// No description provided for @customCategorySelectTitleExpense.
  ///
  /// In en, this message translates to:
  /// **'Select expense category'**
  String get customCategorySelectTitleExpense;

  /// No description provided for @customCategorySelectTitleIncome.
  ///
  /// In en, this message translates to:
  /// **'Select income category'**
  String get customCategorySelectTitleIncome;

  /// No description provided for @customCategorySelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get customCategorySelectTitle;

  /// No description provided for @customCategoryConfirmSelection.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get customCategoryConfirmSelection;

  /// No description provided for @customCategoryAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get customCategoryAddNew;

  /// No description provided for @customCategoryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get customCategoryDelete;

  /// No description provided for @customCategoryIconHint.
  ///
  /// In en, this message translates to:
  /// **'Pick an icon'**
  String get customCategoryIconHint;

  /// No description provided for @customCategoryDropToDelete.
  ///
  /// In en, this message translates to:
  /// **'Drop here to delete'**
  String get customCategoryDropToDelete;

  /// No description provided for @customCategoryDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete category'**
  String get customCategoryDeleteFailed;

  /// No description provided for @setMoneyLimitManagedByParent.
  ///
  /// In en, this message translates to:
  /// **'Spending limit is managed by parent'**
  String get setMoneyLimitManagedByParent;

  /// No description provided for @parentSetLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Set monthly spending limit'**
  String get parentSetLimitTitle;

  /// No description provided for @parentSetLimitDescription.
  ///
  /// In en, this message translates to:
  /// **'This limit helps your child stay in control of their spending each month'**
  String get parentSetLimitDescription;

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifTitle;

  /// No description provided for @notifMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notifMarkAllRead;

  /// No description provided for @notifEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notifEmpty;

  /// No description provided for @notifOverspend80Title.
  ///
  /// In en, this message translates to:
  /// **'Approaching limit'**
  String get notifOverspend80Title;

  /// No description provided for @notifOverspend80Body.
  ///
  /// In en, this message translates to:
  /// **'You\'ve spent {amount} — 80% of your {month} limit.'**
  String notifOverspend80Body(Object amount, Object month);

  /// No description provided for @notifOverspend100Title.
  ///
  /// In en, this message translates to:
  /// **'Limit exceeded'**
  String get notifOverspend100Title;

  /// No description provided for @notifOverspend100Body.
  ///
  /// In en, this message translates to:
  /// **'You\'ve spent {amount} — exceeded your {month} limit.'**
  String notifOverspend100Body(Object amount, Object month);

  /// No description provided for @notifWeeklyOverspendTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending spike'**
  String get notifWeeklyOverspendTitle;

  /// No description provided for @notifWeeklyOverspendBody.
  ///
  /// In en, this message translates to:
  /// **'You spent {percent}% more this week than last week.'**
  String notifWeeklyOverspendBody(Object percent);

  /// No description provided for @notifParentOverspend80Body.
  ///
  /// In en, this message translates to:
  /// **'{childName} has spent 80% of the {month} limit.'**
  String notifParentOverspend80Body(Object childName, Object month);

  /// No description provided for @notifParentOverspend100Body.
  ///
  /// In en, this message translates to:
  /// **'{childName} has exceeded the {month} limit.'**
  String notifParentOverspend100Body(Object childName, Object month);

  /// No description provided for @notifParentWeeklyOverspendBody.
  ///
  /// In en, this message translates to:
  /// **'{childName} spent {percent}% more this week than last week.'**
  String notifParentWeeklyOverspendBody(Object childName, Object percent);

  /// No description provided for @familyManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Family'**
  String get familyManagementTitle;

  /// No description provided for @familyManagementEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No family found'**
  String get familyManagementEmptyMessage;

  /// No description provided for @familyManagementErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading family data'**
  String get familyManagementErrorMessage;

  /// No description provided for @familyManagementHostBadge.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get familyManagementHostBadge;

  /// No description provided for @familyManagementHostSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get familyManagementHostSubtitle;

  /// No description provided for @familyManagementParentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Family member'**
  String get familyManagementParentSubtitle;

  /// No description provided for @familyManagementInviteCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Family invite code'**
  String get familyManagementInviteCodeLabel;

  /// No description provided for @familyManagementCopyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get familyManagementCopyTooltip;

  /// No description provided for @familyManagementCopySuccess.
  ///
  /// In en, this message translates to:
  /// **'Invite code copied'**
  String get familyManagementCopySuccess;

  /// No description provided for @familyManagementSectionMembers.
  ///
  /// In en, this message translates to:
  /// **'MEMBERS'**
  String get familyManagementSectionMembers;

  /// No description provided for @familyManagementChildrenSection.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get familyManagementChildrenSection;

  /// No description provided for @familyManagementParentsSection.
  ///
  /// In en, this message translates to:
  /// **'Parents'**
  String get familyManagementParentsSection;

  /// No description provided for @familyManagementHostParentLabel.
  ///
  /// In en, this message translates to:
  /// **'(Host Parent)'**
  String get familyManagementHostParentLabel;

  /// No description provided for @familyManagementNonHostParentLabel.
  ///
  /// In en, this message translates to:
  /// **'(Non-host Parent)'**
  String get familyManagementNonHostParentLabel;

  /// No description provided for @familyManagementSetLimit.
  ///
  /// In en, this message translates to:
  /// **'Set limit'**
  String get familyManagementSetLimit;

  /// No description provided for @familyManagementUnlinkChild.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get familyManagementUnlinkChild;

  /// No description provided for @familyManagementUnlinkParent.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get familyManagementUnlinkParent;

  /// No description provided for @familyManagementNoLimit.
  ///
  /// In en, this message translates to:
  /// **'No limit'**
  String get familyManagementNoLimit;

  /// No description provided for @familyManagementEmptyChildren.
  ///
  /// In en, this message translates to:
  /// **'No members yet'**
  String get familyManagementEmptyChildren;

  /// No description provided for @familyManagementUnlinkButton.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get familyManagementUnlinkButton;

  /// No description provided for @familyManagementSetLimitButton.
  ///
  /// In en, this message translates to:
  /// **'Set Limit'**
  String get familyManagementSetLimitButton;

  /// No description provided for @familyManagementRemoveLimitButton.
  ///
  /// In en, this message translates to:
  /// **'Remove Limit'**
  String get familyManagementRemoveLimitButton;

  /// No description provided for @familyManagementLimitDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Set spending limit'**
  String get familyManagementLimitDialogTitle;

  /// No description provided for @familyManagementLimitInputHint.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get familyManagementLimitInputHint;

  /// No description provided for @familyManagementRemoveLimit.
  ///
  /// In en, this message translates to:
  /// **'Remove limit'**
  String get familyManagementRemoveLimit;

  /// No description provided for @familyManagementSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get familyManagementSave;

  /// No description provided for @familyManagementCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get familyManagementCancel;

  /// No description provided for @familyManagementUnlinkConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlink member?'**
  String get familyManagementUnlinkConfirmTitle;

  /// No description provided for @familyManagementUnlinkConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unlink {name}?'**
  String familyManagementUnlinkConfirmBody(Object name);

  /// No description provided for @familyManagementUnlinkConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get familyManagementUnlinkConfirmButton;

  /// No description provided for @familyManagementConfirmUnlinkChildTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Unlink'**
  String get familyManagementConfirmUnlinkChildTitle;

  /// No description provided for @familyManagementConfirmUnlinkChildMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unlink {childName}?'**
  String familyManagementConfirmUnlinkChildMessage(Object childName);

  /// No description provided for @familyManagementConfirmUnlinkParentTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Unlink'**
  String get familyManagementConfirmUnlinkParentTitle;

  /// No description provided for @familyManagementConfirmUnlinkParentMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unlink {parentName}?'**
  String familyManagementConfirmUnlinkParentMessage(Object parentName);

  /// No description provided for @familyManagementLimitSetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Spending limit updated'**
  String get familyManagementLimitSetSuccess;

  /// No description provided for @familyManagementLimitRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Spending limit removed'**
  String get familyManagementLimitRemovedSuccess;

  /// No description provided for @familyManagementUnlinkSuccess.
  ///
  /// In en, this message translates to:
  /// **'Unlinked successfully'**
  String get familyManagementUnlinkSuccess;

  /// No description provided for @familyManagementUnlinkError.
  ///
  /// In en, this message translates to:
  /// **'Error unlinking'**
  String get familyManagementUnlinkError;

  /// No description provided for @familyManagementSetLimitSuccess.
  ///
  /// In en, this message translates to:
  /// **'Limit set successfully'**
  String get familyManagementSetLimitSuccess;

  /// No description provided for @familyManagementSetLimitError.
  ///
  /// In en, this message translates to:
  /// **'Error setting limit'**
  String get familyManagementSetLimitError;

  /// No description provided for @familyManagementRemoveLimitSuccess.
  ///
  /// In en, this message translates to:
  /// **'Limit removed successfully'**
  String get familyManagementRemoveLimitSuccess;

  /// No description provided for @familyManagementRemoveLimitError.
  ///
  /// In en, this message translates to:
  /// **'Error removing limit'**
  String get familyManagementRemoveLimitError;

  /// No description provided for @familyManagementBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Building a future together'**
  String get familyManagementBannerTitle;

  /// No description provided for @familyManagementBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Teach your children to manage money wisely from today.'**
  String get familyManagementBannerSubtitle;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationSettingsTitle;

  /// No description provided for @notificationSettingsDailySection.
  ///
  /// In en, this message translates to:
  /// **'DAILY NOTIFICATIONS'**
  String get notificationSettingsDailySection;

  /// No description provided for @notificationSettingsEnableLabel.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get notificationSettingsEnableLabel;

  /// No description provided for @notificationSettingsTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification time'**
  String get notificationSettingsTimeLabel;

  /// No description provided for @notificationSettingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'ABOUT NOTIFICATIONS'**
  String get notificationSettingsAboutSection;

  /// No description provided for @notificationSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Notifications will remind you to check your spending every day at the selected time. This helps you maintain better financial management habits.'**
  String get notificationSettingsDescription;

  /// No description provided for @settingNotificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingNotificationsLabel;

  /// No description provided for @scheduleNotificationSmartTitle.
  ///
  /// In en, this message translates to:
  /// **'Save 15% more effectively'**
  String get scheduleNotificationSmartTitle;

  /// No description provided for @scheduleNotificationSmartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on the habits of 500 other users'**
  String get scheduleNotificationSmartSubtitle;

  /// No description provided for @notificationSettingsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Track spending'**
  String get notificationSettingsEyebrow;

  /// No description provided for @notificationSettingsHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications to stay on top of your child\'s transactions'**
  String get notificationSettingsHeroTitle;

  /// No description provided for @notificationSettingsHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get instant alerts when new spending occurs, at the time you choose to stay informed — so managing finances feels effortless.'**
  String get notificationSettingsHeroSubtitle;

  /// No description provided for @notificationSettingsEnableHint.
  ///
  /// In en, this message translates to:
  /// **'Notify when your child makes payments, transfers, or balance changes.'**
  String get notificationSettingsEnableHint;

  /// No description provided for @notificationSettingsScheduleSection.
  ///
  /// In en, this message translates to:
  /// **'Notification schedule'**
  String get notificationSettingsScheduleSection;

  /// No description provided for @notificationSettingsScheduleNote.
  ///
  /// In en, this message translates to:
  /// **'Can be changed'**
  String get notificationSettingsScheduleNote;

  /// No description provided for @notificationSettingsTimeHint.
  ///
  /// In en, this message translates to:
  /// **'The app will prioritize sending notifications during this time window to avoid interruptions during rest hours.'**
  String get notificationSettingsTimeHint;

  /// No description provided for @notificationSettingsInstructionTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications help parents track spending in time'**
  String get notificationSettingsInstructionTitle;

  /// No description provided for @notificationSettingsInstructionDesc.
  ///
  /// In en, this message translates to:
  /// **'When you enable this feature, you will receive alerts whenever a new transaction occurs or your child\'s balance changes unusually.'**
  String get notificationSettingsInstructionDesc;

  /// No description provided for @notificationSettingsTip1.
  ///
  /// In en, this message translates to:
  /// **'Tap Allow when the system asks for notification permission so everything works properly.'**
  String get notificationSettingsTip1;

  /// No description provided for @notificationSettingsTip2.
  ///
  /// In en, this message translates to:
  /// **'Choose a suitable time to avoid evening interruptions while still catching important transactions.'**
  String get notificationSettingsTip2;

  /// No description provided for @notificationSettingsTip3.
  ///
  /// In en, this message translates to:
  /// **'You will still receive instant alerts for transactions that need attention, such as over-limit spending or unusual payments.'**
  String get notificationSettingsTip3;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Family finances\nat your fingertips'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The smart app connecting parents and children, building healthy spending habits from today.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingWelcomeFeature1Title.
  ///
  /// In en, this message translates to:
  /// **'Smart management'**
  String get onboardingWelcomeFeature1Title;

  /// No description provided for @onboardingWelcomeFeature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Track income and expenses, set spending limits and monitor budgets visually.'**
  String get onboardingWelcomeFeature1Desc;

  /// No description provided for @onboardingWelcomeFeature2Title.
  ///
  /// In en, this message translates to:
  /// **'AI receipt scanning'**
  String get onboardingWelcomeFeature2Title;

  /// No description provided for @onboardingWelcomeFeature2Desc.
  ///
  /// In en, this message translates to:
  /// **'Automatic super-fast data entry with just a single screenshot.'**
  String get onboardingWelcomeFeature2Desc;

  /// No description provided for @onboardingWelcomeFeature3Title.
  ///
  /// In en, this message translates to:
  /// **'Grow with your child'**
  String get onboardingWelcomeFeature3Title;

  /// No description provided for @onboardingWelcomeFeature3Desc.
  ///
  /// In en, this message translates to:
  /// **'Teach the value of money and encourage daily savings.'**
  String get onboardingWelcomeFeature3Desc;

  /// No description provided for @onboardingWelcomeStartBtn.
  ///
  /// In en, this message translates to:
  /// **'Get started with MoniKid'**
  String get onboardingWelcomeStartBtn;

  /// No description provided for @validationEmailEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get validationEmailEmpty;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get validationPasswordEmpty;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get validationPasswordTooShort;

  /// No description provided for @validationPasswordTooLong.
  ///
  /// In en, this message translates to:
  /// **'Password must be 128 characters or fewer'**
  String get validationPasswordTooLong;

  /// No description provided for @validationUsernameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get validationUsernameEmpty;

  /// No description provided for @validationUsernameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get validationUsernameTooShort;

  /// No description provided for @validationUsernameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be 50 characters or fewer'**
  String get validationUsernameTooLong;

  /// No description provided for @validationPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get validationPhoneInvalid;

  /// No description provided for @validationConfirmPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validationConfirmPasswordEmpty;

  /// No description provided for @validationConfirmPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationConfirmPasswordMismatch;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry! Enter your registered email and we\'ll send a reset link to help you change your password.'**
  String get forgotPasswordDescription;

  /// No description provided for @forgotPasswordEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get forgotPasswordEmailPlaceholder;

  /// No description provided for @forgotPasswordSubmitBtn.
  ///
  /// In en, this message translates to:
  /// **'Get reset link'**
  String get forgotPasswordSubmitBtn;

  /// No description provided for @forgotPasswordBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get forgotPasswordBackToLogin;

  /// No description provided for @forgotPasswordEmailSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Email sent!'**
  String get forgotPasswordEmailSentTitle;

  /// No description provided for @forgotPasswordEmailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We sent a password reset link to\n{email}\n\nPlease check your inbox and click the link to change your password.'**
  String forgotPasswordEmailSentMessage(String email);

  /// No description provided for @forgotPasswordEmailSentBtn.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get forgotPasswordEmailSentBtn;

  /// No description provided for @forgotPasswordEmailHint.
  ///
  /// In en, this message translates to:
  /// **'The verification code will be sent to your email. Please check both your inbox and spam folder.'**
  String get forgotPasswordEmailHint;

  /// No description provided for @forgotPasswordChipLabel.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get forgotPasswordChipLabel;

  /// No description provided for @forgotPasswordRememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get forgotPasswordRememberPassword;

  /// No description provided for @forgotPasswordLoginAction.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get forgotPasswordLoginAction;

  /// No description provided for @txStatusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get txStatusSuccess;

  /// No description provided for @txStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get txStatusCompleted;

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// No description provided for @transactionViewAllCategories.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get transactionViewAllCategories;

  /// No description provided for @transactionDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get transactionDetailsSection;

  /// No description provided for @transactionReceiptLabel.
  ///
  /// In en, this message translates to:
  /// **'Receipt photo'**
  String get transactionReceiptLabel;

  /// No description provided for @transactionAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get transactionAddPhoto;

  /// No description provided for @transactionChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get transactionChangePhoto;

  /// No description provided for @transactionReceiptEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt will appear here'**
  String get transactionReceiptEmptyTitle;

  /// No description provided for @faqCommonQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqCommonQuestions;

  /// No description provided for @transactionReceiptScanHint.
  ///
  /// In en, this message translates to:
  /// **'System will scan automatically'**
  String get transactionReceiptScanHint;

  /// No description provided for @transactionDateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get transactionDateToday;

  /// No description provided for @successDialogDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get successDialogDefaultTitle;

  /// No description provided for @successDialogDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Operation completed.'**
  String get successDialogDefaultMessage;

  /// No description provided for @successDialogDefaultButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get successDialogDefaultButton;

  /// No description provided for @transactionHistoryEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Spending management'**
  String get transactionHistoryEyebrow;

  /// No description provided for @transactionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction history'**
  String get transactionHistoryTitle;

  /// No description provided for @transactionHistorySubhead.
  ///
  /// In en, this message translates to:
  /// **'All your income and expenses over time.'**
  String get transactionHistorySubhead;

  /// No description provided for @splashStatusLoading.
  ///
  /// In en, this message translates to:
  /// **'Setting up wallet...'**
  String get splashStatusLoading;

  /// No description provided for @notifChildDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending report today'**
  String get notifChildDailyTitle;

  /// No description provided for @notifChildDailyBody.
  ///
  /// In en, this message translates to:
  /// **'You have {pct}% of your limit left, you spent {expense} in {month}'**
  String notifChildDailyBody(int pct, String expense, String month);

  /// No description provided for @notifChildNoLimitBody.
  ///
  /// In en, this message translates to:
  /// **'You spent {expense} in {month}'**
  String notifChildNoLimitBody(String expense, String month);

  /// No description provided for @notifParentDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family spending report'**
  String get notifParentDailyTitle;

  /// No description provided for @notifParentChildBody.
  ///
  /// In en, this message translates to:
  /// **'Your child {name} has {pct}% of limit left, spent {expense}'**
  String notifParentChildBody(String name, int pct, String expense);

  /// No description provided for @notifScheduleError.
  ///
  /// In en, this message translates to:
  /// **'Cannot schedule notification. Please try again.'**
  String get notifScheduleError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

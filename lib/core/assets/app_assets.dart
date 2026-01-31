/// Centralized asset paths for MoniKid app.
/// All image and icon references should use this class.
///
/// Benefits:
/// - Single source of truth for all assets
/// - Compile-time safety (typos caught early)
/// - Easy refactoring if paths change
/// - IDE autocomplete support


// =============================================================================
// IMAGES
// =============================================================================

abstract class AppImages {
  AppImages._();

  // Logo
  static const String logo = 'assets/images/logo/logo.png';
  static const String logoDark = 'assets/images/logo/logo_dark.png';
  static const String logoText = 'assets/images/logo/logo_text.png';

  // Onboarding
  static const String onboardingWelcome =
      'assets/images/onboarding/welcome.png';
  static const String onboardingParent =
      'assets/images/onboarding/parent_intro.png';
  static const String onboardingChild =
      'assets/images/onboarding/child_intro.png';

  // Placeholders
  static const String avatarDefault =
      'assets/images/placeholders/avatar_default.png';
  static const String receiptPlaceholder =
      'assets/images/placeholders/receipt_placeholder.png';
  static const String emptyState = 'assets/images/placeholders/empty_state.png';

  // Illustrations
  static const String walletEmpty =
      'assets/images/illustrations/wallet_empty.png';
  static const String noTransactions =
      'assets/images/illustrations/no_transactions.png';
  static const String successPayment =
      'assets/images/illustrations/success_payment.png';
  static const String familyConnected =
      'assets/images/illustrations/family_connected.png';
}

// =============================================================================
// ICONS (SVG)
// =============================================================================

abstract class AppIcons {
  AppIcons._();

  // Navigation Icons
  static const String navHome = 'assets/icons/nav/home.svg';
  static const String navWallet = 'assets/icons/nav/wallet.svg';
  static const String navChildren = 'assets/icons/nav/children.svg';
  static const String navChat = 'assets/icons/nav/chat.svg';
  static const String navSettings = 'assets/icons/nav/settings.svg';
  static const String navPay = 'assets/icons/nav/pay.svg';
  static const String navReceipt = 'assets/icons/nav/receipt.svg';

  // Action Icons
  static const String actionAdd = 'assets/icons/actions/add.svg';
  static const String actionSend = 'assets/icons/actions/send.svg';
  static const String actionReceive = 'assets/icons/actions/receive.svg';
  static const String actionScan = 'assets/icons/actions/scan.svg';
  static const String actionLock = 'assets/icons/actions/lock.svg';
  static const String actionUnlock = 'assets/icons/actions/unlock.svg';
  static const String actionEdit = 'assets/icons/actions/edit.svg';
  static const String actionDelete = 'assets/icons/actions/delete.svg';
  static const String actionVerify = 'assets/icons/actions/verify.svg';

  // Status Icons
  static const String statusSuccess = 'assets/icons/status/success.svg';
  static const String statusError = 'assets/icons/status/error.svg';
  static const String statusWarning = 'assets/icons/status/warning.svg';
  static const String statusPending = 'assets/icons/status/pending.svg';
  static const String statusApproved = 'assets/icons/status/approved.svg';
  static const String statusDenied = 'assets/icons/status/denied.svg';

  // Finance Icons
  static const String financeBank = 'assets/icons/finance/bank.svg';
  static const String financeCard = 'assets/icons/finance/card.svg';
  static const String financeMoney = 'assets/icons/finance/money.svg';
  static const String financeDeposit = 'assets/icons/finance/deposit.svg';
  static const String financeWithdraw = 'assets/icons/finance/withdraw.svg';
  static const String financeTransfer = 'assets/icons/finance/transfer.svg';
  static const String financeQrCode = 'assets/icons/finance/qr_code.svg';

  // Misc Icons
  static const String miscLocation = 'assets/icons/misc/location.svg';
  static const String miscCamera = 'assets/icons/misc/camera.svg';
  static const String miscNotification = 'assets/icons/misc/notification.svg';
  static const String miscPhone = 'assets/icons/misc/phone.svg';
  static const String miscFamily = 'assets/icons/misc/family.svg';
}

// =============================================================================
// LOTTIE ANIMATIONS
// =============================================================================

abstract class AppAnimations {
  AppAnimations._();

  static const String loading = 'assets/lottie/loading.json';
  static const String success = 'assets/lottie/success.json';
  static const String emptyWallet = 'assets/lottie/empty_wallet.json';
}

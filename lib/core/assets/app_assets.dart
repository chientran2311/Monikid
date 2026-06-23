/// Centralized asset paths for MoniKid app.
/// All image and icon references should use this class.
///
/// Benefits:
/// - Single source of truth for all assets
/// - Compile-time safety (typos caught early)
/// - Easy refactoring if paths change
/// - IDE autocomplete support
library;


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
// LOTTIE ANIMATIONS
// =============================================================================

abstract class AppAnimations {
  AppAnimations._();

  static const String loading = 'assets/lottie/loading.json';
  static const String success = 'assets/lottie/success.json';
  static const String emptyWallet = 'assets/lottie/empty_wallet.json';
}

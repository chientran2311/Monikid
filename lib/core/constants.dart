/// App-wide constants and enums for MoniKid.
library;

// =============================================================================
// ENUMS
// =============================================================================

/// User role in the app (set at registration, immutable)
enum UserRole {
  parent('parent'),
  child('child');

  const UserRole(this.value);
  final String value;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => UserRole.child,
    );
  }
}

/// Family member role (more specific than UserRole)
enum FamilyRole {
  owner('owner'), // Created the family
  parent('parent'), // Spouse invited by owner
  child('child'); // Child in family

  const FamilyRole(this.value);
  final String value;

  static FamilyRole fromString(String value) {
    return FamilyRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FamilyRole.child,
    );
  }
}

/// Wallet type
enum WalletType {
  parent('parent'),
  child('child');

  const WalletType(this.value);
  final String value;

  static WalletType fromString(String value) {
    return WalletType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => WalletType.child,
    );
  }
}

/// Transaction types
enum TransactionType {
  bankDeposit('bank_deposit'), // Mock bank → Parent wallet
  bankWithdraw('bank_withdraw'), // Parent wallet → Mock bank
  allowance('allowance'), // Parent wallet → Child wallet
  payment('payment'), // Child wallet → Merchant (QR)
  requestTransfer('request_transfer'); // Approved money request

  const TransactionType(this.value);
  final String value;

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionType.payment,
    );
  }

  String get displayName {
    switch (this) {
      case TransactionType.bankDeposit:
        return 'Nạp tiền';
      case TransactionType.bankWithdraw:
        return 'Rút tiền';
      case TransactionType.allowance:
        return 'Tiền tiêu vặt';
      case TransactionType.payment:
        return 'Thanh toán';
      case TransactionType.requestTransfer:
        return 'Chuyển tiền yêu cầu';
    }
  }
}

/// Money request status
enum RequestStatus {
  pending('pending'),
  approved('approved'),
  denied('denied');

  const RequestStatus(this.value);
  final String value;

  static RequestStatus fromString(String value) {
    return RequestStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => RequestStatus.pending,
    );
  }

  String get displayName {
    switch (this) {
      case RequestStatus.pending:
        return 'Đang chờ';
      case RequestStatus.approved:
        return 'Đã duyệt';
      case RequestStatus.denied:
        return 'Từ chối';
    }
  }
}

/// Allowance frequency
enum AllowanceFrequency {
  daily('daily'),
  weekly('weekly'),
  monthly('monthly');

  const AllowanceFrequency(this.value);
  final String value;

  static AllowanceFrequency fromString(String value) {
    return AllowanceFrequency.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AllowanceFrequency.weekly,
    );
  }

  String get displayName {
    switch (this) {
      case AllowanceFrequency.daily:
        return 'Hàng ngày';
      case AllowanceFrequency.weekly:
        return 'Hàng tuần';
      case AllowanceFrequency.monthly:
        return 'Hàng tháng';
    }
  }
}

/// Location log source
enum LocationSource {
  interval('interval'), // 15-minute background update
  transaction('transaction'); // Captured during payment

  const LocationSource(this.value);
  final String value;

  static LocationSource fromString(String value) {
    return LocationSource.values.firstWhere(
      (e) => e.value == value,
      orElse: () => LocationSource.interval,
    );
  }
}

// =============================================================================
// APP CONSTANTS
// =============================================================================

abstract class AppConstants {
  AppConstants._();
  Api api = Api();
  final String url = api.supabaseUrl;
  final String anonKey = api.supabaseAnonKey;
  // App Info
  static const String appName = 'MoniKid';
  static const String appVersion = '1.0.0';

  // Supabase (will be replaced with actual values)
  static const String supabaseUrl = '$url';
  static const String supabaseAnonKey = '$anonKey';

  // Mock Bank
  static const double initialMockBankBalance = 10000000; // 10M VND
  static const String defaultBankName = 'Mock Bank';

  // Location
  static const int locationIntervalMinutes = 15;

  // OTP (for demo)
  static const String demoOtpCode = '123456';
  static const int otpLength = 6;

  // Invite Code
  static const int inviteCodeLength = 6;

  // Limits
  static const double maxTransactionAmount = 100000000; // 100M VND
  static const double minTransactionAmount = 1000; // 1K VND

  // Currency
  static const String currencySymbol = '₫';
  static const String currencyCode = 'VND';
  static const String currencyLocale = 'vi_VN';
}

// =============================================================================
// STORAGE KEYS (SharedPreferences)
// =============================================================================

abstract class StorageKeys {
  StorageKeys._();

  static const String userId = 'user_id';
  static const String userRole = 'user_role';
  static const String familyId = 'family_id';
  static const String fcmToken = 'fcm_token';
  static const String isOnboarded = 'is_onboarded';
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
}

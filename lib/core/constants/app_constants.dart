class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'MoniKid';
  static const String appVersion = '1.0.0';

  // Mock Bank Defaults (Hardcode URL cho simulator/emulator là ok)
  static const double initialMockBankBalance = 10000000; // 10M VND
  static const String defaultBankName = 'Mock Bank';
  static const String mockBankApiUrlAndroid = 'http://10.0.2.2:3001/api/v1';
  static const String mockBankApiUrlIos = 'http://127.0.0.1:3001/api/v1';

  // Location Rules
  static const int locationIntervalMinutes = 15;

  // OTP & Invite Rules
  static const String demoOtpCode = '123456';
  static const int otpLength = 6;
  static const int inviteCodeLength = 6;

  // Transaction Limits
  static const double maxTransactionAmount = 100000000; // 100M VND
  static const double minTransactionAmount = 1000; // 1K VND

  // Currency Formatting
  static const String currencySymbol = '₫';
  static const String currencyCode = 'VND';
  static const String currencyLocale = 'vi_VN';
}
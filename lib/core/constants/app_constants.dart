class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'MoniKid';
  static const String appVersion = '1.0.0';


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
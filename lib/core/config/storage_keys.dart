/// Centralized configuration for all local and secure storage keys in the app.
class StorageKeys {
  StorageKeys._();

  // Local Storage Keys
  static const String isOnboarded = 'is_onboarded';
  static const String themeModeKey = 'theme_mode';

  // Secure Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String hashedPinKey = 'hashed_pin';
}

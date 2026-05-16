/// Centralized configuration for all local and secure storage keys in the app.
class StorageKeys {
  StorageKeys._();

  // Local Storage Keys
  static const String isOnboarded = 'is_onboarded';
  static const String hasSignedInBefore = 'has_signed_in_before';
  static const String themeModeKey = 'theme_mode';
  static const String monthlyLimitMinorPrefix = 'student_monthly_limit_minor';

  // Secure Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String hashedPinKey = 'hashed_pin';
  static const String pinFailedCountKey = 'pin_failed_count';
  static const String pinLockedUntilKey = 'pin_locked_until';
  static const String userGeminiApiKey = 'user_gemini_api_key';

  // Local Storage Keys for feature flags
  static const String hasStoredGeminiApiKey = 'has_stored_gemini_api_key';

  // AI model selection
  static const String selectedAiModel = 'selected_ai_model';
  static const String useLocalModel = 'useLocalModel';
}

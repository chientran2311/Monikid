/// Authentication error codes used by auth repository.
/// Each enum value represents a specific auth failure that can be displayed to users.
enum AuthErrorEnumRepo {
  /// Firebase authentication succeeded but did not return a User object
  firebaseUserNull,

  /// User authenticated but no Firestore account document exists
  accountNotFound,

  /// Firestore account document exists but fails validation
  accountInvalid,

  /// Failed to create initial account document in Firestore
  accountCreationFailed,

  /// Failed to read back account after creation
  accountReadbackFailed,

  /// FirebaseAuthException occurred (e.g., wrong-password, user-not-found)
  firebaseAuthException,

  /// FirebaseException occurred during Firestore operations
  firestoreException,

  /// Unknown/unexpected error
  unknownError;

  /// Get user-friendly error message for display in snackbar
  String get message {
    switch (this) {
      case AuthErrorEnumRepo.firebaseUserNull:
        return 'Sign in failed. Firebase did not return a user.';
      case AuthErrorEnumRepo.accountNotFound:
        return 'Account setup is incomplete. Please contact support.';
      case AuthErrorEnumRepo.accountInvalid:
        return 'Account setup is incomplete. Please contact support.';
      case AuthErrorEnumRepo.accountCreationFailed:
        return 'Sign up failed. Could not create account.';
      case AuthErrorEnumRepo.accountReadbackFailed:
        return 'Sign up failed. Could not verify account creation.';
      case AuthErrorEnumRepo.firebaseAuthException:
        return 'Authentication failed. Please check your credentials.';
      case AuthErrorEnumRepo.firestoreException:
        return 'Database error. Please try again later.';
      case AuthErrorEnumRepo.unknownError:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

/// Result wrapper for auth repository operations
class AuthResult {
  const AuthResult({this.response, this.error});

  final dynamic response; // AuthResponse or AccountModel
  final AuthErrorEnumRepo? error;

  bool get isSuccess => error == null && response != null;
  bool get isFailure => error != null;
}

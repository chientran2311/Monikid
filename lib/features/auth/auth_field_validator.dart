import 'auth_field_error.dart';

abstract final class AuthFieldValidator {
  static final _emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final _phoneRegex = RegExp(r'^(0|\+84)\d{9,10}$');

  static AuthFieldError email(String value) {
    final v = value.trim();
    if (v.isEmpty) return AuthFieldError.emailEmpty;
    if (!_emailRegex.hasMatch(v)) return AuthFieldError.emailInvalid;
    return AuthFieldError.none;
  }

  static AuthFieldError password(String value) {
    if (value.isEmpty) return AuthFieldError.passwordEmpty;
    if (value.length < 6) return AuthFieldError.passwordTooShort;
    if (value.length > 128) return AuthFieldError.passwordTooLong;
    return AuthFieldError.none;
  }

  static AuthFieldError username(String value) {
    final v = value.trim();
    if (v.isEmpty) return AuthFieldError.usernameEmpty;
    if (v.length < 2) return AuthFieldError.usernameTooShort;
    if (v.length > 50) return AuthFieldError.usernameTooLong;
    return AuthFieldError.none;
  }

  static AuthFieldError phone(String value) {
    final v = value.trim();
    if (v.isEmpty) return AuthFieldError.none; // phone is optional
    if (!_phoneRegex.hasMatch(v)) return AuthFieldError.phoneInvalid;
    return AuthFieldError.none;
  }

  static AuthFieldError confirmPassword(String confirm, String password) {
    if (confirm.isEmpty) return AuthFieldError.confirmPasswordEmpty;
    if (confirm != password) return AuthFieldError.confirmPasswordMismatch;
    return AuthFieldError.none;
  }
}

import 'package:flutter/material.dart';

import 'package:monikid/core/utils/build_context_x.dart';

enum AuthFieldError {
  none,
  emailEmpty,
  emailInvalid,
  passwordEmpty,
  passwordTooShort,
  passwordTooLong,
  usernameEmpty,
  usernameTooShort,
  usernameTooLong,
  phoneInvalid,
  confirmPasswordEmpty,
  confirmPasswordMismatch,
}

extension AuthFieldErrorX on AuthFieldError {
  String? message(BuildContext context) {
    final s = context.l10n;
    return switch (this) {
      AuthFieldError.none => null,
      AuthFieldError.emailEmpty => s.validationEmailEmpty,
      AuthFieldError.emailInvalid => s.validationEmailInvalid,
      AuthFieldError.passwordEmpty => s.validationPasswordEmpty,
      AuthFieldError.passwordTooShort => s.validationPasswordTooShort,
      AuthFieldError.passwordTooLong => s.validationPasswordTooLong,
      AuthFieldError.usernameEmpty => s.validationUsernameEmpty,
      AuthFieldError.usernameTooShort => s.validationUsernameTooShort,
      AuthFieldError.usernameTooLong => s.validationUsernameTooLong,
      AuthFieldError.phoneInvalid => s.validationPhoneInvalid,
      AuthFieldError.confirmPasswordEmpty => s.validationConfirmPasswordEmpty,
      AuthFieldError.confirmPasswordMismatch => s.validationConfirmPasswordMismatch,
    };
  }
}

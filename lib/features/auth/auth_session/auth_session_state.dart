import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/auth/auth_status.dart';
import 'package:monikid/models/entities/account/account_model.dart';

part 'auth_session_state.freezed.dart';

enum PinVerificationStatus {
  unknown,
  required,
  verified,
}

@freezed
abstract class AuthSessionState with _$AuthSessionState {
  const factory AuthSessionState({
    @Default(AuthStatus.initial) AuthStatus status,
    User? firebaseUser,
    AccountModel? account,
    @Default(PinVerificationStatus.unknown)
    PinVerificationStatus pinVerificationStatus,
    String? errorMessage,
  }) = _AuthSessionState;

  const AuthSessionState._();

  User? get user => firebaseUser;
  String? get userRole => account?.role;
  bool get isAuthenticated => status == AuthStatus.isAuthenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isInitial => status == AuthStatus.initial;
  bool get isLoading => status == AuthStatus.isLoading;
  bool get isAccountIncomplete => status == AuthStatus.accountIncomplete;
  bool get isPinVerified => pinVerificationStatus == PinVerificationStatus.verified;
  bool get requiresPinVerification =>
      isAuthenticated && pinVerificationStatus == PinVerificationStatus.required;
}

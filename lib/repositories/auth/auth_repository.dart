import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_error_enum.dart';
import 'package:monikid/models/entities/account/account_model.dart';
import 'package:monikid/models/entities/auth/params/auth_param.dart';
import 'package:monikid/models/entities/auth/responses/auth_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return getIt<AuthRepository>();
}

abstract class AuthRepository {
  User? get currentUser;

  Stream<User?> get authStateChanges;

  Future<AuthResult> signUp(SignUpParam param);

  Future<AuthResult> signIn(SignInParam param);

  Future<void> signOut();

  Future<void> resetPassword(ResetPasswordParam param);

  Future<AccountModel?> fetchAccountByUid(String uid);

  Future<AuthResult> createInitialAccount({
    required String uid,
    required String email,
    required String displayName,
    required String role,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._firebaseAuth, this._firestore, this._logger);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<AuthResult> signIn(SignInParam param) async {
    try {
      _logger.i('Attempting sign in for email: ${param.email}');
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: param.email,
        password: param.password,
      );

      final user = credential.user;
      if (user == null) {
        _logger.e('Sign in failed: Firebase did not return a user.');
        return const AuthResult(error: AuthErrorEnumRepo.firebaseUserNull);
      }

      final account = await fetchAccountByUid(user.uid);
      if (account == null) {
        _logger.w(
          'Sign in blocked: no Firestore account document for uid=${user.uid}.',
        );
        await signOut();
        return const AuthResult(error: AuthErrorEnumRepo.accountNotFound);
      }

      if (!account.isValid) {
        _logger.w(
          'Sign in blocked: invalid Firestore account for uid=${user.uid}. '
          'Issues: ${account.validationIssues.join(', ')}',
        );
        await signOut();
        return const AuthResult(error: AuthErrorEnumRepo.accountInvalid);
      }

      return AuthResult(response: AuthResponse(user: user, role: account.role));
    } on FirebaseAuthException catch (e, stackTrace) {
      _logger.e('FirebaseAuth error during sign in', error: e, stackTrace: stackTrace);
      return const AuthResult(error: AuthErrorEnumRepo.firebaseAuthException);
    } catch (e, stackTrace) {
      _logger.e('Unexpected error during sign in', error: e, stackTrace: stackTrace);
      return const AuthResult(error: AuthErrorEnumRepo.unknownError);
    }
  }

  @override
  Future<AuthResult> signUp(SignUpParam param) async {
    User? createdUser;
    try {
      _logger.i('Starting sign up process for email: ${param.email}');

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: param.email,
        password: param.password,
      );

      createdUser = credential.user;
      if (createdUser == null) {
        _logger.e('Sign up failed: Firebase did not return a user.');
        return const AuthResult(error: AuthErrorEnumRepo.firebaseUserNull);
      }

      final accountResult = await createInitialAccount(
        uid: createdUser.uid,
        email: param.email,
        displayName: param.fullName,
        role: param.role,
      );

      if (accountResult.isFailure) {
        await _signOutAfterFailedSignUp(createdUser);
        return accountResult;
      }

      final account = accountResult.response as AccountModel;
      if (!account.isValid) {
        _logger.w(
          'Sign up produced an invalid Firestore account for uid=${createdUser.uid}. '
          'Issues: ${account.validationIssues.join(', ')}',
        );
        await signOut();
        return const AuthResult(error: AuthErrorEnumRepo.accountInvalid);
      }

      final resolvedUser = _firebaseAuth.currentUser ?? createdUser;
      return AuthResult(response: AuthResponse(user: resolvedUser, role: account.role));
    } on FirebaseAuthException catch (e, stackTrace) {
      await _signOutAfterFailedSignUp(createdUser);
      _logger.e(
        'Firebase Auth error during sign up',
        error: e,
        stackTrace: stackTrace,
      );
      return const AuthResult(error: AuthErrorEnumRepo.firebaseAuthException);
    } on FirebaseException catch (e, stackTrace) {
      await _signOutAfterFailedSignUp(createdUser);
      _logger.e(
        'Firestore error during sign up',
        error: e,
        stackTrace: stackTrace,
      );
      return const AuthResult(error: AuthErrorEnumRepo.firestoreException);
    } catch (e, stackTrace) {
      await _signOutAfterFailedSignUp(createdUser);
      _logger.e(
        'Unexpected error during sign up',
        error: e,
        stackTrace: stackTrace,
      );
      return const AuthResult(error: AuthErrorEnumRepo.unknownError);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _logger.i('Signing out user: ${_firebaseAuth.currentUser?.email}');
      await _firebaseAuth.signOut();
    } catch (e, stackTrace) {
      _logger.e('Sign out failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordParam param) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: param.email);
      _logger.i('Password reset email sent to ${param.email}');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logger.e(
        'resetPassword failed with code=${e.code}',
        error: e,
        stackTrace: stackTrace,
      );
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests. Please try again later.';
          break;
        default:
          errorMessage =
              e.message ?? 'An unexpected error occurred while sending the reset email.';
      }
      throw Exception(errorMessage);
    } catch (e, stackTrace) {
      _logger.e('resetPassword system error', error: e, stackTrace: stackTrace);
      throw Exception('System error: ${e.toString()}');
    }
  }

  @override
  Future<AccountModel?> fetchAccountByUid(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        _logger.w('No user document found in Firestore for uid=$uid.');
        return null;
      }

      final data = doc.data();
      if (data == null) {
        _logger.w('Firestore returned null data for uid=$uid.');
        return null;
      }

      final account = AccountModel.fromFirestore(data);
      _logger.i(
        'Fetched account uid=$uid role=${account.role} familyId=${account.familyId}',
      );
      if (!account.isValid) {
        _logger.w(
          'Fetched account has validation issues for uid=$uid: '
          '${account.validationIssues.join(', ')}',
        );
      }
      return account;
    } catch (e, stackTrace) {
      _logger.e('fetchAccountByUid failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<AuthResult> createInitialAccount({
    required String uid,
    required String email,
    required String displayName,
    required String role,
  }) async {
    try {
      final normalizedRole = role.trim().toLowerCase();
      final now = DateTime.now();

      final account = AccountModel(
        uid: uid,
        email: email.trim().toLowerCase(),
        displayName: displayName.trim(),
        photoUrl: 'https://i.pravatar.cc/150?img=11',
        role: normalizedRole,
        familyId: null,
        createdAt: now,
        updatedAt: now,
      );

      await _firestore.collection('users').doc(uid).set(account.toFirestore());

      final createdAccount = await fetchAccountByUid(uid);
      if (createdAccount == null) {
        _logger.e('Failed to read back the account after creation for uid=$uid');
        return const AuthResult(error: AuthErrorEnumRepo.accountReadbackFailed);
      }

      return AuthResult(response: createdAccount);
    } catch (e, stackTrace) {
      _logger.e('createInitialAccount failed', error: e, stackTrace: stackTrace);
      return const AuthResult(error: AuthErrorEnumRepo.accountCreationFailed);
    }
  }

  Future<void> _signOutAfterFailedSignUp(User? createdUser) async {
    if (createdUser == null) {
      return;
    }

    final currentUser = _firebaseAuth.currentUser;
    if (currentUser?.uid != createdUser.uid) {
      return;
    }

    try {
      await _firebaseAuth.signOut();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to clean up Firebase session after sign up error.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  User? get currentUser;
  
  Stream<User?> get authStateChanges;

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  });

  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
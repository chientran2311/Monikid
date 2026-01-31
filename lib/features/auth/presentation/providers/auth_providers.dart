import 'package:get_it/get_it.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Dòng này phải trùng tên file: auth_providers -> auth_providers.g.dart
part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return GetIt.I<AuthRepository>();
}

@riverpod
Stream<bool> authStateChanges(AuthStateChangesRef ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges.map((event) => event.session != null);
}

@riverpod
Future<User?> currentUser(CurrentUserRef ref) async {
  final repo = ref.watch(authRepositoryProvider);
  await repo.authStateChanges.first; // Wait for auth state to be ready
  return repo.currentUser;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/repositories/link_family/link_family_repository.dart';

part 'invite_code_provider.g.dart';

/// Fetches (or lazily generates) the invite code for [familyId].
///
/// Callers invalidate this provider to retry on error.
@riverpod
Future<String> familyInviteCode(Ref ref, String familyId) async {
  final repo = ref.watch(linkFamilyRepositoryProvider);
  return repo.ensureInviteCode(familyId);
}

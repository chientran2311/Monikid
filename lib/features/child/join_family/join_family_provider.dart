import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';
import 'package:monikid/repositories/link_family/link_family_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'join_family_provider.g.dart';

@Riverpod(keepAlive: false)
class JoinFamilyNotifier extends _$JoinFamilyNotifier {
  late final Logger _logger;
  late final LinkFamilyRepository _familyRepo;

  @override
  JoinFamilyState build() {
    _logger = getIt<Logger>();
    _familyRepo = getIt<LinkFamilyRepository>();
    return const JoinFamilyState();
  }

  Future<void> joinWithCode(String code) async {
    final trimmed = code.trim();

    if (!RegExp(r'^\d{6}$').hasMatch(trimmed)) {
      state = state.copyWith(
        status: JoinFamilyStatus.error,
        errorMessage: 'invalid_code',
      );
      return;
    }

    state = state.copyWith(status: JoinFamilyStatus.loading, errorMessage: null);

    try {
      final authState = ref.read(authSessionProvider);
      final uid = authState.user?.uid;
      if (uid == null) throw Exception('joinWithCode: no authenticated user.');

      final alreadyInFamily = await _familyRepo.isUserAlreadyInFamily(uid);
      if (alreadyInFamily) {
        state = state.copyWith(
          status: JoinFamilyStatus.error,
          errorMessage: 'already_member',
        );
        return;
      }

      final family = await _familyRepo.getFamilyByInviteCode(trimmed);
      if (family == null) {
        _logger.w('joinWithCode: no active family found for code=$trimmed');
        state = state.copyWith(
          status: JoinFamilyStatus.error,
          errorMessage: 'invalid_code',
        );
        return;
      }

      _logger.i(
        'joinWithCode: joining family=${family.familyId} uid=$uid code=$trimmed',
      );

      await _familyRepo.joinFamily(
        familyId: family.familyId,
        userId: uid,
        userName: authState.account?.displayName ?? '',
        role: authState.account?.role ?? 'child',
        avatarUrl: authState.user?.photoURL,
      );

      await ref.read(authSessionProvider.notifier).refreshSession();

      state = state.copyWith(status: JoinFamilyStatus.success);
      _logger.i('joinWithCode: success for uid=$uid family=${family.familyId}');
    } catch (error, stackTrace) {
      _logger.e('joinWithCode failed.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        status: JoinFamilyStatus.error,
        errorMessage: 'unknown',
      );
    }
  }

  Future<void> leaveFamily() async {
    final authState = ref.read(authSessionProvider);
    final uid = authState.user?.uid;
    final familyId = authState.account?.familyId;
    if (uid == null || familyId == null) return;

    state = state.copyWith(status: JoinFamilyStatus.loading, errorMessage: null);
    try {
      await _familyRepo.removeChild(familyId: familyId, childId: uid);
      await ref.read(authSessionProvider.notifier).refreshSession();
      state = state.copyWith(status: JoinFamilyStatus.success);
      _logger.i('leaveFamily: success for uid=$uid family=$familyId');
    } catch (error, stackTrace) {
      _logger.e('leaveFamily failed.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        status: JoinFamilyStatus.error,
        errorMessage: 'leave_failed',
      );
    }
  }

  void reset() {
    state = const JoinFamilyState();
  }
}

@riverpod
Future<FamilyModel?> linkedFamily(Ref ref) async {
  final familyId = ref.watch(authSessionProvider).account?.familyId;
  if (familyId == null) return null;
  return getIt<LinkFamilyRepository>().getFamilyById(familyId);
}

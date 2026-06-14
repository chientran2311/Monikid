import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
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
      );

      // Patch authSession directly — no refreshSession needed.
      // refreshSession would re-read Firestore which may still serve stale
      // cache and overwrite familyId back to null, causing providers to return empty.
      ref
          .read(authSessionProvider.notifier)
          .patchAccountFamilyId(family.familyId);

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
      await _familyRepo.removeMember(familyId: familyId, memberUid: uid);
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
  final logger = getIt<Logger>();
  final familyId = ref.watch(authSessionProvider).account?.familyId;
  if (familyId == null) {
    logger.w('linkedFamily: familyId is null — skipping fetch.');
    return null;
  }
  logger.i('linkedFamily: fetching familyId=$familyId');
  final family = await getIt<LinkFamilyRepository>().getFamilyById(familyId);
  if (family == null) {
    logger.w('linkedFamily: no family document found for familyId=$familyId');
  } else {
    logger.i('linkedFamily: loaded family=${family.familyId}');
  }
  return family;
}

@riverpod
Stream<List<FamilyMemberModel>> familyMembers(Ref ref) {
  final logger = getIt<Logger>();
  final familyId = ref.watch(authSessionProvider).account?.familyId;
  if (familyId == null) {
    logger.w('familyMembers: familyId is null — returning empty stream.');
    return Stream.value([]);
  }
  logger.i('familyMembers: subscribing to familyId=$familyId');
  return getIt<LinkFamilyRepository>().watchFamilyMembers(familyId).map(
    (members) {
      if (members.isEmpty) {
        logger.w('familyMembers: stream emitted 0 members for familyId=$familyId');
      } else {
        logger.i('familyMembers: stream emitted ${members.length} members.');
      }
      return members;
    },
  );
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/parent/family_management/family_management_state.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/repositories/link_family/link_family_repository.dart';
import 'package:monikid/repositories/parent_dashboard/parent_dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_management_notifier.g.dart';

@riverpod
class FamilyManagementNotifier extends _$FamilyManagementNotifier {
  late final LinkFamilyRepository _linkFamilyRepo;
  late final ParentDashboardRepository _parentDashboardRepo;
  late final FirebaseFirestore _firestore;
  late final Logger _logger;
  StreamSubscription<List<FamilyMemberModel>>? _membersSubscription;

  @override
  FamilyManagementState build() {
    _linkFamilyRepo = getIt<LinkFamilyRepository>();
    _parentDashboardRepo = getIt<ParentDashboardRepository>();
    _firestore = getIt<FirebaseFirestore>();
    _logger = getIt<Logger>();

    ref.onDispose(() {
      _membersSubscription?.cancel();
    });

    return const FamilyManagementState();
  }

  Future<void> loadFamily() async {
    state = state.copyWith(status: FamilyManagementStatus.loading);

    try {
      final authState = ref.read(authSessionProvider);
      final familyId = authState.account?.familyId;

      if (familyId == null || familyId.isEmpty) {
        state = state.copyWith(
          status: FamilyManagementStatus.empty,
          errorMessage: 'No family found',
        );
        return;
      }

      final family = await _linkFamilyRepo.getFamilyById(familyId);

      if (family == null) {
        state = state.copyWith(
          status: FamilyManagementStatus.empty,
          errorMessage: 'Family not found',
        );
        return;
      }

      state = state.copyWith(
        family: family,
        status: FamilyManagementStatus.success,
      );

      await _membersSubscription?.cancel();
      _membersSubscription = _linkFamilyRepo
          .watchFamilyMembers(familyId)
          .listen((membersList) {
        state = state.copyWith(members: membersList);
        _loadMonthlyLimitsForChildren();
      });
    } catch (e, stackTrace) {
      _logger.e('Error loading family', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        status: FamilyManagementStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _loadMonthlyLimitsForChildren() async {
    final children = state.childMembers;
    if (children.isEmpty) return;

    final limits = <String, int?>{};
    for (final child in children) {
      try {
        final doc = await _firestore.collection('users').doc(child.uid).get();
        if (doc.exists) {
          final data = doc.data();
          limits[child.uid] = (data?['monthly_limit_minor'] as num?)?.toInt();
        }
      } catch (e) {
        _logger.w('Failed to load limit for child ${child.uid}: $e');
      }
    }
    state = state.copyWith(monthlyLimits: limits);
  }

  Future<void> unlinkChild(String childUid) async {
    final familyId = state.family?.familyId;
    if (familyId == null) return;
    state = state.copyWith(isProcessing: true);
    try {
      await _linkFamilyRepo.removeChild(familyId: familyId, childId: childUid);
      state = state.copyWith(isProcessing: false);
    } catch (e, stackTrace) {
      _logger.e('Error unlinking child', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> unlinkParentMember(String parentUid) async {
    final familyId = state.family?.familyId;
    if (familyId == null) return;
    state = state.copyWith(isProcessing: true);
    try {
      await _linkFamilyRepo.removeParentMember(
        familyId: familyId,
        memberUid: parentUid,
      );
      state = state.copyWith(isProcessing: false);
    } catch (e, stackTrace) {
      _logger.e('Error unlinking parent', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> setChildLimit(String childUid, int amountMinor) async {
    state = state.copyWith(isProcessing: true);
    try {
      await _parentDashboardRepo.setChildMonthlyLimit(
        childUid: childUid,
        amountMinor: amountMinor,
      );
      final updatedLimits = Map<String, int?>.from(state.monthlyLimits);
      updatedLimits[childUid] = amountMinor;
      state = state.copyWith(
        isProcessing: false,
        monthlyLimits: updatedLimits,
      );
    } catch (e, stackTrace) {
      _logger.e('Error setting child limit', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> removeChildLimit(String childUid) async {
    state = state.copyWith(isProcessing: true);
    try {
      await _parentDashboardRepo.removeChildMonthlyLimit(childUid: childUid);
      final updatedLimits = Map<String, int?>.from(state.monthlyLimits);
      updatedLimits[childUid] = null;
      state = state.copyWith(
        isProcessing: false,
        monthlyLimits: updatedLimits,
      );
    } catch (e, stackTrace) {
      _logger.e('Error removing child limit', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }

  bool canAddNonHostParent() {
    final parents = state.parentMembers;
    return parents.length < 2;
  }
}

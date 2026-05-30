import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/parent/home/parent_home_state.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/link_family/link_family_repository.dart';
import 'package:monikid/repositories/parent_dashboard/parent_dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parent_home_notifier.g.dart';

@riverpod
class ParentHomeNotifier extends _$ParentHomeNotifier {
  late final LinkFamilyRepository _familyRepo;
  late final ParentDashboardRepository _dashRepo;
  late final Logger _logger;

  @override
  ParentHomeState build() {
    _familyRepo = getIt<LinkFamilyRepository>();
    _dashRepo = getIt<ParentDashboardRepository>();
    _logger = getIt<Logger>();
    return const ParentHomeState();
  }

  String get _currentMonthKey => DateFormat('yyyy-MM').format(DateTime.now());

  Future<void> onInit() async {
    state = state.copyWith(status: ParentHomeStatus.loading);
    try {
      final authState = ref.read(authSessionProvider);
      final familyId = authState.account?.familyId;

      if (familyId == null || familyId.isEmpty) {
        state = state.copyWith(status: ParentHomeStatus.noFamily);
        return;
      }

      final results = await Future.wait([
        _familyRepo.getFamilyById(familyId),
        _familyRepo.watchFamilyMembers(familyId).first,
      ]);

      final family = results[0] as dynamic;
      final members = (results[1] as List).cast<FamilyMemberModel>();

      if (family == null) {
        state = state.copyWith(status: ParentHomeStatus.noFamily);
        return;
      }

      state = state.copyWith(
        status: ParentHomeStatus.hasFamily,
        family: family,
        members: members,
      );

      if (members.isNotEmpty) {
        await selectMember(members.first.uid);
      }
    } catch (error, stackTrace) {
      _logger.e('Failed to init parent home', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        status: ParentHomeStatus.error,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> selectMember(String uid) async {
    // Validate member còn trong family không
    final memberExists = state.members.any((m) => m.uid == uid);
    if (!memberExists) {
      _logger.w('Member $uid no longer in family, skipping select');
      state = state.copyWith(
        selectedMemberId: null,
        selectedMemberTransactions: const [],
        selectedMemberExpenseMinor: 0,
        selectedMemberIncomeMinor: 0,
        isLoadingMemberData: false,
      );
      return;
    }

    state = state.copyWith(
      selectedMemberId: uid,
      isLoadingMemberData: true,
    );
    try {
      final txsFuture = _dashRepo.getChildRecentTransactions(
        childUid: uid,
        limit: 5,
      );
      final summaryFuture = _dashRepo.getChildMonthlySummary(
        childUid: uid,
        monthKey: _currentMonthKey,
      );

      final txs = await txsFuture;
      final summary = await summaryFuture;

      state = state.copyWith(
        selectedMemberTransactions: txs,
        selectedMemberExpenseMinor: summary.expenseMinor,
        selectedMemberIncomeMinor: summary.incomeMinor,
        isLoadingMemberData: false,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load data for member $uid',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoadingMemberData: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> createFamily() async {
    final authState = ref.read(authSessionProvider);
    final parentId = authState.account?.uid;
    final parentName = authState.account?.displayName ?? '';
    if (parentId == null) return;

    state = state.copyWith(isCreatingFamily: true);
    try {
      final family = await _familyRepo.createFamily(
        parentId: parentId,
        parentName: parentName,
      );
      if (family != null) {
        state = state.copyWith(
          isCreatingFamily: false,
          status: ParentHomeStatus.hasFamily,
          family: family,
          members: const [],
          selectedMemberId: null,
          selectedMemberTransactions: const [],
        );
        await ref.read(authSessionProvider.notifier).refreshSession();
      }
    } catch (error, stackTrace) {
      _logger.e('Failed to create family', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        isCreatingFamily: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> refresh() async {
    final familyId = state.family?.familyId;
    if (familyId == null) {
      await onInit();
      return;
    }

    try {
      final members = await _familyRepo.watchFamilyMembers(familyId).first;
      state = state.copyWith(members: members);
      
      if (members.isEmpty) {
        // Không còn member nào → clear selection
        state = state.copyWith(
          selectedMemberId: null,
          selectedMemberTransactions: const [],
          selectedMemberExpenseMinor: 0,
          selectedMemberIncomeMinor: 0,
        );
        return;
      }

      final selectedId = state.selectedMemberId;
      final stillExists = selectedId != null && 
          members.any((m) => m.uid == selectedId);

      if (stillExists) {
        // Member còn tồn tại → re-select
        await selectMember(selectedId);
      } else {
        // Member đã leave → chọn member đầu tiên
        await selectMember(members.first.uid);
      }
    } catch (error, stackTrace) {
      _logger.e('Failed to refresh parent home', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> setChildLimit({
    required String childUid,
    required int amountMinor,
  }) async {
    try {
      await _dashRepo.setChildMonthlyLimit(
        childUid: childUid,
        amountMinor: amountMinor,
      );
      _logger.i('Set limit amountMinor=$amountMinor for child=$childUid.');
    } catch (error, stackTrace) {
      _logger.e('Failed to set child limit.', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  List<TransactionModel> get selectedMemberTransactions =>
      state.selectedMemberTransactions;
}

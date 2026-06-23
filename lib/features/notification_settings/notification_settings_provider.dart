import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/notification_settings/notification_settings_state.dart';
import 'package:monikid/repositories/link_family/link_family_repository.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';
import 'package:monikid/repositories/parent_dashboard/parent_dashboard_repository.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';

part 'notification_settings_provider.g.dart';

@riverpod
class NotificationSettingsNotifier extends _$NotificationSettingsNotifier {
  late Logger _logger;
  late NotificationRepository _repo;

  @override
  NotificationSettingsState build() {
    _logger = getIt<Logger>();
    _repo = getIt<NotificationRepository>();
    Future.microtask(_loadSettings);
    return const NotificationSettingsState();
  }

  Future<void> _loadSettings() async {
    state = state.copyWith(status: NotificationSettingsStatus.loading);
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool(NotifPrefsKeys.enabled) ?? false;
      final hour = prefs.getInt(NotifPrefsKeys.hour) ?? 21;
      final minute = prefs.getInt(NotifPrefsKeys.minute) ?? 0;
      final role = ref.read(authSessionProvider).userRole;
      _logger.i(
        'NotificationSettingsNotifier._loadSettings: loaded from prefs '
        'enabled=$enabled hour=$hour minute=$minute role=$role '
        '(prefs are global, NOT scoped per account)',
      );
      state = state.copyWith(
        status: NotificationSettingsStatus.success,
        enabled: enabled,
        hour: hour,
        minute: minute,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationSettingsNotifier._loadSettings failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: NotificationSettingsStatus.error,
        errorMessage: 'Failed to load notification settings.',
      );
    }
  }

  Future<void> toggleEnabled(bool value) async {
    _logger.d('NotificationSettingsNotifier.toggleEnabled: value=$value');
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(NotifPrefsKeys.enabled, value);
      final readBack = prefs.getBool(NotifPrefsKeys.enabled);
      final role = ref.read(authSessionProvider).userRole;
      _logger.i(
        'NotificationSettingsNotifier.toggleEnabled: wrote enabled=$value '
        'readBack=$readBack role=$role',
      );
      state = state.copyWith(enabled: value, errorMessage: null);

      if (!value) {
        await _repo.cancelAllAndClearData();
        return;
      }

      // Turning ON: must (re)request OS permission. Permission is NOT tied to the
      // prefs flag and does NOT carry over between accounts, so always ask here.
      final granted = await _repo.requestPermission();
      _logger.i('NotificationSettingsNotifier.toggleEnabled: permission granted=$granted');
      if (!granted) {
        await prefs.setBool(NotifPrefsKeys.enabled, false);
        state = state.copyWith(
          enabled: false,
          status: NotificationSettingsStatus.error,
          errorMessage: 'Cần cấp quyền thông báo trong Settings để bật tính năng này.',
        );
        return;
      }

      state = state.copyWith(status: NotificationSettingsStatus.loading);
      await _fetchSaveAndSchedule();
      state = state.copyWith(status: NotificationSettingsStatus.success);
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationSettingsNotifier.toggleEnabled failed. value=$value',
        error: error,
        stackTrace: stackTrace,
      );
      // Revert toggle — permission denied or critical failure
      state = state.copyWith(
        enabled: !value,
        status: NotificationSettingsStatus.error,
        errorMessage: 'Cần cấp quyền thông báo trong Settings để bật tính năng này.',
      );
    }
  }

  Future<void> updateTime(int hour, int minute) async {
    _logger.d(
      'NotificationSettingsNotifier.updateTime: hour=$hour minute=$minute',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(NotifPrefsKeys.hour, hour);
      await prefs.setInt(NotifPrefsKeys.minute, minute);
      state = state.copyWith(hour: hour, minute: minute, errorMessage: null);

      if (state.enabled) {
        await _scheduleFromSavedData();
      }
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationSettingsNotifier.updateTime failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: NotificationSettingsStatus.error,
        errorMessage: 'Không thể cập nhật thời gian thông báo.',
      );
    }
  }

  /// Called from home screens after fresh data is saved to prefs.
  /// Reschedules using saved prefs — does NOT re-fetch from Firestore.
  Future<void> rescheduleIfEnabled() async {
    _logger.d('NotificationSettingsNotifier.rescheduleIfEnabled: start.');
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool(NotifPrefsKeys.enabled) ?? false;
      final role = ref.read(authSessionProvider).userRole;
      _logger.i(
        'NotificationSettingsNotifier.rescheduleIfEnabled: enabled=$enabled role=$role',
      );
      if (!enabled) {
        _logger.d('NotificationSettingsNotifier.rescheduleIfEnabled: disabled, skip.');
        return;
      }
      await _scheduleFromSavedData();
    } catch (error, stackTrace) {
      _logger.w(
        'NotificationSettingsNotifier.rescheduleIfEnabled failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // ─── Private ────────────────────────────────────────────────────────────────

  /// Fetches fresh data from Firestore, saves to prefs, then schedules.
  /// Called only by toggle ON.
  Future<void> _fetchSaveAndSchedule() async {
    _logger.d('NotificationSettingsNotifier._fetchSaveAndSchedule: start.');
    final account = ref.read(authSessionProvider).account;

    if (account == null) {
      _logger.w('NotificationSettingsNotifier._fetchSaveAndSchedule: account null, skip.');
      return;
    }

    final role = account.role;
    _logger.d('NotificationSettingsNotifier._fetchSaveAndSchedule: role=$role');

    if (role == 'child') {
      await _fetchChildDataAndSave(
        uid: account.uid,
        limitMinor: account.monthlyLimit ?? 0,
      );
    } else if (role == 'parent') {
      await _fetchParentDataAndSave(
        familyId: account.familyId,
      );
    } else {
      _logger.w('NotificationSettingsNotifier._fetchSaveAndSchedule: unknown role=$role');
      return;
    }

    await _scheduleFromSavedData();
  }

  Future<void> _fetchChildDataAndSave({
    required String uid,
    required int limitMinor,
  }) async {
    _logger.d(
      'NotificationSettingsNotifier._fetchChildDataAndSave: uid=$uid limit=$limitMinor',
    );
    final transactionRepo = getIt<TransactionRepository>();
    final summary = await transactionRepo.getSummary(uid, month: DateTime.now());
    if (summary == null) {
      _logger.w(
        'NotificationSettingsNotifier._fetchChildDataAndSave: summary null for uid=$uid',
      );
      return;
    }
    final expenseMinor = summary.totalExpense.round();
    await _repo.saveChildData(expenseMinor: expenseMinor, limitMinor: limitMinor);
  }

  Future<void> _fetchParentDataAndSave({required String? familyId}) async {
    _logger.d(
      'NotificationSettingsNotifier._fetchParentDataAndSave: familyId=$familyId',
    );
    if (familyId == null || familyId.isEmpty) {
      _logger.w('NotificationSettingsNotifier._fetchParentDataAndSave: no familyId, skip.');
      return;
    }

    final familyRepo = getIt<LinkFamilyRepository>();
    final dashRepo = getIt<ParentDashboardRepository>();
    final monthKey = DateFormat('yyyy-MM').format(DateTime.now());

    final allMembers = await familyRepo.getFamilyMembersOnce(familyId);
    final members = allMembers.where((m) => m.userRole == 'child').toList();

    if (members.isEmpty) {
      _logger.w('NotificationSettingsNotifier._fetchParentDataAndSave: no child members.');
      return;
    }

    final memberUids = members.map((m) => m.uid).toList();
    final limits = await dashRepo.getChildrenMonthlyLimits(childUids: memberUids);

    final children =
        <({String uid, String name, int expenseMinor, int limitMinor})>[];
    for (final member in members) {
      try {
        final summary = await dashRepo.getChildMonthlySummary(
          childUid: member.uid,
          monthKey: monthKey,
        );
        children.add((
          uid: member.uid,
          name: member.displayName,
          expenseMinor: summary.expenseMinor,
          limitMinor: limits[member.uid] ?? 0,
        ));
      } catch (e, s) {
        _logger.w(
          'NotificationSettingsNotifier: skip child ${member.uid} — summary fetch failed.',
          error: e,
          stackTrace: s,
        );
      }
    }

    await _repo.saveParentChildrenData(children: children);
  }

  /// Reads saved prefs data and schedules. Does NOT fetch from Firestore.
  Future<void> _scheduleFromSavedData() async {
    final role = ref.read(authSessionProvider).userRole;
    _logger.i(
      'NotificationSettingsNotifier._scheduleFromSavedData: start. '
      'role=$role hour=${state.hour} minute=${state.minute}',
    );
    await _repo.notificationForChildOrParent(
      role: role ?? '',
      hour: state.hour,
      minute: state.minute,
    );
  }
}

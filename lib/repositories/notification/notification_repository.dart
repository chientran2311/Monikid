import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:monikid/core/service/local_notification_service.dart';
import 'package:monikid/core/service/notification_tap_intent.dart';
import 'package:monikid/core/utils/amount_formatter_mixin.dart';
import 'package:monikid/core/utils/currency_formatter.dart';

// ---------------------------------------------------------------------------
// Keys
//
// Prefs are GLOBAL (not scoped per account) — they are reset on logout so the
// next user starts clean.

abstract final class NotifPrefsKeys {
  static const enabled = 'notif_enabled';
  static const hour = 'notif_hour';
  static const minute = 'notif_minute';
  static const childExpenseMinor = 'notif_child_expense_minor';
  static const childLimitMinor = 'notif_child_limit_minor';
  static const parentChildren = 'notif_parent_children';
}

// ---------------------------------------------------------------------------
// Interface

abstract class NotificationRepository {
  // === ENTRY — role dispatcher ===

  /// Schedules the daily reminder for [role] from data already saved in prefs.
  /// Does NOT fetch from Firestore (caller saves first via the role-specific
  /// `save*` method below).
  ///
  /// - role == 'child'  → 1 notification about the child's own spending.
  /// - role == 'parent' → 1 notification per child who spent >= 50% of limit.
  Future<void> notificationForChildOrParent({
    required String role,
    required int hour,
    required int minute,
  });

  // === CHILD ===
  Future<void> saveChildData({
    required int expenseMinor,
    required int limitMinor,
  });

  // === PARENT ===
  Future<void> saveParentChildrenData({
    required List<({String uid, String name, int expenseMinor, int limitMinor})>
        children,
  });

  // === SHARED ===
  Future<bool> requestPermission();
  Future<void> cancelAllAndClearData();
  Future<void> clearAllData();
  int computeRemainingPct(int expenseMinor, int limitMinor);
  String formatAmount(int minor);
}

// ---------------------------------------------------------------------------
// Implementation

class NotificationRepositoryImpl
    with AmountFormatterMixin
    implements NotificationRepository {
  NotificationRepositoryImpl({
    required Logger logger,
    required LocalNotificationService notificationService,
  })  : _logger = logger,
        _service = notificationService;

  final Logger _logger;
  final LocalNotificationService _service;

  // Notification id slots: child uses one fixed id; parent uses a range,
  // one id per child.
  static const _childSlot = 1;
  static const _parentSlotStart = 100;
  static const _parentSlotEnd = 200; // exclusive

  // ===========================================================================
  // ENTRY — role dispatcher
  // ===========================================================================

  @override
  Future<void> notificationForChildOrParent({
    required String role,
    required int hour,
    required int minute,
  }) async {
    _logger.i(
      'NotificationRepository.notificationForChildOrParent: '
      'role=$role hour=$hour minute=$minute',
    );
    if (role == 'child') {
      // Steps: read own saved spending → build body → schedule slot 1.
      await _scheduleChildReminder(hour: hour, minute: minute);
    } else if (role == 'parent') {
      // Steps: read saved children → clear slots → schedule one per child.
      await _scheduleParentReminders(hour: hour, minute: minute);
    } else {
      _logger.w(
        'NotificationRepository.notificationForChildOrParent: '
        'unknown role=$role, nothing scheduled.',
      );
    }
  }

  // ===========================================================================
  // CHILD
  // ===========================================================================

  @override
  Future<void> saveChildData({
    required int expenseMinor,
    required int limitMinor,
  }) async {
    _logger.d(
      'NotificationRepository.saveChildData: expense=$expenseMinor limit=$limitMinor',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(NotifPrefsKeys.childExpenseMinor, expenseMinor);
    await prefs.setInt(NotifPrefsKeys.childLimitMinor, limitMinor);
    _logger.i('NotificationRepository.saveChildData: saved.');
  }

  Future<void> _scheduleChildReminder({
    required int hour,
    required int minute,
  }) async {
    _logger.d(
      'NotificationRepository._scheduleChildReminder: hour=$hour minute=$minute',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final expenseMinor = prefs.getInt(NotifPrefsKeys.childExpenseMinor) ?? 0;
      final limitMinor = prefs.getInt(NotifPrefsKeys.childLimitMinor) ?? 0;

      await _service.cancelById(_childSlot);
      await _service.scheduleZoned(
        id: _childSlot,
        title: 'Báo cáo chi tiêu hôm nay',
        body: _buildChildBody(expenseMinor, limitMinor),
        hour: hour,
        minute: minute,
        payload: NotificationTapIntent.encodeChild(),
      );
      _logger.i('NotificationRepository._scheduleChildReminder: scheduled.');
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationRepository._scheduleChildReminder failed.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  String _buildChildBody(int expenseMinor, int limitMinor) {
    final expense = formatAmount(expenseMinor);
    final monthName = DateFormat.MMMM('vi').format(DateTime.now());
    if (limitMinor > 0) {
      final remainingPct = computeRemainingPct(expenseMinor, limitMinor);
      return 'Bạn còn $remainingPct% hạn mức, bạn đã tiêu $expense trong tháng $monthName';
    }
    return 'Bạn đã tiêu $expense trong tháng $monthName';
  }

  // ===========================================================================
  // PARENT
  // ===========================================================================

  @override
  Future<void> saveParentChildrenData({
    required List<({String uid, String name, int expenseMinor, int limitMinor})>
        children,
  }) async {
    _logger.d(
      'NotificationRepository.saveParentChildrenData: total=${children.length}',
    );
    final prefs = await SharedPreferences.getInstance();

    // Only keep children who spent >= 50% of their limit.
    final alerting =
        <({String uid, String name, int expenseMinor, int limitMinor})>[];
    for (final child in children) {
      final hasLimit = child.limitMinor > 0;
      final keep = hasLimit && child.expenseMinor >= child.limitMinor * 0.5;
      final spentPct = hasLimit
          ? (child.expenseMinor / child.limitMinor * 100).toStringAsFixed(1)
          : 'n/a';
      _logger.i(
        'NotificationRepository.saveParentChildrenData: child="${child.name}" '
        'expenseMinor=${child.expenseMinor} limitMinor=${child.limitMinor} '
        'spent=$spentPct% keep=$keep'
        '${!hasLimit ? ' (dropped: no limit set)' : keep ? '' : ' (dropped: below 50%)'}',
      );
      if (keep) alerting.add(child);
    }

    _logger.i(
      'NotificationRepository.saveParentChildrenData: '
      'input=${children.length} alerting=${alerting.length}',
    );

    if (alerting.isEmpty) {
      await prefs.remove(NotifPrefsKeys.parentChildren);
      _logger.i(
        'NotificationRepository.saveParentChildrenData: '
        'no child above 50%, cleared prefs.',
      );
      return;
    }

    final encoded = jsonEncode(
      alerting
          .map((child) => {
                'uid': child.uid,
                'name': child.name,
                'expenseMinor': child.expenseMinor,
                'limitMinor': child.limitMinor,
              })
          .toList(),
    );
    await prefs.setString(NotifPrefsKeys.parentChildren, encoded);
    _logger.i(
      'NotificationRepository.saveParentChildrenData: saved ${alerting.length}.',
    );
  }

  Future<void> _scheduleParentReminders({
    required int hour,
    required int minute,
  }) async {
    _logger.d(
      'NotificationRepository._scheduleParentReminders: hour=$hour minute=$minute',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final childrenJson = prefs.getString(NotifPrefsKeys.parentChildren);
      _logger.i(
        'NotificationRepository._scheduleParentReminders: '
        'parentChildren prefs ${childrenJson == null ? 'NULL' : 'len=${childrenJson.length}'}',
      );

      if (childrenJson == null || childrenJson.isEmpty) {
        _logger.w(
          'NotificationRepository._scheduleParentReminders: '
          'no saved children. Skip — NO notification scheduled.',
        );
        return;
      }

      final decoded = jsonDecode(childrenJson) as List<dynamic>;
      final children = decoded.map((entry) {
        final map = entry as Map<String, dynamic>;
        return (
          uid: (map['uid'] as String?) ?? '',
          name: map['name'] as String,
          expenseMinor: (map['expenseMinor'] as num).toInt(),
          limitMinor: (map['limitMinor'] as num).toInt(),
        );
      }).toList();

      // Clear the whole parent slot range before rescheduling.
      for (var id = _parentSlotStart; id < _parentSlotEnd; id++) {
        await _service.cancelById(id);
      }

      for (var index = 0; index < children.length; index++) {
        final child = children[index];
        final id = _parentSlotStart + index;
        _logger.i(
          'NotificationRepository._scheduleParentReminders: '
          'scheduling id=$id child="${child.name}" '
          'expenseMinor=${child.expenseMinor} limitMinor=${child.limitMinor} '
          'hour=$hour minute=$minute',
        );
        await _service.scheduleZoned(
          id: id,
          title: 'Báo cáo chi tiêu gia đình',
          body: _buildParentChildBody(
            child.name,
            child.expenseMinor,
            child.limitMinor,
          ),
          hour: hour,
          minute: minute,
          payload: NotificationTapIntent.encodeParent(
            childUid: child.uid,
            childName: child.name,
          ),
        );
      }
      _logger.i(
        'NotificationRepository._scheduleParentReminders: '
        'scheduled ${children.length}.',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationRepository._scheduleParentReminders failed.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  String _buildParentChildBody(String name, int expenseMinor, int limitMinor) {
    final remainingPct = computeRemainingPct(expenseMinor, limitMinor);
    final expense = formatAmount(expenseMinor);
    return 'Con bạn $name chỉ còn $remainingPct% theo hạn mức, đã tiêu $expense';
  }

  // ===========================================================================
  // SHARED
  // ===========================================================================

  @override
  Future<bool> requestPermission() => _service.requestPermission();

  @override
  Future<void> cancelAllAndClearData() async {
    _logger.d('NotificationRepository.cancelAllAndClearData: start.');
    try {
      await _service.cancelAllAndDeregister();
      await clearAllData();
      _logger.i('NotificationRepository.cancelAllAndClearData: done.');
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationRepository.cancelAllAndClearData failed.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> clearAllData() async {
    _logger.d('NotificationRepository.clearAllData: start.');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(NotifPrefsKeys.childExpenseMinor);
    await prefs.remove(NotifPrefsKeys.childLimitMinor);
    await prefs.remove(NotifPrefsKeys.parentChildren);
    _logger.i('NotificationRepository.clearAllData: done.');
  }

  @override
  int computeRemainingPct(int expenseMinor, int limitMinor) {
    if (limitMinor <= 0) return 100;
    return ((limitMinor - expenseMinor) / limitMinor * 100)
        .clamp(0.0, 100.0)
        .round();
  }

  @override
  String formatAmount(int minor) => CurrencyFormatter.format(minor);
}

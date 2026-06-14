import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:monikid/core/service/local_notification_service.dart';
import 'package:monikid/core/utils/amount_formatter_mixin.dart';
import 'package:monikid/core/utils/currency_formatter.dart';

// ---------------------------------------------------------------------------
// Keys

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
  // === DATA I/O ===
  Future<void> saveChildData({
    required int expenseMinor,
    required int limitMinor,
  });

  Future<void> saveParentChildrenData({
    required List<({String name, int expenseMinor, int limitMinor})> children,
  });

  Future<void> clearAllData();

  // === COMPUTE UTILS ===
  int computeRemainingPct(int expenseMinor, int limitMinor);
  String formatAmount(int minor);

  // === SCHEDULE FROM SAVED DATA (reads prefs + builds content + schedules) ===
  Future<void> scheduleChildFromSavedData({
    required int hour,
    required int minute,
  });

  Future<void> scheduleParentFromSavedData({
    required int hour,
    required int minute,
  });

  // === CANCEL ===
  Future<void> cancelAllAndClearData();
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

  // === DATA I/O ===

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

  @override
  Future<void> saveParentChildrenData({
    required List<({String name, int expenseMinor, int limitMinor})> children,
  }) async {
    _logger.d(
      'NotificationRepository.saveParentChildrenData: total=${children.length}',
    );
    final prefs = await SharedPreferences.getInstance();

    // Only keep children who spent >= 50% of their limit
    final filtered = children
        .where((c) => c.limitMinor > 0 && c.expenseMinor >= c.limitMinor * 0.5)
        .toList();

    _logger.d(
      'NotificationRepository.saveParentChildrenData: after 50% filter=${filtered.length}',
    );

    if (filtered.isEmpty) {
      await prefs.remove(NotifPrefsKeys.parentChildren);
      _logger.i(
        'NotificationRepository.saveParentChildrenData: '
        'no children above 50%, cleared prefs.',
      );
      return;
    }

    final encoded = jsonEncode(
      filtered
          .map((c) => {
                'name': c.name,
                'expenseMinor': c.expenseMinor,
                'limitMinor': c.limitMinor,
              })
          .toList(),
    );
    await prefs.setString(NotifPrefsKeys.parentChildren, encoded);
    _logger.i(
      'NotificationRepository.saveParentChildrenData: '
      'saved ${filtered.length} children.',
    );
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

  // === COMPUTE UTILS (from AmountFormatterMixin) ===

  @override
  int computeRemainingPct(int expenseMinor, int limitMinor) {
    if (limitMinor <= 0) return 100;
    return ((limitMinor - expenseMinor) / limitMinor * 100)
        .clamp(0.0, 100.0)
        .round();
  }

  @override
  String formatAmount(int minor) => CurrencyFormatter.format(minor);

  // === CHILD SCHEDULING ===

  @override
  Future<void> scheduleChildFromSavedData({
    required int hour,
    required int minute,
  }) async {
    _logger.d(
      'NotificationRepository.scheduleChildFromSavedData: hour=$hour minute=$minute',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final expenseMinor = prefs.getInt(NotifPrefsKeys.childExpenseMinor) ?? 0;
      final limitMinor = prefs.getInt(NotifPrefsKeys.childLimitMinor) ?? 0;

      const title = 'Báo cáo chi tiêu hôm nay';
      final body = _buildChildBody(expenseMinor, limitMinor);

      await _service.cancelById(1);
      await _service.scheduleZoned(
        id: 1,
        title: title,
        body: body,
        hour: hour,
        minute: minute,
      );
      _logger.i('NotificationRepository.scheduleChildFromSavedData: scheduled.');
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationRepository.scheduleChildFromSavedData failed.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // === PARENT SCHEDULING ===

  @override
  Future<void> scheduleParentFromSavedData({
    required int hour,
    required int minute,
  }) async {
    _logger.d(
      'NotificationRepository.scheduleParentFromSavedData: hour=$hour minute=$minute',
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final childrenJson = prefs.getString(NotifPrefsKeys.parentChildren);

      if (childrenJson == null || childrenJson.isEmpty) {
        _logger.w(
          'NotificationRepository.scheduleParentFromSavedData: '
          'no children data (all below 50% or not loaded). Skip.',
        );
        return;
      }

      final decoded = jsonDecode(childrenJson) as List<dynamic>;
      final children = decoded.map((e) {
        final map = e as Map<String, dynamic>;
        return (
          name: map['name'] as String,
          expenseMinor: (map['expenseMinor'] as num).toInt(),
          limitMinor: (map['limitMinor'] as num).toInt(),
        );
      }).toList();

      // Cancel all parent slots before rescheduling
      for (var i = 100; i < 200; i++) {
        await _service.cancelById(i);
      }

      for (var i = 0; i < children.length; i++) {
        final child = children[i];
        await _service.scheduleZoned(
          id: 100 + i,
          title: 'Báo cáo chi tiêu gia đình',
          body: _buildParentChildBody(
            child.name,
            child.expenseMinor,
            child.limitMinor,
          ),
          hour: hour,
          minute: minute,
        );
      }
      _logger.i(
        'NotificationRepository.scheduleParentFromSavedData: '
        'scheduled ${children.length}.',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationRepository.scheduleParentFromSavedData failed.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // === CANCEL ===

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

  // ---------------------------------------------------------------------------
  // String builders

  String _buildChildBody(int expenseMinor, int limitMinor) {
    final expense = formatAmount(expenseMinor);
    final monthName = DateFormat.MMMM('vi').format(DateTime.now());
    if (limitMinor > 0) {
      final pct = computeRemainingPct(expenseMinor, limitMinor);
      return 'Bạn còn $pct% hạn mức, bạn đã tiêu $expense trong tháng $monthName';
    }
    return 'Bạn đã tiêu $expense trong tháng $monthName';
  }

  String _buildParentChildBody(
      String name, int expenseMinor, int limitMinor) {
    final pct = computeRemainingPct(expenseMinor, limitMinor);
    final expense = formatAmount(expenseMinor);
    return 'Con bạn $name chỉ còn $pct% theo hạn mức, đã tiêu $expense';
  }
}

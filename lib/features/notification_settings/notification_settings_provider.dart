import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/local_notification_service.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/notification_settings/notification_settings_state.dart';

part 'notification_settings_provider.g.dart';

@riverpod
class NotificationSettingsNotifier extends _$NotificationSettingsNotifier {
  late Logger _logger;
  late LocalNotificationService _notifService;

  @override
  NotificationSettingsState build() {
    _logger = getIt<Logger>();
    _notifService = getIt<LocalNotificationService>();
    // Defer _loadSettings() until after build() returns so the provider is
    // fully initialized before any state write happens. Calling it directly
    // (without microtask) causes the synchronous `state =` inside _loadSettings
    // to run before build() completes → "uninitialized provider" crash.
    Future.microtask(_loadSettings);
    return const NotificationSettingsState();
  }

  Future<void> _loadSettings() async {
    state = state.copyWith(status: NotificationSettingsStatus.loading);
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('notif_enabled') ?? false;
      final hour = prefs.getInt('notif_hour') ?? 21;
      final minute = prefs.getInt('notif_minute') ?? 0;
      state = state.copyWith(
        status: NotificationSettingsStatus.success,
        enabled: enabled,
        hour: hour,
        minute: minute,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to load notification settings.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: NotificationSettingsStatus.error,
        errorMessage: 'Không thể tải cài đặt thông báo.',
      );
    }
  }

  Future<void> toggleEnabled(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notif_enabled', value);
      state = state.copyWith(enabled: value, errorMessage: null);

      if (!value) {
        await _notifService.cancelAll();
        return;
      }

      await _scheduleForRole();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to toggle notifications.',
        error: error,
        stackTrace: stackTrace,
      );
      // Revert toggle on failure (D-01)
      state = state.copyWith(
        enabled: !value,
        status: NotificationSettingsStatus.error,
        errorMessage: 'Cần cấp quyền thông báo trong Settings để bật tính năng này.',
      );
    }
  }

  Future<void> updateTime(int hour, int minute) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('notif_hour', hour);
      await prefs.setInt('notif_minute', minute);
      state = state.copyWith(hour: hour, minute: minute, errorMessage: null);

      if (state.enabled) {
        await _scheduleForRole();
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to update notification time.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: NotificationSettingsStatus.error,
        errorMessage: 'Không thể cập nhật thời gian thông báo.',
      );
    }
  }

  Future<void> _scheduleForRole() async {
    final role = ref.read(authSessionProvider).account?.role;
    _logger.d('NotificationSettingsNotifier: _scheduleForRole role=$role');

    if (role == null) {
      _logger.w('NotificationSettingsNotifier: role is null — skipping schedule.');
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      if (role == 'child') {
        final expenseMinor = prefs.getInt('notif_child_expense_minor') ?? 0;
        final limitMinor = prefs.getInt('notif_child_limit_minor') ?? 0;
        _logger.d(
          'NotificationSettingsNotifier: scheduling child notification. '
          'hour=${state.hour} minute=${state.minute} '
          'expense=$expenseMinor limit=$limitMinor',
        );
        await _notifService.scheduleChildDailyNotification(
          hour: state.hour,
          minute: state.minute,
          expenseMinor: expenseMinor,
          limitMinor: limitMinor,
          title: 'Báo cáo chi tiêu hôm nay',
          body:
              'Bạn đã chi ${_formatMinor(expenseMinor)} trong tháng này (hạn mức: ${_formatMinor(limitMinor)}).',
        );
      } else if (role == 'parent') {
        final childrenJson = prefs.getString('notif_parent_children');
        _logger.d(
          'NotificationSettingsNotifier: scheduling parent notifications. '
          'childrenJson=${childrenJson?.length} chars',
        );
        final List<({String name, int expenseMinor})> children;

        if (childrenJson == null || childrenJson.isEmpty) {
          children = [];
        } else {
          final decoded = jsonDecode(childrenJson) as List<dynamic>;
          children = decoded.map((e) {
            final map = e as Map<String, dynamic>;
            return (
              name: map['name'] as String,
              expenseMinor: (map['expenseMinor'] as num).toInt(),
            );
          }).toList();
        }

        await _notifService.scheduleParentDailyNotifications(
          hour: state.hour,
          minute: state.minute,
          children: children,
          title: 'Báo cáo chi tiêu gia đình',
          genericBody: 'Mở MoniKid để xem báo cáo chi tiêu gia đình hôm nay.',
          bodyBuilder: (name, expense) => 'Con $name đã chi $expense tháng này.',
        );
      }
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationSettingsNotifier: _scheduleForRole failed. role=$role',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> refreshSchedule() async {
    try {
      // Read directly from SharedPreferences to avoid race with _loadSettings()
      // which runs async from build() and may not have completed yet.
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('notif_enabled') ?? false;
      _logger.d(
        'NotificationSettingsNotifier: refreshSchedule enabled=$enabled',
      );
      if (!enabled) return;
      await _scheduleForRole();
    } catch (error, stackTrace) {
      _logger.e(
        'NotificationSettingsNotifier: refreshSchedule failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _formatMinor(int minor) {
    final amount = minor.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return '$amountđ';
  }
}

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:monikid/core/service/notification_tap_intent.dart';

class LocalNotificationService {
  LocalNotificationService(this._logger);

  final Logger _logger;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'monikid_daily';
  static const String _channelName = 'Daily Reminders';

  final _tapController = StreamController<NotificationTapIntent>.broadcast();

  /// Emits when the user taps a notification while the app process is alive.
  Stream<NotificationTapIntent> get onNotificationTap => _tapController.stream;

  /// Set during [initialize] when the app was COLD-STARTED by a notification
  /// tap. Consume once (read then null) from the app layer.
  NotificationTapIntent? initialTapIntent;

  Future<void> initialize() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: 'Daily spending reminder',
        importance: Importance.high,
      ),
    );

    // Cold start: app launched by tapping a notification while terminated.
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final payload = launchDetails?.notificationResponse?.payload;
      initialTapIntent = NotificationTapIntent.tryParse(payload);
      _logger.i(
        'LocalNotificationService.initialize: cold-start tap '
        'payload=$payload intent=${initialTapIntent?.target}',
      );
    }

    _logger.i('LocalNotificationService initialized.');
  }

  void _onNotificationTap(NotificationResponse response) {
    final intent = NotificationTapIntent.tryParse(response.payload);
    if (intent == null) {
      _logger.w(
        'LocalNotificationService._onNotificationTap: unparseable '
        'payload=${response.payload}',
      );
      return;
    }
    _logger.i(
      'LocalNotificationService._onNotificationTap: target=${intent.target} '
      'childUid=${intent.childUid}',
    );
    _tapController.add(intent);
  }

  /// Requests POST_NOTIFICATIONS permission (required to display).
  /// Scheduling uses inexact alarms, so no exact-alarm permission is needed.
  Future<bool> requestPermission() async {
    _logger.d('LocalNotificationService.requestPermission: start.');
    try {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted =
          await androidPlugin?.requestNotificationsPermission() ?? false;

      _logger.i(
        'LocalNotificationService.requestPermission: notificationsGranted=$granted',
      );
      return granted;
    } catch (error, stackTrace) {
      _logger.e(
        'LocalNotificationService.requestPermission failed.',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> scheduleZoned({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    _logger.d(
      'LocalNotificationService.scheduleZoned: id=$id hour=$hour minute=$minute',
    );
    final scheduledDate = _nextInstanceOfTime(hour, minute);
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );
    await _scheduleWithFallback(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      details: details,
      payload: payload,
    );
  }

  Future<void> cancelById(int id) async {
    _logger.d('LocalNotificationService.cancelById: id=$id');
    await _plugin.cancel(id: id);
  }

  Future<void> cancelAllAndDeregister() async {
    await _plugin.cancelAll();
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.deleteNotificationChannel(channelId: _channelId);
    _logger.i(
      'LocalNotificationService: all notifications cancelled and channel deleted.',
    );
  }

  Future<List<PendingNotificationRequest>> pendingRequests() =>
      _plugin.pendingNotificationRequests();

  // ---------------------------------------------------------------------------

  Future<void> _scheduleWithFallback({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails details,
    String? payload,
  }) async {
    // Daily reminder does not need second-precision. Use inexact directly:
    // SCHEDULE_EXACT_ALARM is not auto-granted on Android 14+ and trying exact
    // first throws PlatformException(exact_alarms_not_permitted) on every call.
    try {
      _logger.d(
        'LocalNotificationService._scheduleWithFallback: inexact id=$id '
        'scheduledDate=$scheduledDate',
      );
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
      _logger.d('LocalNotificationService: inexact schedule success id=$id');
    } catch (error, stackTrace) {
      _logger.e(
        'LocalNotificationService: schedule failed id=$id.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    _logger.d(
      'LocalNotificationService._nextInstanceOfTime: hour=$hour minute=$minute',
    );
    final location = tz.getLocation('Asia/Ho_Chi_Minh');
    final now = tz.TZDateTime.now(location);
    var scheduled = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    _logger.d(
      'LocalNotificationService._nextInstanceOfTime: now=$now scheduled=$scheduled',
    );
    return scheduled;
  }
}

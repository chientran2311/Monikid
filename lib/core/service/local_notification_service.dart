import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService(this._logger);

  final Logger _logger;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'monikid_daily';
  static const String _channelName = 'Daily Reminders';

  Future<void> initialize() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(settings: initSettings);

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

    _logger.i('LocalNotificationService initialized.');
  }

  Future<void> requestPermission() async {
    _logger.d('LocalNotificationService.requestPermission: start.');
    try {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted = await androidPlugin?.requestNotificationsPermission();
      _logger.i(
        'LocalNotificationService.requestPermission: granted=$granted',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'LocalNotificationService.requestPermission failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> scheduleZoned({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
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
  }) async {
    try {
      _logger.d(
        'LocalNotificationService._scheduleWithFallback: exact id=$id '
        'scheduledDate=$scheduledDate',
      );
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      _logger.d('LocalNotificationService: exact schedule success id=$id');
    } catch (exactError, exactStack) {
      _logger.w(
        'LocalNotificationService: exact schedule failed id=$id, '
        'falling back to inexact.',
        error: exactError,
        stackTrace: exactStack,
      );
      try {
        await _plugin.zonedSchedule(
          id: id,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        _logger.d('LocalNotificationService: inexact schedule success id=$id');
      } catch (inexactError, inexactStack) {
        _logger.e(
          'LocalNotificationService: inexact schedule also failed id=$id.',
          error: inexactError,
          stackTrace: inexactStack,
        );
      }
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

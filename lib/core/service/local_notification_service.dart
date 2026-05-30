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

  /// Requests the OS-level notification permission (Android 13+).
  /// Called explicitly when the user taps Allow in onboarding.
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

  Future<void> scheduleChildDailyNotification({
    required int hour,
    required int minute,
    required int expenseMinor,
    required int limitMinor,
    required String title,
    required String body,
  }) async {
    _logger.d(
      'LocalNotificationService: scheduleChild start. '
      'hour=$hour minute=$minute expense=$expenseMinor limit=$limitMinor',
    );
    try {
      await _plugin.cancel(id: 1);
      final scheduledDate = _nextInstanceOfTime(hour, minute);
      _logger.d(
        'LocalNotificationService: scheduledDate=$scheduledDate',
      );
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
        id: 1,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        details: details,
      );
      _logger.i(
        'LocalNotificationService: child notification scheduled at $hour:$minute '
        'scheduledDate=$scheduledDate',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'LocalNotificationService: scheduleChildDailyNotification failed.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> scheduleParentDailyNotifications({
    required int hour,
    required int minute,
    required List<({String name, int expenseMinor})> children,
    required String Function(String name, String expense) bodyBuilder,
    required String title,
    required String genericBody,
  }) async {
    for (var i = 100; i < 200; i++) {
      await _plugin.cancel(id: i);
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    if (children.isEmpty) {
      final scheduledDate = _nextInstanceOfTime(hour, minute);
      await _scheduleWithFallback(
        id: 100,
        title: title,
        body: genericBody,
        scheduledDate: scheduledDate,
        details: details,
      );
      _logger.i('Parent generic notification scheduled (no children cache).');
      return;
    }

    final scheduledDate = _nextInstanceOfTime(hour, minute);
    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      await _scheduleWithFallback(
        id: 100 + i,
        title: title,
        body: bodyBuilder(child.name, _formatMinor(child.expenseMinor)),
        scheduledDate: scheduledDate,
        details: details,
      );
    }
    _logger.i(
      'Parent notifications scheduled for ${children.length} child(ren) at $hour:$minute.',
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
    _logger.i('All notifications cancelled.');
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
        'LocalNotificationService: zonedSchedule exact id=$id '
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
      // SCHEDULE_EXACT_ALARM denied — fallback to inexact (D-01)
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
      'LocalNotificationService: _nextInstanceOfTime hour=$hour minute=$minute',
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
      'LocalNotificationService: nextTime now=$now scheduled=$scheduled',
    );
    return scheduled;
  }

  String _formatMinor(int minor) {
    final amount = minor.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return '$amountđ';
  }
}

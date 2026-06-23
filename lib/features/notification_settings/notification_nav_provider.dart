import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/service/notification_tap_intent.dart';

part 'notification_nav_provider.g.dart';

/// Holds a pending notification-tap navigation intent until a nav bar consumes
/// it. keepAlive so a cold-start intent survives the auth/PIN gate.
@Riverpod(keepAlive: true)
class NotificationNav extends _$NotificationNav {
  @override
  NotificationTapIntent? build() => null;

  void set(NotificationTapIntent intent) => state = intent;
  void clear() => state = null;
}

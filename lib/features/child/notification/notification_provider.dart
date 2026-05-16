import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/models/entities/notification_model.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';

part 'notification_provider.g.dart';

@riverpod
Stream<List<NotificationModel>> notificationStream(Ref ref) {
  final uid = ref.watch(authSessionProvider).account?.uid ?? '';
  if (uid.isEmpty) return Stream.value([]);
  return getIt<NotificationRepository>().streamNotifications(uid);
}

@riverpod
int unreadNotificationCount(Ref ref) {
  return ref.watch(notificationStreamProvider).maybeWhen(
    data: (list) => list.where((n) => !n.isRead).length,
    orElse: () => 0,
  );
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/notification/notification_provider.dart';
import 'package:monikid/features/child/notification/widgets/notification_card.dart';
import 'package:monikid/features/child/notification/widgets/notification_empty_state.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';

class ChildNotificationScreen extends ConsumerWidget {
  const ChildNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final uid = ref.watch(authSessionProvider).account?.uid ?? '';
    final notifAsync = ref.watch(notificationStreamProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    Future<void> markAllRead() async {
      if (uid.isEmpty) return;
      await getIt<NotificationRepository>().markAllRead(uid);
    }

    Future<void> markRead(String notifId) async {
      if (uid.isEmpty) return;
      await getIt<NotificationRepository>().markRead(uid, notifId);
    }

    Future<void> deleteNotif(String notifId) async {
      if (uid.isEmpty) return;
      await getIt<NotificationRepository>().deleteNotification(uid, notifId);
    }

    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundLight,
          elevation: 0,
          title: Text(s.notifTitle),
          actions: [
            if (unreadCount > 0)
              TextButton(
                onPressed: markAllRead,
                child: Text(
                  s.notifMarkAllRead,
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        body: notifAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (list) => list.isEmpty
              ? const NotificationEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: list.length,
                  itemBuilder: (_, i) => NotificationCard(
                    notif: list[i],
                    onDelete: () => deleteNotif(list[i].notificationId),
                    onTap: () {
                      if (!list[i].isRead) markRead(list[i].notificationId);
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

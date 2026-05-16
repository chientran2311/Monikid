import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/notification/widgets/notification_card.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/models/entities/notification_model.dart';

class ParentNotificationCard extends ConsumerWidget {
  const ParentNotificationCard({
    super.key,
    required this.notif,
    required this.onDelete,
    required this.onMarkRead,
  });

  final NotificationModel notif;
  final VoidCallback onDelete;
  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final members = ref.watch(parentHomeNotifierProvider).members;
    final child = members
        .where((m) => m.uid == notif.studentId)
        .firstOrNull;
    final childName = child?.displayName ?? '';
    final bodyText = _buildBody(s, notif.type, childName, notif.message);

    return Dismissible(
      key: ValueKey(notif.notificationId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppTheme.notifIconRed,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Icon(Icons.delete_outline, color: Colors.white, size: 22.sp),
      ),
      child: GestureDetector(
        onTap: () {
          onMarkRead();
          if (notif.studentId.isNotEmpty) {
            context.push('/parent/children/${notif.studentId}/transactions');
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: notif.isRead
                ? AppTheme.notifCardSurface
                : AppTheme.notifUnreadTint,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: AppTheme.notifCardShadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotifTypeIcon(type: notif.type),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textBlack,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _formatTimestamp(notif.createdAt),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      bodyText,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.textGrey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildBody(
    AppLocalizations s,
    NotificationType type,
    String childName,
    String fallback,
  ) {
    final monthKey = DateFormat('MM/yyyy').format(notif.createdAt);
    return switch (type) {
      NotificationType.overspend80 =>
        s.notifParentOverspend80Body(childName, monthKey),
      NotificationType.overspend100 =>
        s.notifParentOverspend100Body(childName, monthKey),
      NotificationType.weeklyOverspend => childName.isNotEmpty
          ? s.notifParentWeeklyOverspendBody(childName, '30')
          : fallback,
    };
  }

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Vừa xong';
    if (diff.inHours < 1) return '${diff.inMinutes} phút trước';
    if (diff.inDays < 1) return '${diff.inHours} giờ trước';
    return DateFormat('dd/MM/yyyy').format(dt);
  }
}

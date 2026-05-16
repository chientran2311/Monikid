import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notif,
    required this.onDelete,
    required this.onTap,
  });

  final NotificationModel notif;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
        onTap: onTap,
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
                      notif.message,
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

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Vừa xong';
    if (diff.inHours < 1) return '${diff.inMinutes} phút trước';
    if (diff.inDays < 1) return '${diff.inHours} giờ trước';
    return DateFormat('dd/MM/yyyy').format(dt);
  }
}

class NotifTypeIcon extends StatelessWidget {
  const NotifTypeIcon({super.key, required this.type});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, icon) = switch (type) {
      NotificationType.weeklyOverspend => (
          AppTheme.notifIconBlueBg,
          AppTheme.notifIconBlue,
          Icons.trending_up,
        ),
      NotificationType.overspend80 => (
          AppTheme.notifIconAmberBg,
          AppTheme.notifIconAmber,
          Icons.warning_amber,
        ),
      NotificationType.overspend100 => (
          AppTheme.notifIconRedBg,
          AppTheme.notifIconRed,
          Icons.error_outline,
        ),
    };
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(icon, color: fg, size: 20.sp),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/notification_badge.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.avatarUrl,
    this.onAvatarTap,
    this.onNotificationTap,
    this.notifCount = 0,
  });

  final String? avatarUrl;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationTap;
  final int notifCount;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? AppTheme.surfaceDark.withValues(alpha: 0.92)
        : AppTheme.surfaceLight.withValues(alpha: 0.92);
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final iconColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: onAvatarTap,
                child: _AvatarWidget(avatarUrl: avatarUrl, isDark: isDark),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    s.appBarBrandTitle,
                    style: context.typo.subtitle.small.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
              ),
              NotificationBadge(
                count: notifCount,
                child: IconButton(
                  onPressed: onNotificationTap,
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: iconColor,
                    size: 24.r,
                  ),
                  tooltip: s.appBarNotificationsTooltip,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.r, minHeight: 32.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({required this.avatarUrl, required this.isDark});

  final String? avatarUrl;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    return SizedBox(
      width: 32.r,
      height: 32.r,
      child: CircleAvatar(
        backgroundColor: bgColor,
        backgroundImage: avatarUrl != null
            ? ResizeImage(
                NetworkImage(avatarUrl!),
                width: decodePixelsFor(context, 32.r),
              )
            : null,
        child: avatarUrl == null
            ? Icon(
                Icons.person_outline_rounded,
                size: 18.r,
                color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
              )
            : null,
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/glass_tab_app_bar.dart';

/// Custom transparent AppBar matching HTML .app-bar design.
/// "MoniKid" title (28sp fw800) on left, glassmorphism profile button on right.
/// Delegates layout to the shared [GlassTabAppBar].
class ParentHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ParentHomeAppBar({super.key, this.avatarUrl, this.userName, this.onAvatarTap});

  final String? avatarUrl;
  final String? userName;
  final VoidCallback? onAvatarTap;

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return GlassTabAppBar(
      title: 'MoniKid',
      titleFontSize: 28,
      height: 68,
      trailing: _ProfileButton(
        avatarUrl: avatarUrl,
        userName: userName,
        onTap: onAvatarTap,
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({this.avatarUrl, this.userName, this.onTap});

  final String? avatarUrl;
  final String? userName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = Color.lerp(AppTheme.primary, Colors.white, 0.84)!;
    final initial = (userName != null && userName!.isNotEmpty)
        ? userName![0].toUpperCase()
        : '?';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46.r,
        height: 46.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10.h),
              blurRadius: 24.r,
              color: AppTheme.primary.withValues(alpha: 0.08),
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.76),
                border: Border.all(color: borderColor),
              ),
              child: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? Image.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                      cacheWidth: decodePixelsFor(context, 46.r),
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return _buildInitials(context, initial);
                      },
                      errorBuilder: (_, __, ___) =>
                          _buildInitials(context, initial),
                    )
                  : _buildInitials(context, initial),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitials(BuildContext context, String initial) {
    return Center(
      child: Text(
        initial,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

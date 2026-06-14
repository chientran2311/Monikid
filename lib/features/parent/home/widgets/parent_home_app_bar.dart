import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/glass_tab_app_bar.dart';

/// Custom transparent AppBar matching HTML .app-bar design.
/// "MoniKid" title (24sp fw800) on left, glassmorphism profile button on right.
/// Delegates layout to the shared [GlassTabAppBar].
class ParentHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ParentHomeAppBar({super.key, this.avatarUrl, this.onAvatarTap});

  final String? avatarUrl;
  final VoidCallback? onAvatarTap;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return GlassTabAppBar(
      title: 'MoniKid',
      trailing: _ProfileButton(avatarUrl: avatarUrl, onTap: onAvatarTap),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({this.avatarUrl, this.onTap});

  final String? avatarUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // border color = color-mix(in oklab, #2F7F33 16%, white) ≈ borderLight
    final borderColor = Color.lerp(AppTheme.primary, Colors.white, 0.84)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
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
              child: avatarUrl != null
                  ? Image.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                      cacheWidth: decodePixelsFor(context, 36.r),
                      errorBuilder: (_, __, ___) => _defaultIcon(),
                    )
                  : _defaultIcon(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultIcon() {
    return Icon(Icons.person_outline_rounded, size: 18.r, color: AppTheme.primary);
  }
}

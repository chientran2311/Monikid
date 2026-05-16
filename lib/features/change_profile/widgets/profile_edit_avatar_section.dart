import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ProfileEditAvatarSection extends StatelessWidget {
  const ProfileEditAvatarSection({
    super.key,
    required this.avatarUrl,
    required this.bgColor,
    required this.surfaceColor,
    required this.subTextColor,
    required this.onTap,
  });

  final String? avatarUrl;
  final Color bgColor;
  final Color surfaceColor;
  final Color subTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.r,
        height: 120.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: surfaceColor,
          border: Border.all(color: AppTheme.primary, width: 3),
          image: avatarUrl != null
              ? DecorationImage(
                  image: NetworkImage(avatarUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          children: [
            if (avatarUrl == null)
              Center(
                child: Icon(Icons.person, size: 60.r, color: subTextColor),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: bgColor, width: 2.5),
                ),
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: 18.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ProfileEditAvatarSection extends StatelessWidget {
  const ProfileEditAvatarSection({
    super.key,
    required this.avatarUrl,
    required this.fullName,
    required this.onTap,
  });

  final String? avatarUrl;
  final String fullName;
  final VoidCallback onTap;

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryLight,
              image: avatarUrl != null
                  ? DecorationImage(
                      image: ResizeImage(
                        NetworkImage(avatarUrl!),
                        width: decodePixelsFor(context, 100.r),
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: avatarUrl == null
                ? Center(
                    child: _initials(fullName).isEmpty
                        ? Icon(Icons.person, size: 48.r, color: AppTheme.primary)
                        : Text(
                            _initials(fullName),
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  )
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 32.r,
              height: 32.r,
              decoration: const BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.photo_camera,
                color: Colors.white,
                size: 16.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

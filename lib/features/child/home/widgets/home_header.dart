import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.greeting,
    required this.userName,
    required this.avatarUrl,
    required this.isDark,
    required this.textColor,
    super.key,
  });

  final String greeting;
  final String userName;
  final String? avatarUrl;
  final bool isDark;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: TextStyle(
                fontSize: 14.r,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              userName,
              style: TextStyle(
                fontSize: 20.r,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.2),
              width: 2.r,
            ),
          ),
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person, color: AppTheme.primary),
                  )
                : const Icon(Icons.person, color: AppTheme.primary),
          ),
        ),
      ],
    );
  }
}

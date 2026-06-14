import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.isDark,
  });

  final String userName;
  final String? avatarUrl;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BrandSection(isDark: isDark),
        const Spacer(),
        _ProfilePill(
          userName: userName,
          avatarUrl: avatarUrl,
          isDark: isDark,
        ),
      ],
    );
  }
}

class _BrandSection extends StatelessWidget {
  const _BrandSection({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38.r,
          height: 38.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.20),
                blurRadius: 16.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9.r),
            child: Image.asset(
              'assets/app_icon.png',
              width: 38.r,
              height: 38.r,
              cacheWidth: decodePixelsFor(context, 38.r),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          'Monikid',
          style: context.typo.title.big.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.9,
            color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
          ),
        ),
      ],
    );
  }
}

class _ProfilePill extends StatelessWidget {
  const _ProfilePill({
    required this.userName,
    required this.avatarUrl,
    required this.isDark,
  });

  final String userName;
  final String? avatarUrl;
  final bool isDark;

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts
        .take(2)
        .where((p) => p.isNotEmpty)
        .map((p) => p[0].toUpperCase())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 132.w),
      padding: EdgeInsets.fromLTRB(10.w, 4.h, 4.h, 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999.r),
        color: isDark
            ? AppTheme.surfaceDark.withValues(alpha: 0.76)
            : Colors.white.withValues(alpha: 0.76),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.08),
            blurRadius: 24.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typo.label.medium.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.12,
                color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          _AvatarCircle(
            initials: _initials(userName),
            avatarUrl: avatarUrl,
          ),
        ],
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.initials, required this.avatarUrl});

  final String initials;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final hasImage = avatarUrl != null && avatarUrl!.isNotEmpty;
    return Container(
      width: 32.r,
      height: 32.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(Colors.white, AppTheme.primary, 0.26)!,
            Color.lerp(Colors.white, AppTheme.primary, 0.12)!,
          ],
        ),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.20)),
      ),
      child: hasImage
          ? ClipOval(
              child: Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                cacheWidth: decodePixelsFor(context, 32.r),
                errorBuilder: (_, __, ___) => _InitialsText(initials: initials),
              ),
            )
          : _InitialsText(initials: initials),
    );
  }
}

class _InitialsText extends StatelessWidget {
  const _InitialsText({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w900,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class JoinFamilyHeroSection extends StatelessWidget {
  const JoinFamilyHeroSection({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Container(
      padding: EdgeInsets.fromLTRB(18.w, 22.h, 18.w, 18.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : Colors.white.withValues(alpha: 0.95),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 18.h),
            blurRadius: 40.r,
            color: const Color(0xFF263B5B).withValues(alpha: 0.10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(label: s.joinFamilyEyebrow),
          SizedBox(height: 10.h),
          Text(
            s.joinFamilyHeroTitle,
            style: context.typo.headline.medium.copyWith(
              color: textColor,
              letterSpacing: -1.0,
              height: 1.06,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            s.joinFamilyHeroSubtitle,
            style: context.typo.body.medium.copyWith(color: mutedColor, height: 1.5),
          ),
          SizedBox(height: 16.h),
          _MiniCard(
            isDark: isDark,
            title: s.joinFamilyMiniCardTitle,
            desc: s.joinFamilyMiniCardDesc,
            textColor: textColor,
            mutedColor: mutedColor,
          ),
        ],
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.12),
                spreadRadius: 5.r,
                blurRadius: 0,
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
            letterSpacing: 0.96,
          ),
        ),
      ],
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({
    required this.isDark,
    required this.title,
    required this.desc,
    required this.textColor,
    required this.mutedColor,
  });

  final bool isDark;
  final String title;
  final String desc;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.surfaceVeryDark.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : Colors.white.withValues(alpha: 0.9),
        ),
      ),
      child: Row(
        children: [
          const _AvatarStack(),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typo.body.medium.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  desc,
                  style: context.typo.caption.big.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  static const _kSize = 30.0;
  static const _kStep = _kSize - 7.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (_kSize + _kStep * 2).r,
      height: _kSize.r,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            child: _Avatar('M', [Color(0xFF2F7F33), Color(0xFF59A75E)], Colors.white),
          ),
          Positioned(
            left: _kStep.r,
            child: const _Avatar('B', [Color(0xFF5D9E61), Color(0xFF87C889)], Colors.white),
          ),
          Positioned(
            left: _kStep.r * 2,
            child: const _Avatar('K', [Color(0xFFDCEEDC), Color(0xFFF3FAF3)], AppTheme.primary),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar(this.label, this.gradientColors, this.labelColor);

  final String label;
  final List<Color> gradientColors;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.r,
      height: 30.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.95), width: 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w800,
          color: labelColor,
        ),
      ),
    );
  }
}

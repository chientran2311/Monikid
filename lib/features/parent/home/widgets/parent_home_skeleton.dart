import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Loading placeholder for the parent home "has family" body. Mirrors
/// `_buildHasFamilyBody` (members row → summary card → section header →
/// transaction list). Static labels render solid; only data slots shimmer.
class ParentHomeSkeleton extends StatelessWidget {
  const ParentHomeSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.homeParFg;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Skeletonizer.zone(
      enabled: true,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 8.h),

          // ── Members section ──────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              s.homeParFamilyMembersLabel,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -0.02 * 18,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 96.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (_, __) => SizedBox(
                width: 56.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Bone.square(
                      size: 56.r,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    SizedBox(height: 8.h),
                    Bone.text(width: 44.w, fontSize: 13.sp),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // ── Summary card ─────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.surfaceDark : Colors.white,
                border: Border.all(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                ),
                borderRadius: BorderRadius.circular(28.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.homeParTotalMonthlySpending,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: mutedColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Bone.text(width: 180.w, fontSize: 34.sp),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bone.text(width: 80.w, fontSize: 13.sp),
                      Bone.text(width: 110.w, fontSize: 13.sp),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Bone(
                    width: double.infinity,
                    height: 8.h,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // ── Section header (static) ──────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.homeParRecentTransactionsLabel,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
                Text(
                  s.homeParSeeAll,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: mutedColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // ── Transaction rows (data) ──────────────────────
          ...List.generate(4, (_) => ParentTxRowSkeleton(isDark: isDark)),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }
}

/// Bone mirror of `TransactionItem`: 44.r icon + 2 text lines + amount.
/// Public so partial reloads (member switch) can reuse the same row shape.
/// Wrap in a `Skeletonizer`/`Skeletonizer.zone` to enable the shimmer.
class ParentTxRowSkeleton extends StatelessWidget {
  const ParentTxRowSkeleton({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(13.w),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.surfaceDark.withValues(alpha: 0.88)
              : Colors.white.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isDark
                ? AppTheme.borderDark
                : AppTheme.primary.withValues(alpha: 0.16),
          ),
        ),
        child: Row(
          children: [
            Bone.square(size: 44.r, borderRadius: BorderRadius.circular(16.r)),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(width: 120.w, fontSize: 15.sp),
                  SizedBox(height: 4.h),
                  Bone.text(width: 90.w, fontSize: 12.sp),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Bone.text(width: 60.w, fontSize: 15.sp),
          ],
        ),
      ),
    );
  }
}

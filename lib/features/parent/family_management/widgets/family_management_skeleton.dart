import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Loading placeholder for [FamilyManagementScreen]. Mirrors the real body
/// (family id card + member list card). Static section/field labels render
/// solid; only data slots (avatar, name, code, member rows) shimmer.
class FamilyManagementSkeleton extends StatelessWidget {
  const FamilyManagementSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final cardColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;

    return Skeletonizer.zone(
      enabled: true,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
          bottom: MediaQuery.of(context).padding.bottom + 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Gia đình" — static label
            _SectionLabel(text: s.familyManagementSectionFamily),

            // Family id card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Bone.square(
                        size: 52.w,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Bone.text(width: 140.w, fontSize: 16.sp),
                            SizedBox(height: 4.h),
                            // subtitle — static
                            Text(
                              s.familyManagementFamilyCardSubtitle,
                              style: context.typo.body.small.copyWith(
                                color: AppTheme.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Code box
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppTheme.darkSurfaceVariant
                          : AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // "MÃ MỜI" — static
                              Text(
                                s.familyManagementInviteCodeLabel.toUpperCase(),
                                style: context.typo.caption.medium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textMuted,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Bone.text(width: 120.w, fontSize: 24.sp),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Bone.square(
                          size: 44.w,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Members count label (count is data → bone)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 16.w, 8.h),
              child: Bone.text(width: 120.w, fontSize: 13.sp),
            ),

            // Member list card with 3 row bones
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                children:
                    List.generate(3, (i) => _MemberRowBone(showDivider: i < 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bone mirror of `MemberRow`: 44.w circle avatar + name + role.
class _MemberRowBone extends StatelessWidget {
  const _MemberRowBone({required this.showDivider});

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              Bone.circle(size: 44.w),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(width: 130.w, fontSize: 16.sp),
                    SizedBox(height: 2.h),
                    Bone.text(width: 70.w, fontSize: 12.sp),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 52.w),
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          ),
      ],
    );
  }
}

/// Copy of the screen's private `_SectionLabel` (kept solid).
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 16.w, 8.h),
      child: Text(
        text,
        style: context.typo.caption.big.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.textMuted,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

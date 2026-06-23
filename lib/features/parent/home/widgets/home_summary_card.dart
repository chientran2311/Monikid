import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class HomeSummaryCard extends StatelessWidget {
  const HomeSummaryCard({
    super.key,
    required this.isDark,
    required this.isLoading,
    required this.expenseMinor,
    required this.limitMinor,
  });

  final bool isDark;
  final bool isLoading;
  final int expenseMinor;
  final int limitMinor;

  String _formatAmount(int amount) {
    final formatted = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    ).format(amount);
    return '${formatted.trim()}đ';
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.homeParFg;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    final ratio = (limitMinor > 0)
        ? (expenseMinor / limitMinor).clamp(0.0, 1.0)
        : 0.0;
    final percentStr = (ratio * 100).toStringAsFixed(0);
    final showBudget = limitMinor > 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [AppTheme.surfaceDark, AppTheme.surfaceDark]
              : [
                  Color.lerp(AppTheme.primary, Colors.white, 0.76)!,
                  Color.lerp(AppTheme.primary, Colors.white, 0.88)!,
                  Colors.white,
                ],
          stops: isDark ? null : const [0.0, 0.45, 1.0],
        ),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 24.h),
            blurRadius: 60.r,
            color: AppTheme.primary.withValues(alpha: 0.10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              right: -70.w,
              top: -88.h,
              child: Container(
                width: 210.w,
                height: 210.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.primaryLight.withValues(alpha: 0.6),
                      AppTheme.primaryLight.withValues(alpha: 0.0),
                    ],
                    stops: const [0, 0.68],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: isLoading
                  ? Skeletonizer.zone(
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
                    )
                  : Column(
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
                        Text(
                          _formatAmount(expenseMinor),
                          style: TextStyle(
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                            letterSpacing: -0.05 * 34,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              s.homeParUsedPercent(percentStr),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: mutedColor,
                              ),
                            ),
                            if (showBudget)
                              Text(
                                '${s.homeParLimitLabel} ${_formatAmount(limitMinor)}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: mutedColor,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: SizedBox(
                            height: 8.h,
                            child: Stack(
                              children: [
                                Container(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.10)
                                      : AppTheme.primary.withValues(alpha: 0.12),
                                ),
                                FractionallySizedBox(
                                  widthFactor: ratio,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: ratio >= 1.0
                                            ? [
                                                AppTheme.redMedium.withValues(alpha: 0.8),
                                                AppTheme.redDark,
                                              ]
                                            : [
                                                AppTheme.primary.withValues(alpha: 0.7),
                                                AppTheme.primary,
                                              ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

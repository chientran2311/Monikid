import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class ParentTopCategoryCard extends StatelessWidget {
  const ParentTopCategoryCard({
    super.key,
    required this.isDark,
    required this.category,
  });

  final bool isDark;
  final StatisticCategoryData? category;

  @override
  Widget build(BuildContext context) {
    if (category == null) return const SizedBox.shrink();
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: isDark
                  ? AppTheme.borderDark
                  : Colors.white.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: isDark ? 0.0 : 0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  color: _bgColorFor(category!.categoryKey),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    category!.categoryIcon ?? '💸',
                    style: TextStyle(fontSize: 34.sp),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.parentStatisticTopCategoryTitle,
                      style: context.typo.caption.small.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textMuted,
                        fontSize: 11.sp,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      category!.categoryLabel,
                      style: context.typo.title.medium.copyWith(
                        fontWeight: FontWeight.w900,
                        color: textColor,
                        fontSize: 18.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.formatStatisticCompactCurrency(
                          category!.amountMinor),
                      style: context.typo.subtitle.medium.copyWith(
                        fontWeight: FontWeight.w900,
                        color: textColor,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        _Chip(
                          label: s.parentStatisticTopCategoryShare(
                            (category!.shareRatio * 100).toStringAsFixed(0),
                          ),
                          color: AppTheme.primary,
                        ),
                        if (category!.trendDirection !=
                            StatisticTrendDirection.none) ...[
                          SizedBox(width: 6.w),
                          _TrendBadge(
                              category: category!, isDark: isDark),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _bgColorFor(String categoryKey) {
  final colors = statisticAllocationColors;
  final base = colors[categoryKey.hashCode.abs() % colors.length];
  return base.withValues(alpha: 0.15);
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: context.typo.caption.small.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  const _TrendBadge({required this.category, required this.isDark});

  final StatisticCategoryData category;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final color = statisticTrendColor(category.trendDirection);
    final surface =
        statisticTrendSurfaceColor(category.trendDirection, isDark: isDark);
    final isUp = category.trendDirection == StatisticTrendDirection.up;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded,
            size: 14.r,
            color: color,
          ),
          if (category.changePercent != null)
            Text(
              '${category.changePercent!.toStringAsFixed(0)}%',
              style: context.typo.caption.small.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 11.sp,
              ),
            ),
        ],
      ),
    );
  }
}

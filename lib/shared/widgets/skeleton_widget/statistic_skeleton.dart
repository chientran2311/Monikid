import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/mock_up_data/statistic_mock_data.dart';

class StatisticSkeleton extends StatelessWidget {
  const StatisticSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _MockSmartInsightCard(),
          SizedBox(height: 20.h),
          const _MockBudgetOverviewCard(),
          SizedBox(height: 20.h),
          const _MockSpendingTrendSection(),
          SizedBox(height: 20.h),
          const _MockTopCategoriesSection(),
          SizedBox(height: 20.h),
          const _MockSpendingAllocationSection(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Smart insight card — mirrors StatisticSmartInsightCard
// ---------------------------------------------------------------------------

class _MockSmartInsightCard extends StatelessWidget {
  const _MockSmartInsightCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7FBF7), AppTheme.primaryLight],
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.10),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: context.typo.title.medium.copyWith(
                fontWeight: FontWeight.w900,
                color: AppTheme.primary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhận xét thông minh',
                  style: context.typo.body.medium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  kMockInsightText,
                  style: context.typo.caption.big.copyWith(
                    color: AppTheme.textGrey,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.10),
              ),
            ),
            child: Text(
              'Ưu tiên',
              style: context.typo.caption.small.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Budget overview card — mirrors StatisticBudgetOverviewCard (with limit set)
// ---------------------------------------------------------------------------

class _MockBudgetOverviewCard extends StatelessWidget {
  const _MockBudgetOverviewCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
          BoxShadow(
            color: Color(0x0A111811),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kMockBudgetLabel,
                      style: context.typo.caption.medium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textGrey,
                        letterSpacing: 0.1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          kMockBudgetSpentStr,
                          style: context.typo.display.small.copyWith(
                            fontWeight: FontWeight.w800,
                            color:
                                isDark ? AppTheme.textWhite : AppTheme.textBlack,
                            letterSpacing: -1.2,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          kMockBudgetLimitStr,
                          style: context.typo.body.small.copyWith(
                            color: AppTheme.textGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppTheme.successSurface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                  ),
                ),
                child: Text(
                  kMockBudgetStatusLabel,
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kMockUsageLabel,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textGrey,
                ),
              ),
              Text(
                kMockBudgetUsed,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: Container(
              height: 12.h,
              color: const Color(0xFFEAF1EA),
              child: FractionallySizedBox(
                widthFactor: 0.58,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kMockBudgetRemaining,
                style: context.typo.caption.medium.copyWith(
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                kMockBudgetAdjustHint,
                style: context.typo.caption.small.copyWith(
                  color: AppTheme.textGrey,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Spending trend section — mirrors StatisticSpendingTrendSection
// ---------------------------------------------------------------------------

class _MockSpendingTrendSection extends StatelessWidget {
  const _MockSpendingTrendSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kMockChartEyebrow,
            style: context.typo.caption.medium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textGrey,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            kMockChartTitle,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(height: 180.h, child: const _MockBarChart()),
          SizedBox(height: 14.h),
          const _MockPeriodPill(),
        ],
      ),
    );
  }
}

class _MockBarChart extends StatelessWidget {
  const _MockBarChart();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(kMockBarHeights.length, (i) {
        final isMax = kMockBarHeights[i] == 1.0;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  kMockBarAmounts[i],
                  textAlign: TextAlign.center,
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isMax ? AppTheme.primaryDark : AppTheme.textGrey,
                    fontSize: 9.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 120.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: kMockBarHeights[i].clamp(0.03, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: isMax
                                ? [
                                    const Color(0xFF4E9B52),
                                    AppTheme.primaryDark,
                                  ]
                                : [
                                    const Color(0xFF5AA05D),
                                    AppTheme.primary,
                                  ],
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                            bottom: Radius.circular(4.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  kMockBarDayLabels[i],
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isMax ? AppTheme.primaryDark : AppTheme.textGrey,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _MockPeriodPill extends StatelessWidget {
  const _MockPeriodPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 0, 12.w, 0),
      height: 38.h,
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            kMockPeriodLabel,
            style: context.typo.caption.big.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryDark,
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 12.r,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top categories section — mirrors StatisticTopCategoriesSection
// ---------------------------------------------------------------------------

class _MockTopCategoriesSection extends StatelessWidget {
  const _MockTopCategoriesSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const iconBackgrounds = [
      Color(0xFFEEF7EE),
      Color(0xFFE8F5E9),
      Color(0xFFEDF7EE),
    ];

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  kMockTopCatTitle,
                  style: context.typo.title.medium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  kMockViewAllLabel,
                  style: context.typo.caption.big.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...List.generate(kMockCategories.length, (index) {
            final cat = kMockCategories[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < kMockCategories.length - 1 ? 12.h : 0,
              ),
              child: _MockTrendItem(
                category: cat,
                iconBackground:
                    iconBackgrounds[index % iconBackgrounds.length],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MockTrendItem extends StatelessWidget {
  const _MockTrendItem({
    required this.category,
    required this.iconBackground,
  });

  final MockCategory category;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46.w,
          height: 46.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(category.emoji, style: TextStyle(fontSize: 20.sp)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: context.typo.body.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                category.count,
                style: context.typo.caption.medium.copyWith(
                  color: AppTheme.textGrey,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              category.amount,
              style: context.typo.body.medium.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              category.percent,
              style: context.typo.caption.medium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Spending allocation section — mirrors StatisticSpendingAllocationSection
// ---------------------------------------------------------------------------

class _MockSpendingAllocationSection extends StatelessWidget {
  const _MockSpendingAllocationSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const allocationColors = [
      Color(0xFF2F7F33),
      Color(0xFF4D9A50),
      Color(0xFF77B579),
    ];

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kMockAllocTitle,
            style: context.typo.title.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.textBlack,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 168.w,
                height: 168.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Donut ring approximation
                    Container(
                      width: 168.w,
                      height: 168.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F7F33),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 112.w,
                      height: 112.w,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.surfaceDark : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kMockTotalSpentLabel,
                          style: context.typo.caption.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          kMockTotalSpentStr,
                          style: context.typo.title.medium.copyWith(
                            fontWeight: FontWeight.w800,
                            color:
                                isDark ? AppTheme.textWhite : AppTheme.textBlack,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(kMockCategories.length, (index) {
                    final cat = kMockCategories[index];
                    final color =
                        allocationColors[index % allocationColors.length];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom:
                            index < kMockCategories.length - 1 ? 10.h : 0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 11.w,
                            height: 11.w,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              cat.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typo.caption.big.copyWith(
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppTheme.textWhite
                                    : AppTheme.textBlack,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            cat.percent,
                            style: context.typo.caption.big.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

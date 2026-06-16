import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_spending_trend_section.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_top_categories_section.dart';

/// Loading placeholder for the parent statistic tab. Mirrors the real success
/// layout (metric row → spending trend → expense categories → income
/// categories) by feeding the actual widgets mock data inside a [Skeletonizer],
/// so the transition into loaded content has no layout shift.
class ParentStatisticSkeleton extends StatelessWidget {
  const ParentStatisticSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final mockDailyExpenses = _mockDailyExpenses();
    final mockCategories = _mockCategories();

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          _MockMetricRow(isDark: isDark),
          SizedBox(height: 16.h),
          StatisticSpendingTrendSection(
            dailyExpenses: mockDailyExpenses,
            selectedTabIndex: 1,
            selectedDate: DateTime.now(),
            onDateSelected: (_) {},
          ),
          SizedBox(height: 24.h),
          ParentTopCategoriesSection(
            isDark: isDark,
            title: s.statisticTopCategoriesTitle,
            categories: mockCategories,
          ),
          SizedBox(height: 24.h),
          ParentTopCategoriesSection(
            isDark: isDark,
            title: s.statisticTopIncomeCategoriesTitle,
            categories: mockCategories,
            isExpense: false,
          ),
        ],
      ),
    );
  }

  List<StatisticDailyExpenseData> _mockDailyExpenses() {
    const heights = [40000, 90000, 60000, 120000, 70000, 100000, 50000];
    final anchor = DateTime(2024, 1, 1);
    return List.generate(
      heights.length,
      (i) => StatisticDailyExpenseData(
        date: anchor.add(Duration(days: i)),
        amountMinor: heights[i],
      ),
    );
  }

  List<StatisticCategoryData> _mockCategories() {
    return List.generate(
      3,
      (i) => StatisticCategoryData(
        categoryKey: 'mock_$i',
        categoryLabel: 'Danh mục',
        categoryIcon: '💸',
        amountMinor: 120000,
        transactionCount: 4,
        shareRatio: 0.3,
      ),
    );
  }
}

/// Three equal frosted-glass placeholder cards matching the real metric row.
class _MockMetricRow extends StatelessWidget {
  const _MockMetricRow({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _MockMetricCard(isDark: isDark)),
          SizedBox(width: 12.w),
          Expanded(child: _MockMetricCard(isDark: isDark)),
          SizedBox(width: 12.w),
          Expanded(child: _MockMetricCard(isDark: isDark)),
        ],
      ),
    );
  }
}

class _MockMetricCard extends StatelessWidget {
  const _MockMetricCard({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark
        ? AppTheme.textMuted
        : AppTheme.textBlack.withValues(alpha: 0.45);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
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
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nhãn',
                style: context.typo.caption.small.copyWith(
                  color: mutedColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '0đ',
                style: context.typo.subtitle.medium.copyWith(
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '— 0%',
                style: context.typo.caption.small.copyWith(
                  color: mutedColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

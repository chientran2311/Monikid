import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/mock_up_data/statistic_mock_data.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class StatisticSkeleton extends StatelessWidget {
  const StatisticSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final cardColor = isDark ? AppTheme.surfaceDark : Colors.white;

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MockSmartInsightCard(mutedColor: mutedColor),
          SizedBox(height: 20.h),
          _MockBudgetOverviewCard(),
          SizedBox(height: 20.h),
          _MockSpendingTrendSection(isDark: isDark, cardColor: cardColor),
          SizedBox(height: 20.h),
          _MockTopCategoriesSection(
            textColor: textColor,
            mutedColor: mutedColor,
            cardColor: cardColor,
          ),
          SizedBox(height: 20.h),
          _MockSpendingAllocationSection(cardColor: cardColor),
        ],
      ),
    );
  }
}

class _MockSmartInsightCard extends StatelessWidget {
  const _MockSmartInsightCard({required this.mutedColor});

  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppTheme.amberSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppTheme.amberBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppTheme.amberFill,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.wb_incandescent_rounded,
              size: 20.r,
              color: AppTheme.amberText,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              kMockInsightText,
              style: context.typo.body.small.copyWith(color: mutedColor, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockBudgetOverviewCard extends StatelessWidget {
  const _MockBudgetOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kMockBudgetLabel,
            style: context.typo.body.small.copyWith(color: Colors.white70),
          ),
          SizedBox(height: 8.h),
          Text(
            kMockBudgetAmount,
            style: context.typo.display.small.copyWith(color: Colors.white),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Còn lại',
                      style: context.typo.label.small.copyWith(color: Colors.white70),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      kMockBudgetRemaining,
                      style: context.typo.button.small.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đã dùng',
                      style: context.typo.label.small.copyWith(color: Colors.white70),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      kMockBudgetUsed,
                      style: context.typo.button.small.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 0.58,
              minHeight: 6.h,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockSpendingTrendSection extends StatelessWidget {
  const _MockSpendingTrendSection({
    required this.isDark,
    required this.cardColor,
  });

  final bool isDark;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: isDark
            ? Border.all(color: AppTheme.borderDark, width: 0.5)
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Xu hướng chi tiêu',
            style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : AppTheme.textBlack),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryLight.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockTopCategoriesSection extends StatelessWidget {
  const _MockTopCategoriesSection({
    required this.textColor,
    required this.mutedColor,
    required this.cardColor,
  });

  final Color textColor;
  final Color mutedColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh mục hàng đầu',
            style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w600, color: textColor),
          ),
          SizedBox(height: 12.h),
          ...kMockCategories.map(
            (cat) => _MockCategoryRow(
              name: cat.name,
              amount: cat.amount,
              count: cat.count,
              textColor: textColor,
              mutedColor: mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockCategoryRow extends StatelessWidget {
  const _MockCategoryRow({
    required this.name,
    required this.amount,
    required this.count,
    required this.textColor,
    required this.mutedColor,
  });

  final String name;
  final String amount;
  final String count;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w600, color: textColor),
                ),
                SizedBox(height: 2.h),
                Text(
                  count,
                  style: context.typo.label.medium.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w600, color: textColor),
          ),
        ],
      ),
    );
  }
}

class _MockSpendingAllocationSection extends StatelessWidget {
  const _MockSpendingAllocationSection({required this.cardColor});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Container(
            width: 140.w,
            height: 140.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryLight,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: kMockCategories.map(
                (cat) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    children: [
                      Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          cat.name,
                          style: context.typo.label.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

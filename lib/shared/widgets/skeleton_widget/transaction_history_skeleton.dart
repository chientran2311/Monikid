import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/mock_up_data/transaction_history_mock_data.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class TransactionHistorySkeletonNew extends StatelessWidget {
  const TransactionHistorySkeletonNew({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final cardColor = isDark ? AppTheme.surfaceDark : Colors.white;

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _MockSummaryCard(isDark: isDark),
          ),
          SliverToBoxAdapter(
            child: _MockTabBar(isDark: isDark),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _MockDateGroup(
                group: kMockTxGroups[i],
                textColor: textColor,
                mutedColor: mutedColor,
                cardColor: cardColor,
              ),
              childCount: kMockTxGroups.length,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }
}

class _MockSummaryCard extends StatelessWidget {
  const _MockSummaryCard({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [AppTheme.greenDarker, AppTheme.greenDark]
                : [AppTheme.primary, AppTheme.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kMockTabIncome,
                    style: context.typo.label.medium.copyWith(color: Colors.white70),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    kMockSummaryIncome,
                    style: context.typo.title.small.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(width: 1.w, height: 48.h, color: Colors.white30),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kMockTabExpense,
                      style: context.typo.label.medium.copyWith(color: Colors.white70),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      kMockSummaryExpense,
                      style: context.typo.title.small.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockTabBar extends StatelessWidget {
  const _MockTabBar({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final activeColor = AppTheme.primary;
    final inactiveColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.borderDark.withValues(alpha: 0.3)
              : AppTheme.borderLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    kMockTabExpense,
                    style: context.typo.body.small.copyWith(fontWeight: FontWeight.w600, color: activeColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  kMockTabIncome,
                  style: context.typo.body.small.copyWith(fontWeight: FontWeight.w500, color: inactiveColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockDateGroup extends StatelessWidget {
  const _MockDateGroup({
    required this.group,
    required this.textColor,
    required this.mutedColor,
    required this.cardColor,
  });

  final MockTxGroup group;
  final Color textColor;
  final Color mutedColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                group.date,
                style: context.typo.label.medium.copyWith(fontWeight: FontWeight.w600, color: mutedColor),
              ),
              Text(
                group.sum,
                style: context.typo.label.medium.copyWith(fontWeight: FontWeight.w600, color: mutedColor),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ...group.items.map(
            (item) => _MockTxRow(
              title: item.title,
              category: item.category,
              amount: item.amount,
              textColor: textColor,
              mutedColor: mutedColor,
              cardColor: cardColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockTxRow extends StatelessWidget {
  const _MockTxRow({
    required this.title,
    required this.category,
    required this.amount,
    required this.textColor,
    required this.mutedColor,
    required this.cardColor,
  });

  final String title;
  final String category;
  final String amount;
  final Color textColor;
  final Color mutedColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typo.body.medium.copyWith(fontWeight: FontWeight.w600, color: textColor),
                ),
                SizedBox(height: 2.h),
                Text(
                  category,
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

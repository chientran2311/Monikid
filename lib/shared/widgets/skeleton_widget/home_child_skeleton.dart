import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/mock_up_data/home_mock_data.dart';

class HomeChildSkeleton extends StatelessWidget {
  const HomeChildSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
              child: _MockHeader(isDark: isDark, textColor: textColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
              child: const _MockSummaryCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 8.h),
              child: _MockQuickActions(isDark: isDark, textColor: textColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
              child: _MockRecentTransactions(
                isDark: isDark,
                textColor: textColor,
                mutedColor: mutedColor,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header — mirrors HomeHeader: brand section + spacer + profile pill
// ---------------------------------------------------------------------------

class _MockHeader extends StatelessWidget {
  const _MockHeader({required this.isDark, required this.textColor});

  final bool isDark;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Brand section
        Image.asset(
          'assets/app_icon.png',
          width: 38.r,
          height: 38.r,
          cacheWidth: decodePixelsFor(context, 38.r),
        ),
        SizedBox(width: 10.w),
        Text(
          'Monikid',
          style: context.typo.title.big.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.9,
            color: textColor,
          ),
        ),
        const Spacer(),
        // Profile pill
        Container(
          constraints: BoxConstraints(maxWidth: 132.w),
          padding: EdgeInsets.fromLTRB(10.w, 4.h, 4.h, 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999.r),
            color: isDark ? AppTheme.surfaceDark : Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  kMockUserName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.label.medium.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.12,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 32.r,
                height: 32.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Summary card — mirrors HomeMonthlySummaryCard
// ---------------------------------------------------------------------------

class _MockSummaryCard extends StatelessWidget {
  const _MockSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.6, -1),
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(Colors.white, AppTheme.primary, 0.16)!,
            Colors.white,
          ],
        ),
        border: Border.all(
          color: Color.lerp(Colors.white, AppTheme.primary, 0.14)!,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.10),
            blurRadius: 32.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _MockSummaryHeader(),
          SizedBox(height: 14.h),
          const _MockAmountRow(),
          SizedBox(height: 14.h),
          const _MockStatCards(),
        ],
      ),
    );
  }
}

class _MockSummaryHeader extends StatelessWidget {
  const _MockSummaryHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kMockEyebrow,
                style: context.typo.caption.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      Color.lerp(AppTheme.textGrey, AppTheme.primary, 0.60),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                kMockSummaryTitle,
                style: context.typo.title.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textBlack,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            border: Border.all(
              color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
            ),
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            kMockMonthPill,
            style: context.typo.label.small.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MockAmountRow extends StatelessWidget {
  const _MockAmountRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          kMockExpenseAmount,
          style: TextStyle(
            fontSize: 38.sp,
            fontWeight: FontWeight.w900,
            color: AppTheme.textBlack,
            letterSpacing: -1.5,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            kMockRemainingBadge,
            style: context.typo.label.small.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MockStatCards extends StatelessWidget {
  const _MockStatCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _MockStatCard(
            label: kMockLimitStatLabel,
            value: kMockLimitStatValue,
            subtitle: kMockLimitStatSub,
          ),
        ),
        SizedBox(width: 10.w),
        const Expanded(
          child: _MockStatCard(
            label: kMockTxStatLabel,
            value: kMockTxStatValue,
            subtitle: kMockTxStatSub,
          ),
        ),
        SizedBox(width: 10.w),
        const Expanded(
          child: _MockStatCard(
            label: kMockTopCatStatLabel,
            value: kMockTopCatStatValue,
            subtitle: kMockTopCatStatSub,
          ),
        ),
      ],
    );
  }
}

class _MockStatCard extends StatelessWidget {
  const _MockStatCard({
    required this.label,
    required this.value,
    required this.subtitle,
  });

  final String label;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        border: Border.all(
          color: Color.lerp(Colors.white, AppTheme.primary, 0.12)!,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.typo.caption.small.copyWith(
              fontWeight: FontWeight.w600,
              color: Color.lerp(AppTheme.textGrey, AppTheme.primary, 0.55),
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.typo.label.big.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.textBlack,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.typo.caption.small.copyWith(
              color: Color.lerp(AppTheme.textGrey, AppTheme.primary, 0.40),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick actions — mirrors HomeQuickActions: title + 2 QuickAction cards
// ---------------------------------------------------------------------------

class _MockQuickActions extends StatelessWidget {
  const _MockQuickActions({required this.isDark, required this.textColor});

  final bool isDark;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kMockQuickActionsTitle,
          style: context.typo.title.small.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textBlack,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _MockQuickActionCard(
                emoji: '🧾',
                title: kMockScanBillTitle,
                subtitle: kMockScanBillSubtitle,
                isDark: isDark,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _MockQuickActionCard(
                emoji: '🎯',
                title: kMockSetLimitTitle,
                subtitle: kMockSetLimitSubtitle,
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MockQuickActionCard extends StatelessWidget {
  const _MockQuickActionCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Container(
      constraints: BoxConstraints(minHeight: 72.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.surfaceDark.withValues(alpha: 0.84)
            : Colors.white.withValues(alpha: 0.84),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.16)),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.07),
            blurRadius: 28.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Color.lerp(Colors.white, AppTheme.primary, 0.10),
              border: Border.all(
                color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
              ),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: 18.sp)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.button.small.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.label.small.copyWith(
                    color: mutedColor,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recent transactions — mirrors HomeRecentTransactionsSection + TransactionItem
// ---------------------------------------------------------------------------

class _MockRecentTransactions extends StatelessWidget {
  const _MockRecentTransactions({
    required this.isDark,
    required this.textColor,
    required this.mutedColor,
  });

  final bool isDark;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kMockRecentTitle,
              style: context.typo.subtitle.medium.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              kMockViewAll,
              style: context.typo.body.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ...kMockTransactionsFull.map(
          (tx) => _MockTransactionItem(
            tx: tx,
            isDark: isDark,
            mutedColor: mutedColor,
          ),
        ),
      ],
    );
  }
}

class _MockTransactionItem extends StatelessWidget {
  const _MockTransactionItem({
    required this.tx,
    required this.isDark,
    required this.mutedColor,
  });

  final MockTransactionFull tx;
  final bool isDark;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.surfaceDark.withValues(alpha: 0.88)
            : Colors.white.withValues(alpha: 0.88),
        border: Border.all(
          color: isDark
              ? AppTheme.borderDark
              : AppTheme.primary.withValues(alpha: 0.16),
        ),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.06),
            blurRadius: 28.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Category icon
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.30),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.14),
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(tx.emoji, style: TextStyle(fontSize: 18.sp)),
            ),
          ),
          SizedBox(width: 12.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.body.medium.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.2,
                    color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      tx.timeStr,
                      style: context.typo.caption.medium
                          .copyWith(color: mutedColor),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      width: 4.r,
                      height: 4.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mutedColor.withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        tx.categoryLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.typo.caption.medium
                            .copyWith(color: mutedColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Amount badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tx.amountStr,
                style: context.typo.body.medium.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                  color: tx.isExpense ? AppTheme.redAlert : AppTheme.primary,
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  tx.isExpense ? 'Thành công' : 'Hoàn tất',
                  style: context.typo.caption.small.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

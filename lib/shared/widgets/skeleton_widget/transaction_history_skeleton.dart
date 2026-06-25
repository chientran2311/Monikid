import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/mock_up_data/transaction_history_mock_data.dart';

/// Full-screen loading placeholder for the transaction history screen.
///
/// Mirrors the real UI 1:1 (light glassmorphism [SummaryCard] +
/// [SwitchTabThreeItem] + grouped [TransactionItem] list) and lets
/// [Skeletonizer] paint shimmer bones over it, so colors/spacing/shape always
/// match the loaded screen. Shared by both the child and parent history
/// screens via `TransactionHistoryBody`.
class TransactionHistorySkeleton extends StatelessWidget {
  const TransactionHistorySkeleton({
    super.key,
    this.showMonthlyLimit = true,
    this.showBadge = false,
  });

  /// Renders the third "Hạn mức còn lại" stat box (child view). Parent passes
  /// false → 2 stat boxes, matching its real summary card.
  final bool showMonthlyLimit;

  /// Renders the trailing amount + tag badge on each row (parent view).
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
              child: _MockSummaryCard(
                isDark: isDark,
                showMonthlyLimit: showMonthlyLimit,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
              child: _MockSwitchTabs(isDark: isDark),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _MockDateGroup(
                group: kMockTxGroups[i],
                isDark: isDark,
                showBadge: showBadge,
              ),
              childCount: kMockTxGroups.length,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }
}

/// Single-row placeholder for inline "load more" / list-loading states.
/// Mirrors one real [TransactionItem] card and self-wraps in [Skeletonizer]
/// because it is rendered outside the full-screen skeleton.
class TransactionItemSkeleton extends StatelessWidget {
  const TransactionItemSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: _MockTxRow(
        item: kMockTxGroups.first.items.first,
        isDark: isDark,
        showBadge: true,
      ),
    );
  }
}

// =============================================================================
// SUMMARY CARD — mirrors SummaryCard (_LightSummaryCard / _DarkSummaryCard)
// =============================================================================

class _MockSummaryCard extends StatelessWidget {
  const _MockSummaryCard({required this.isDark, required this.showMonthlyLimit});

  final bool isDark;
  final bool showMonthlyLimit;

  @override
  Widget build(BuildContext context) {
    if (isDark) return const _MockDarkSummaryCard();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(AppTheme.primary, Colors.white, 0.84)!,
            Colors.white.withValues(alpha: 0.94),
          ],
        ),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.16)),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.10),
            blurRadius: 60.r,
            offset: Offset(0, 24.h),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: eyebrow + month label + badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kMockSummaryEyebrow,
                    style: AppTextStyleFactory.style(
                      size: AppFontSizes.captionBig,
                      weight: FontWeight.w800,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    kMockSummaryMonth,
                    style: AppTextStyleFactory.style(
                      size: AppFontSizes.titleMedium,
                      weight: FontWeight.w700,
                      color: AppTheme.textBlack,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  kMockSummaryBadge,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.captionBig,
                    weight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Main amount
          Text(
            kMockSummaryMainAmount,
            style: AppTextStyleFactory.style(
              size: 34,
              weight: FontWeight.w900,
              color: AppTheme.textBlack,
            ),
          ),
          SizedBox(height: 14.h),
          // Stat boxes
          Row(
            children: [
              const Expanded(
                child: _MockStatBox(
                  label: kMockStatIncomeLabel,
                  value: kMockStatIncomeValue,
                  valueColor: Color(0xFF23815E),
                ),
              ),
              SizedBox(width: 10.w),
              const Expanded(
                child: _MockStatBox(
                  label: kMockStatExpenseLabel,
                  value: kMockStatExpenseValue,
                  valueColor: AppTheme.redAlert,
                ),
              ),
              if (showMonthlyLimit) ...[
                SizedBox(width: 10.w),
                const Expanded(
                  child: _MockStatBox(
                    label: kMockStatLimitLabel,
                    value: kMockStatLimitValue,
                    valueColor: AppTheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _MockStatBox extends StatelessWidget {
  const _MockStatBox({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.captionSmall,
              weight: FontWeight.w700,
              color: AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyleFactory.style(
              size: AppFontSizes.bodyMedium,
              weight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockDarkSummaryCard extends StatelessWidget {
  const _MockDarkSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF1E5222)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.2),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kMockSummaryMonth.toUpperCase(),
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                  color: AppTheme.surfaceLightGreen,
                ),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20.r,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            kMockSummaryMainAmount,
            style: context.typo.headline.medium.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              const Expanded(
                child: _MockDarkBadge(
                  icon: Icons.arrow_downward,
                  label: 'Chi: $kMockStatExpenseValue',
                ),
              ),
              SizedBox(width: 16.w),
              const Expanded(
                child: _MockDarkBadge(
                  icon: Icons.arrow_upward,
                  label: 'Thu: $kMockStatIncomeValue',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MockDarkBadge extends StatelessWidget {
  const _MockDarkBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: Colors.white),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              label,
              style: context.typo.caption.big.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SWITCH TABS — mirrors SwitchTabThreeItem (track + first pill active)
// =============================================================================

class _MockSwitchTabs extends StatelessWidget {
  const _MockSwitchTabs({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final trackColor =
        isDark ? AppTheme.surfaceVariant : AppTheme.controlTrack;
    final pillColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;

    return Container(
      height: 42.h,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // Active pill (first segment)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: BorderRadius.circular(11.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2.h),
                    blurRadius: 8.r,
                    color: Colors.black.withValues(alpha: 0.06),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  kMockTabAll,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.bodyMedium,
                    weight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),
          ),
          _MockSegmentLabel(label: kMockTabIncome, isDark: isDark),
          _MockSegmentLabel(label: kMockTabExpense, isDark: isDark),
        ],
      ),
    );
  }
}

class _MockSegmentLabel extends StatelessWidget {
  const _MockSegmentLabel({required this.label, required this.isDark});

  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: AppTextStyleFactory.style(
            size: AppFontSizes.bodyMedium,
            weight: FontWeight.w700,
            color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// DATE GROUP + ROW — mirrors GroupedTransactionList + TransactionItem
// =============================================================================

class _MockDateGroup extends StatelessWidget {
  const _MockDateGroup({
    required this.group,
    required this.isDark,
    required this.showBadge,
  });

  final MockTxGroup group;
  final bool isDark;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final isIncome = group.sum.startsWith('+');
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                group.date,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                group.sum,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isIncome ? const Color(0xFF2563eb) : AppTheme.redAlert,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...group.items.map(
            (item) => _MockTxRow(
              item: item,
              isDark: isDark,
              showBadge: showBadge,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockTxRow extends StatelessWidget {
  const _MockTxRow({
    required this.item,
    required this.isDark,
    required this.showBadge,
  });

  final MockTxItem item;
  final bool isDark;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
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
              color: AppTheme.txCategoryOtherBg,
              border: Border.all(color: AppTheme.txCategoryOtherBorder),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(item.emoji, style: TextStyle(fontSize: 18.sp)),
            ),
          ),
          SizedBox(width: 12.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
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
                      item.meta,
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
                        item.category,
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
          if (showBadge) ...[
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.amount,
                  style: context.typo.body.medium.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                    color:
                        item.isExpense ? AppTheme.redAlert : AppTheme.primary,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    'Mới',
                    style: context.typo.caption.small.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

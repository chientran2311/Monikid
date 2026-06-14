import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_spending_trend_section.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_screen.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_provider.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_statistic_child_selector.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_statistic_state_card.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_top_categories_section.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/glass_tab_app_bar.dart';
import 'package:monikid/shared/widgets/switchtab_three_item.dart';

class StatisticTabParent extends ConsumerWidget {
  const StatisticTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(parentStatisticNotifierProvider);
    final notifier = ref.read(parentStatisticNotifierProvider.notifier);

    final homeState = ref.watch(parentHomeNotifierProvider);
    final children = homeState.members.where((m) => m.role == 'child').toList();
    final selectedChildId = homeState.selectedMemberId;
    final selectedChild =
        children.where((c) => c.uid == selectedChildId).firstOrNull ??
            children.firstOrNull;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      body: AppBackground(
        child: Column(
          children: [
            // Reuse the home tab's glass app-bar pattern (title + trailing).
            SafeArea(
              bottom: false,
              child: GlassTabAppBar(
                title: s.parentStatisticTitle,
                titleFontSize: 28, // HTML .app-header h1 = 28px
                trailing: ParentStatisticChildSelector(
                  isDark: isDark,
                  children: children,
                  selectedChild: selectedChild,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                children: [
                  // Period tabs — HTML: rgba(0,0,0,0.05) track
                  SwitchTabThreeItem(
                    title1: s.parentStatisticWeek,
                    title2: s.parentStatisticMonth,
                    title3: s.parentStatisticYear,
                    selectedIndex: state.period.index,
                    onChanged: (i) => notifier.setPeriod(
                      ParentStatisticPeriod.values[i],
                    ),
                  ),
                  if (children.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: ParentStatisticStateCard(
                        isDark: isDark,
                        emoji: '📊',
                        message: s.parentStatisticSelectChild,
                      ),
                    )
                  else if (state.isLoading)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: ParentStatisticStateCard(
                        isDark: isDark,
                        showSpinner: true,
                        message: s.parentStatisticLoading,
                      ),
                    )
                  else if (state.hasError)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: ParentStatisticStateCard(
                        isDark: isDark,
                        emoji: '⚠️',
                        message:
                            state.errorMessage ?? s.parentStatisticLoadError,
                        action: _RetryButton(
                          label: s.parentStatisticRetry,
                          onTap: notifier.retry,
                        ),
                      ),
                    )
                  else ...[
                    // 3-card metrics — HTML: .metrics-grid { margin: 24px 0 }
                    SizedBox(height: 24.h),
                    _SummaryRow(state: state, isDark: isDark),
                    SizedBox(height: 16.h),
                    StatisticSpendingTrendSection(
                      dailyExpenses: state.resolvedDailyData,
                      selectedTabIndex: state.period.index,
                      selectedDate: state.selectedDate ?? DateTime.now(),
                      onDateSelected: notifier.setSelectedDate,
                    ),
                    SizedBox(height: 24.h),
                    ParentTopCategoriesSection(
                      isDark: isDark,
                      categories: state.topCategories,
                      onItemTap: selectedChild == null
                          ? null
                          : (category) => context.push(
                                AppRoutes.parentCategoryTransactions,
                                extra: ParentCategoryTransactionsArgs(
                                  childUid: selectedChild.uid,
                                  categoryKey: category.categoryKey,
                                  categoryLabel: category.categoryLabel,
                                  period: state.period,
                                ),
                              ),
                    ),
                  ],
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.state, required this.isDark});

  final ParentStatisticState state;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final percentAbs = state.percentChange.abs().toStringAsFixed(0);
    final isDown = state.trendDirection == StatisticTrendDirection.down;
    final isUp = state.trendDirection == StatisticTrendDirection.up;

    final trendBadge = isDown
        ? '↓ $percentAbs%'
        : isUp
            ? '↑ $percentAbs%'
            : '— 0%';
    // HTML: .metric-change.down { color: --success } .up { color: --danger }
    final trendColor =
        isDown ? AppTheme.primary : (isUp ? AppTheme.redAlert : AppTheme.textBlack.withValues(alpha: 0.35));

    final prevLabel = context.formatStatisticCompactCurrency(
      state.prevTotalExpenseMinor,
    );
    final prevSubLabel = isDown
        ? '↓ ${s.parentStatisticTrendGood}'
        : isUp
            ? '↑ ${s.parentStatisticTrendBad}'
            : '— ${s.parentStatisticSpendingStable}';
    final prevSubColor =
        isDown ? AppTheme.primary : (isUp ? AppTheme.redAlert : AppTheme.textBlack.withValues(alpha: 0.35));

    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            isDark: isDark,
            label: s.parentStatisticTotalExpenseLabel,
            value: context.formatStatisticCompactCurrency(
              state.totalExpenseMinor,
            ),
            subLabel: trendBadge,
            subColor: trendColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _MetricCard(
            isDark: isDark,
            label: s.parentStatisticTxCountLabel,
            value: '${state.totalTransactionCount}',
            subLabel: null,
            subColor: null,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _MetricCard(
            isDark: isDark,
            label: s.parentStatisticPrevPeriodLabel,
            value: prevLabel,
            subLabel: prevSubLabel,
            subColor: prevSubColor,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.isDark,
    required this.label,
    required this.value,
    required this.subLabel,
    required this.subColor,
  });

  final bool isDark;
  final String label;
  final String value;
  final String? subLabel;
  final Color? subColor;

  @override
  Widget build(BuildContext context) {
    // HTML .metric-card tokens:
    // bg: rgba(255,255,255,.94)  border: mix(accent 16%, white)
    // shadow: 0 8px 20px rgba(47,127,51,.04)  radius: 20px
    final bgColor =
        isDark ? AppTheme.surfaceDark : Colors.white.withValues(alpha: 0.94);
    final borderColor = isDark
        ? AppTheme.borderDark
        : AppTheme.primary.withValues(alpha: 0.16);
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark
        ? AppTheme.textMuted
        : AppTheme.textBlack.withValues(alpha: 0.45);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: isDark ? 0.0 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.typo.caption.small.copyWith(
              color: mutedColor,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.02 * 11,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: context.typo.subtitle.medium.copyWith(
              fontWeight: FontWeight.w900,
              color: textColor,
              fontSize: 16.sp,
            ),
          ),
          if (subLabel != null) ...[
            SizedBox(height: 2.h),
            Text(
              subLabel!,
              style: context.typo.caption.small.copyWith(
                color: subColor,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Primary pill button shown under the error message to retry the fetch.
class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999.r),
        ),
      ),
      child: Text(
        label,
        style: context.typo.body.medium.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

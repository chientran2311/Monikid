import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_screen.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_provider.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_state.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_period_segmented_control.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_spending_summary_card.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_spending_trend_section.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_statistic_error_card.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_statistic_message_card.dart';
import 'package:monikid/features/parent/statistic/widgets/parent_top_categories_section.dart';
import 'package:monikid/shared/widgets/app_popup_menu_button.dart';

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
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.parentStatisticTitle,
                  style: context.typo.headline.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppTheme.textBlack,
                ),
                ),
                AppPopupMenuButton<String>(
                  onSelected: (childId) {
                    ref
                        .read(parentHomeNotifierProvider.notifier)
                        .selectMember(childId);
                  },
                  itemBuilder: (context) {
                    return children.map((child) {
                      return PopupMenuItem<String>(
                        value: child.uid,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12.r,
                              backgroundImage: child.avatarUrl != null
                                  ? NetworkImage(child.avatarUrl!)
                                  : null,
                              child: child.avatarUrl == null
                                  ? Text(
                                      child.displayName.isNotEmpty
                                          ? child.displayName[0].toUpperCase()
                                          : 'C',
                                      style: context.typo.caption.big,
                                    )
                                  : null,
                            ),
                            SizedBox(width: 8.w),
                            Text(child.displayName),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  child: CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppTheme.primary,
                    backgroundImage: selectedChild?.avatarUrl != null
                        ? NetworkImage(selectedChild!.avatarUrl!)
                        : null,
                    child: selectedChild?.avatarUrl == null
                        ? (selectedChild != null
                            ? Text(
                                selectedChild.displayName.isNotEmpty
                                    ? selectedChild.displayName[0].toUpperCase()
                                    : 'C',
                                style: context.typo.subtitle.small.copyWith(
                                color: Colors.white,
                              ),
                              )
                            : Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 20.r,
                              ))
                        : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            ParentPeriodSegmentedControl(
              isDark: isDark,
              selected: state.period,
              onChanged: notifier.setPeriod,
            ),
            SizedBox(height: 16.h),
            if (children.isEmpty)
              ParentStatisticMessageCard(
                isDark: isDark,
                message: s.parentStatisticSelectChild,
              )
            else if (state.isLoading)
              ParentStatisticMessageCard(
                isDark: isDark,
                message: s.parentStatisticLoading,
              )
            else if (state.hasError)
              ParentStatisticErrorCard(
                isDark: isDark,
                message: state.errorMessage ?? s.parentStatisticLoadError,
                onRetry: notifier.retry,
              )
            else ...[
              ParentSpendingSummaryCard(
                isDark: isDark,
                totalAmountLabel:
                    context.formatStatisticCurrency(state.totalExpenseMinor),
                percentChange: state.percentChange,
                trendDirection: state.trendDirection,
              ),
              if (state.status == ParentStatisticStatus.empty) ...[
                SizedBox(height: 16.h),
                ParentStatisticMessageCard(
                  isDark: isDark,
                  message: s.parentStatisticNoData,
                ),
              ],
            ],
            SizedBox(height: 16.h),
            ParentSpendingTrendSection(
              isDark: isDark,
              period: state.period,
              dailyData: state.resolvedDailyData,
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
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

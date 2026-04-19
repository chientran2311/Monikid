import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/student/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_budget_overview_card.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_category_change_section.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_period_filter_section.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_smart_insight_card.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_spending_allocation_section.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_spending_trend_section.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_state_feedback.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_top_categories_section.dart';
import 'package:monikid/features/student/statistic/widgets/statistic_ui_helpers.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_provider.dart';

import 'statistic_models.dart';
import 'statistic_provider.dart';

class StatisticScreen extends HookConsumerWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final state = ref.watch(statisticProvider);
    final notifier = ref.read(statisticProvider.notifier);
    final historyNotifier = ref.read(transactionHistoryProvider.notifier);
    final scrollController = useScrollController();
    final currentOverview = state.resolvedCurrentOverview;
    final selectedDate = state.selectedDate ?? DateTime.now();
    final comparisonDirection =
        state.budgetOverview?.comparisonDirection ??
        StatisticTrendDirection.none;

    useEffect(
      () {
        void onScroll() {
          if (!scrollController.hasClients ||
              state.isLoading ||
              state.isLoadingMore ||
              state.isRefreshing ||
              !state.hasMore) {
            return;
          }

          if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 120.h) {
            unawaited(notifier.loadMore());
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [
        scrollController,
        state.isLoading,
        state.isLoadingMore,
        state.isRefreshing,
        state.hasMore,
      ],
    );

    Future<void> handleViewAll() async {
      await historyNotifier.getTransByCategory(null);
      await historyNotifier.getTransByDate(null);
      await historyNotifier.setTypeFilter('expense');
      if (context.mounted) {
        context.push(AppRoutes.transactionHistory);
      }
    }

    Future<void> handleSetupLimit() async {
      await showSetMoneyLimitDialog(context, ref);
      await notifier.refresh();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppTheme.backgroundDark
          : AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.surfaceDark.withValues(alpha: 0.92)
            : AppTheme.backgroundLight.withValues(alpha: 0.92),
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          context.l10n.statisticTitle,
          style: TextStyle(
            fontSize: 18.r,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppTheme.textBlack,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: notifier.refresh,
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatisticPeriodFilterSection(
                      selectedMonthIndex: state.selectedMonthIndex,
                      selectedDate: selectedDate,
                      onModeChanged: (value) =>
                          unawaited(notifier.setMonthIndex(value)),
                      onDateSelected: (value) =>
                          unawaited(notifier.setSelectedDate(value)),
                    ),
                    SizedBox(height: 20.h),
                    if (state.status == StatisticStatus.error) ...[
                      StatisticErrorCard(
                        message:
                            state.errorMessage ??
                            context.l10n.homeStudentLoadError,
                        onRetry: () => unawaited(notifier.refresh()),
                      ),
                    ] else if (state.isLoading && !state.hasData) ...[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48.h),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ] else ...[
                      StatisticSmartInsightCard(
                        message: context.statisticInsightMessage(
                          insight: currentOverview.smartInsight,
                          selectedMonthIndex: state.selectedMonthIndex,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      StatisticBudgetOverviewCard(
                        budgetOverview: state.budgetOverview,
                        comparisonMessage: context.statisticComparisonMessage(
                          budgetOverview: state.budgetOverview,
                          selectedMonthIndex: state.selectedMonthIndex,
                        ),
                        onSetupLimit: handleSetupLimit,
                      ),
                      SizedBox(height: 20.h),
                      if (state.isEmpty) ...[
                        const StatisticEmptyCard(),
                      ] else ...[
                        StatisticSpendingTrendSection(
                          selectedMonthIndex: state.selectedMonthIndex,
                          currentOverview: currentOverview,
                          comparisonDirection: comparisonDirection,
                          comparisonPercent:
                              state.budgetOverview?.comparisonPercent,
                        ),
                        SizedBox(height: 20.h),
                        StatisticTopCategoriesSection(
                          categories: currentOverview.categories,
                          onViewAll: handleViewAll,
                        ),
                        SizedBox(height: 20.h),
                        StatisticCategoryChangeSection(
                          strongestIncrease: currentOverview.strongestIncrease,
                          strongestDecrease: currentOverview.strongestDecrease,
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: double.infinity,
                          child: StatisticSpendingAllocationSection(
                            categories: currentOverview.categories,
                            totalExpenseMinor:
                                currentOverview.totalExpenseMinor,
                          ),
                        ),
                      ],
                    ],
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

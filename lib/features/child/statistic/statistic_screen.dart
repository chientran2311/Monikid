import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/screen_page_header.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_budget_overview_card.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_category_change_section.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_period_filter_section.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_smart_insight_card.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_spending_allocation_section.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_spending_trend_section.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_state_feedback.dart';
import 'package:monikid/shared/widgets/skeleton_widget/statistic_skeleton.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transactions_args.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_top_categories_section.dart';
import 'package:monikid/features/transaction/transaction_type.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

import 'statistic_models.dart';
import 'statistic_provider.dart';

class StatisticScreen extends HookConsumerWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(statisticProvider);
    final notifier = ref.read(statisticProvider.notifier);
    final scrollController = useScrollController();

    ref.listen(statisticProvider, (prev, next) {
      if (next.errorMessage != null && next.errorMessage != prev?.errorMessage) {
        context.showErrorSnackBar(context.l10n.statisticLoadError);
      }
    });
    final currentOverview = state.resolvedCurrentOverview;
    final selectedDate = state.selectedDate ?? DateTime.now();

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

    Future<void> handleSetupLimit() async {
      await showSetMoneyLimitDialog(context, ref);
      await notifier.refresh();
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
      body: AppBackground(
        whiteBackground: true,
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: notifier.refresh,
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
                    child: ScreenPageHeader(
                      eyebrow: context.l10n.statisticHeaderEyebrow,
                      title: context.l10n.statisticTitle,
                      subtitle: context.l10n.statisticHeaderSubhead,
                      isDark: isDark,
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatisticPeriodFilterSection(
                        selectedTabIndex: state.selectedTabIndex,
                        onModeChanged: (value) =>
                            unawaited(notifier.setTabIndex(value)),
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
                        const StatisticSkeleton(),
                      ] else ...[
                        StatisticSmartInsightCard(
                          message: context.statisticInsightMessage(
                            insight: currentOverview.smartInsight,
                            selectedTabIndex: state.selectedTabIndex,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        if (state.selectedTabIndex == 1) ...[
                          StatisticBudgetOverviewCard(
                            budgetOverview: state.budgetOverview,
                            comparisonMessage:
                                context.statisticComparisonMessage(
                              budgetOverview: state.budgetOverview,
                              selectedTabIndex: state.selectedTabIndex,
                            ),
                            onSetupLimit: handleSetupLimit,
                          ),
                          SizedBox(height: 20.h),
                        ],
                        StatisticSpendingTrendSection(
                          dailyExpenses: currentOverview.dailyExpenses,
                          selectedTabIndex: state.selectedTabIndex,
                          selectedDate: selectedDate,
                          onDateSelected: (value) =>
                              unawaited(notifier.setSelectedDate(value)),
                        ),
                        SizedBox(height: 20.h),
                        if (state.isEmpty &&
                            currentOverview.incomeCategories.isEmpty) ...[
                          const StatisticEmptyCard(),
                        ] else ...[
                          StatisticTopCategoriesSection(
                            title: context.l10n.statisticTopCategoriesTitle,
                            categories: currentOverview.categories,
                            onItemTap: (category) => context.push(
                              AppRoutes.childCategoryTransactions,
                              extra: CategoryTransactionsArgs(
                                categoryKey: category.categoryKey,
                                categoryLabel: category.categoryLabel,
                                categoryIcon: category.categoryIcon,
                                selectedTabIndex: state.selectedTabIndex,
                                anchorDate: selectedDate,
                                transactionType: TransactionType.expense,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          StatisticTopCategoriesSection(
                            title:
                                context.l10n.statisticTopIncomeCategoriesTitle,
                            categories: currentOverview.incomeCategories,
                            onItemTap: (category) => context.push(
                              AppRoutes.childCategoryTransactions,
                              extra: CategoryTransactionsArgs(
                                categoryKey: category.categoryKey,
                                categoryLabel: category.categoryLabel,
                                categoryIcon: category.categoryIcon,
                                selectedTabIndex: state.selectedTabIndex,
                                anchorDate: selectedDate,
                                transactionType: TransactionType.income,
                              ),
                            ),
                          ),
                          if (!state.isEmpty) ...[
                            SizedBox(height: 20.h),
                            StatisticCategoryChangeSection(
                              strongestIncrease:
                                  currentOverview.strongestIncrease,
                              strongestDecrease:
                                  currentOverview.strongestDecrease,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}

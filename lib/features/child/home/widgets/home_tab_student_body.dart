import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/home/home_tab_provider.dart';
import 'package:monikid/features/child/home/home_tab_state.dart';
import 'package:monikid/shared/widgets/skeleton_widget/home_child_skeleton.dart';
import 'package:monikid/features/child/home/widgets/home_header.dart';
import 'package:monikid/features/child/home/widgets/home_monthly_summary_card.dart';
import 'package:monikid/features/child/home/widgets/home_quick_actions.dart';
import 'package:monikid/features/child/home/widgets/home_recent_transactions_section.dart';
import 'package:monikid/features/child/home/widgets/section_container.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_provider.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_state.dart';

class HomeTabStudentBody extends ConsumerWidget {
  const HomeTabStudentBody({
    super.key,
    required this.uid,
    required this.userName,
    required this.avatarUrl,
    required this.isDark,
  });

  final String? uid;
  final String userName;
  final String? avatarUrl;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark;

    final state = ref.watch(homeTabNotifierProvider);
    final limitState = ref.watch(setMoneyLimitNotifierProvider);
    final sharedTransactionStatus = ref.watch(
      transactionHistoryProvider.select((value) => value.sharedStatus),
    );
    final recentTransactions = ref.watch(
      transactionHistoryProvider.select(
        (value) => value.monthlyTransactions.take(6).toList(growable: false),
      ),
    );
    final transactionCount = ref.watch(
      transactionHistoryProvider.select(
        (value) => value.monthlyTransactions.length,
      ),
    );

    final todayTransactionCount = ref.watch(
      transactionHistoryProvider.select((value) {
        final today = DateTime.now();
        return value.monthlyTransactions
            .where(
              (tx) =>
                  tx.dateTs.year == today.year &&
                  tx.dateTs.month == today.month &&
                  tx.dateTs.day == today.day,
            )
            .length;
      }),
    );

    final categories =
        ref.watch(categoryStreamProvider).value ?? defaultCategories;

    final topCategoryEntry = ref.watch(
      transactionHistoryProvider.select((value) {
        final expenses =
            value.monthlyTransactions.where((tx) => tx.type == 'expense');
        if (expenses.isEmpty) return null;
        final Map<String, int> totalsByKey = {};
        for (final tx in expenses) {
          totalsByKey[tx.categoryKey] =
              (totalsByKey[tx.categoryKey] ?? 0) + tx.amountMinor;
        }
        final top = totalsByKey.entries
            .reduce((a, b) => a.value > b.value ? a : b);
        return (categoryKey: top.key, amount: top.value.toDouble());
      }),
    );
    // Resolve display label from the live category list (handles custom categories and old transactions with no stored label).
    final topCategoryLabel = topCategoryEntry != null
        ? (findCategoryByTransactionKey(
                categories, topCategoryEntry.categoryKey)
              ?.label ??
            topCategoryEntry.categoryKey)
        : null;
    final topCategoryAmount = topCategoryEntry?.amount;

    final hasMonthlyLimit = limitState.hasStoredLimit;
    final limitMinor = limitState.storedLimitMinor;
    final remainingBudget = hasMonthlyLimit && limitMinor != null
        ? limitMinor.toDouble() - state.monthlyExpense
        : null;

    final horizontalPadding = 24.w;
    final topPadding = 24.h;
    final sectionSpacing = 16.h;
    final smallSpacing = 8.h;
   
    final screenWidth = MediaQuery.sizeOf(context).width;
    final sectionMaxWidth = screenWidth >= 840
        ? 720.0
        : screenWidth >= 600
        ? 640.0
        : double.infinity;

    if (state.status == HomeTabStatus.initial ||
        state.isLoading ||
        sharedTransactionStatus == TransactionHistorySharedStatus.initial ||
        sharedTransactionStatus == TransactionHistorySharedStatus.loading) {
      return const HomeChildSkeleton();
    }

    if (state.isError) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(horizontalPadding),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48.r, color: AppTheme.redAlert),
                  SizedBox(height: 16.h),
                  Text(
                    state.errorMessage ?? s.homeStudentLoadError,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(homeTabNotifierProvider.notifier).refresh(),
                    child: Text(s.actionRetry),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                smallSpacing,
              ),
              child: HomeHeader(
                userName: userName,
                avatarUrl: avatarUrl,
                isDark: isDark,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                sectionSpacing,
                horizontalPadding,
                smallSpacing,
              ),
              child: HomeMonthlySummaryCard(
                monthlyExpense: state.monthlyExpense,
                limitAmount: limitMinor?.toDouble(),
                remainingBudget: remainingBudget,
                transactionCount: transactionCount,
                isLimitConfigured: hasMonthlyLimit,
                todayTransactionCount: todayTransactionCount,
                topCategoryLabel: topCategoryLabel,
                topCategoryAmount: topCategoryAmount,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12.h,
                horizontalPadding,
                smallSpacing,
              ),
              child: HomeQuickActions(
                isDark: isDark,
                onSetLimitTap: () => showSetMoneyLimitDialog(context, ref),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                sectionSpacing,
              ),
              child: HomeRecentTransactionsSection(
                title: s.homeStudentRecentTransactions,
                transactions: recentTransactions,
                emptyLabel: s.noTransactionsYet,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

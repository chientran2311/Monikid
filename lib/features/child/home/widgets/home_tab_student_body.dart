import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/child/home/home_tab_provider.dart';
import 'package:monikid/features/child/home/home_tab_skeleton.dart';
import 'package:monikid/features/child/home/home_tab_state.dart';
import 'package:monikid/features/child/home/widgets/home_header.dart';
import 'package:monikid/features/child/home/widgets/home_monthly_summary_card.dart';
import 'package:monikid/features/child/home/widgets/home_quick_actions.dart';
import 'package:monikid/features/child/home/widgets/home_recent_transactions_section.dart';
import 'package:monikid/features/child/home/widgets/section_container.dart';
import 'package:monikid/features/child/home/widgets/seed_mock_button.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_provider.dart';
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

    final hasMonthlyLimit = limitState.hasStoredLimit;
    final remainingBudget = hasMonthlyLimit
        ? (limitState.storedLimitMinor ?? 0) - state.monthlyExpense
        : null;

    final horizontalPadding = 24.w;
    final topPadding = 24.h;
    final sectionSpacing = 16.h;
    final smallSpacing = 8.h;
    final bottomPadding = 100.h;
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
      return const HomeTabSkeleton();
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
                  Icon(Icons.error_outline, size: 48.r, color: Colors.red),
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
                greeting: s.homeStudentGreeting,
                userName: userName,
                avatarUrl: avatarUrl,
                isDark: isDark,
                textColor: textColor,
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
                title: s.homeStudentRemainingBudget,
                remainingAmount: hasMonthlyLimit
                    ? NumberFormat.currency(
                        locale: 'vi_VN',
                        symbol: 'VND',
                        decimalDigits: 0,
                      ).format(remainingBudget)
                    : s.homeStudentMonthlyLimitNotSet,
                incomeLabel: s.homeStudentMonthlyIncome,
                expenseLabel: s.homeStudentMonthlyExpense,
                monthlyIncome: state.monthlyIncome,
                monthlyExpense: state.monthlyExpense,
                isLimitConfigured: hasMonthlyLimit,
                emptyStateLabel: s.homeStudentMonthlyLimitNotSet,
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
                viewAllLabel: s.homeStudentViewAll,
                transactions: recentTransactions,
                emptyLabel: s.noTransactionsYet,
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
                0,
                horizontalPadding,
                bottomPadding,
              ),
              child: SeedMockButton(uid: uid),
            ),
          ),
        ),
      ],
    );
  }
}

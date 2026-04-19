import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/student/home/home_tab_provider.dart';
import 'package:monikid/features/student/home/home_tab_skeleton.dart';
import 'package:monikid/features/student/home/home_tab_state.dart';
import 'package:monikid/features/student/home/widgets/home_monthly_summary_card.dart';
import 'package:monikid/features/student/home/widgets/home_recent_transactions_section.dart';
import 'package:monikid/features/student/home/widgets/quick_action.dart';
import 'package:monikid/features/student/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/student/set_money_limit/set_money_limit_provider.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/student/transaction/transaction_history/transaction_history_state.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_dialog.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class HomeTabStudent extends HookConsumerWidget {
  const HomeTabStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final authState = ref.watch(authSessionProvider);
    final homeState = ref.watch(homeTabNotifierProvider);
    final limitState = ref.watch(setMoneyLimitNotifierProvider);
    final sharedTransactionStatus = ref.watch(
      transactionHistoryProvider.select((value) => value.sharedStatus),
    );
    final recentTransactions = ref.watch(
      transactionHistoryProvider.select(
        (value) => value.monthlyTransactions.take(6).toList(growable: false),
      ),
    );
    final userName = authState.account?.displayName ?? s.homeStudentDefaultName;
    final avatarUrl = authState.user?.photoURL;
    final hasPromptedForMissingLimit = useRef(false);

    useEffect(() {
      Future.microtask(() async {
        await ref.read(setMoneyLimitNotifierProvider.notifier).onInit();
        await ref.read(homeTabNotifierProvider.notifier).onInit();
      });
      return null;
    }, const []);

    useEffect(() {
      if (!limitState.isReady ||
          limitState.hasStoredLimit ||
          hasPromptedForMissingLimit.value) {
        return null;
      }

      hasPromptedForMissingLimit.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) {
          return;
        }
        showSetMoneyLimitDialog(context, ref);
      });
      return null;
    }, [limitState.status, limitState.hasStoredLimit]);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(setMoneyLimitNotifierProvider.notifier).loadCurrentLimit();
            await ref.read(homeTabNotifierProvider.notifier).refresh();
          },
          child: _buildBody(
            context: context,
            ref: ref,
            state: homeState,
            hasMonthlyLimit: limitState.hasStoredLimit,
            monthlyLimitMinor: limitState.storedLimitMinor,
            sharedTransactionStatus: sharedTransactionStatus,
            recentTransactions: recentTransactions,
            userName: userName,
            avatarUrl: avatarUrl,
            isDark: isDark,
            textColor: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required WidgetRef ref,
    required HomeTabState state,
    required bool hasMonthlyLimit,
    required int? monthlyLimitMinor,
    required TransactionHistorySharedStatus sharedTransactionStatus,
    required List<TransactionModel> recentTransactions,
    required String userName,
    required String? avatarUrl,
    required bool isDark,
    required Color textColor,
  }) {
    final s = context.l10n;
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
    final remainingBudget = hasMonthlyLimit
        ? (monthlyLimitMinor ?? 0) - state.monthlyExpense
        : null;

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
          child: _SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                smallSpacing,
              ),
              child: _HomeHeader(
                greeting: context.l10n.homeStudentGreeting,
                userName: userName,
                avatarUrl: avatarUrl,
                isDark: isDark,
                textColor: textColor,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _SectionContainer(
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
          child: _SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12.h,
                horizontalPadding,
                smallSpacing,
              ),
              child: _HomeQuickActions(
                isDark: isDark,
                onSetLimitTap: () => showSetMoneyLimitDialog(context, ref),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _SectionContainer(
            maxWidth: sectionMaxWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                bottomPadding,
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
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.greeting,
    required this.userName,
    required this.avatarUrl,
    required this.isDark,
    required this.textColor,
  });

  final String greeting;
  final String userName;
  final String? avatarUrl;
  final bool isDark;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: TextStyle(
                fontSize: 14.r,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              userName,
              style: TextStyle(
                fontSize: 20.r,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.2),
              width: 2.r,
            ),
          ),
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      color: AppTheme.primary,
                    ),
                  )
                : const Icon(Icons.person, color: AppTheme.primary),
          ),
        ),
      ],
    );
  }
}

class _HomeQuickActions extends StatelessWidget {
  const _HomeQuickActions({
    required this.isDark,
    required this.onSetLimitTap,
  });

  final bool isDark;
  final VoidCallback onSetLimitTap;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final actions = [
      (
        icon: Icons.qr_code_scanner,
        label: s.scanbill,
        color: Colors.orange,
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const UploadPicDialog(),
          );
        },
      ),
      (
        icon: Icons.add_card,
        label: s.homeStudentAddTransaction,
        color: Colors.green,
        onTap: () => context.push(AppRoutes.addTransaction),
      ),
      (
        icon: Icons.track_changes,
        label: s.homeStudentSetMonthlyLimit,
        color: Colors.teal,
        onTap: onSetLimitTap,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = ScreenUtils.screenWidth;
        final screenHeight = ScreenUtils.screenHeight;
        final spacing = 12.w;
        final availableWidth = constraints.maxWidth - (spacing * 2);
        final itemWidth = availableWidth / 3;
        final circleSize = (screenWidth * 0.14).clamp(48.0, 62.0);
        final iconSize = (circleSize * 0.48).clamp(22.0, 30.0);
        final labelFontSize = screenHeight < 700 ? 11.5.r : 12.5.r;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: actions.map((action) {
            final index = actions.indexOf(action);
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == actions.length - 1 ? 0 : spacing,
                ),
                child: SizedBox(
                  width: itemWidth,
                  child: QuickAction(
                    icon: action.icon,
                    label: action.label,
                    color: action.color,
                    isDark: isDark,
                    circleSize: circleSize,
                    iconSize: iconSize,
                    labelFontSize: labelFontSize,
                    onTap: action.onTap,
                  ),
                ),
              ),
            );
          }).toList(growable: false),
        );
      },
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({
    required this.maxWidth,
    required this.child,
  });

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

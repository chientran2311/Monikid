import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/features/parent/home/parent_home_state.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/shared/widgets/main_app_bar.dart';
import 'widgets/family_members_section.dart';
import 'widgets/home_alert_card.dart';
import 'widgets/home_transaction_row.dart';
import 'widgets/member_spending_card.dart';
import 'widgets/no_family_empty_state.dart';

class HomeTabParent extends HookConsumerWidget {
  const HomeTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    final notifier = ref.read(parentHomeNotifierProvider.notifier);
    final state = ref.watch(parentHomeNotifierProvider);

    useEffect(() {
      Future.microtask(() => notifier.onInit());
      return null;
    }, const []);

    ref.listen(parentHomeNotifierProvider, (_, next) {
      if (next.status == ParentHomeStatus.error && next.errorMessage != null) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    Widget body;

    if (state.isLoading || state.status == ParentHomeStatus.initial) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state.isNoFamily) {
      body = NoFamilyEmptyState(
        isDark: isDark,
        isLoading: state.isCreatingFamily,
        onCreateTap: () => notifier.createFamily(),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: () async => notifier.refresh(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 24.h),
            FamilyMembersSection(
              isDark: isDark,
              members: state.members,
              selectedMemberId: state.selectedMemberId,
              inviteCode: state.family?.inviteCode ?? '',
              onMemberTap: notifier.selectMember,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: MemberSpendingCard(
                isDark: isDark,
                isLoading: state.isLoadingMemberData,
                expenseMinor: state.selectedMemberExpenseMinor,
                incomeMinor: state.selectedMemberIncomeMinor,
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(
                    title: s.homeParRecentTransactionsLabel,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  SizedBox(height: 8.h),
                  _TransactionListCard(
                    isDark: isDark,
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    textColor: textColor,
                    mutedColor: mutedColor,
                    transactions: state.selectedMemberTransactions,
                    isLoading: state.isLoadingMemberData,
                    emptyLabel: s.noTransactionsYet,
                  ),
                  SizedBox(height: 24.h),
                  _SectionHeader(
                    title: s.homeParAlertsLabel,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  SizedBox(height: 8.h),
                  HomeAlertCard(isDark: isDark),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: const MainAppBar(),
      body: body,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.textColor,
    required this.mutedColor,
    this.trailingLabel,
    this.onTrailingTap,
  });

  final String title;
  final String? trailingLabel;
  final Color textColor;
  final Color mutedColor;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: mutedColor,
              letterSpacing: 0.6,
            ),
          ),
        ),
        if (trailingLabel != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(
              trailingLabel!,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

class _TransactionListCard extends StatelessWidget {
  const _TransactionListCard({
    required this.isDark,
    required this.surfaceColor,
    required this.borderColor,
    required this.textColor,
    required this.mutedColor,
    required this.transactions,
    required this.isLoading,
    required this.emptyLabel,
  });

  final bool isDark;
  final Color surfaceColor;
  final Color borderColor;
  final Color textColor;
  final Color mutedColor;
  final List<TransactionModel> transactions;
  final bool isLoading;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12.r),
          border: isDark ? Border.all(color: borderColor, width: 0.5) : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: const Center(child: CircularProgressIndicator()),
              )
            : transactions.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: Center(
                      child: Text(
                        emptyLabel,
                        style: TextStyle(color: mutedColor, fontSize: 14.sp),
                      ),
                    ),
                  )
                : Column(
                    children: List.generate(transactions.length, (i) {
                      return HomeTransactionRow(
                        tx: transactions[i],
                        textColor: textColor,
                        mutedColor: mutedColor,
                        borderColor: borderColor,
                        showDivider: i < transactions.length - 1,
                      );
                    }),
                  ),
      ),
    );
  }
}

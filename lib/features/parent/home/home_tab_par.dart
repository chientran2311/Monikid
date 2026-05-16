import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/features/parent/home/parent_home_state.dart';
import 'package:monikid/features/parent/home/widgets/family_members_section.dart';
import 'package:monikid/features/parent/home/widgets/member_spending_card.dart';
import 'package:monikid/features/parent/home/widgets/no_family_empty_state.dart';
import 'package:monikid/features/parent/home/widgets/parent_home_section_header.dart';
import 'package:monikid/features/parent/home/widgets/parent_transaction_list_card.dart';
import 'package:monikid/features/parent/home/widgets/top_category_alert_card.dart';
import 'package:monikid/features/parent/notification/parent_notification_provider.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_screen.dart';
import 'package:monikid/features/parent/statistic/parent_statistic_provider.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:monikid/shared/widgets/main_app_bar.dart';

class HomeTabParent extends HookConsumerWidget {
  const HomeTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    final notifier = ref.read(parentHomeNotifierProvider.notifier);
    final state = ref.watch(parentHomeNotifierProvider);
    final statisticState = ref.watch(parentStatisticNotifierProvider);

    final authState = ref.watch(authSessionProvider);
    final uid = authState.account?.uid ?? authState.user?.uid;
    final fallbackAvatarUrl =
        authState.account?.photoUrl ?? authState.user?.photoURL;
    final profileImageUrl = uid == null
        ? null
        : ref
              .watch(profileImageProvider(uid))
              .maybeWhen(data: (avatarUrl) => avatarUrl, orElse: () => null);
    final resolvedAvatarUrl = profileImageUrl ?? fallbackAvatarUrl;

    useEffect(() {
      Future.microtask(() => notifier.onInit());
      return null;
    }, const []);

    ref.listen(parentHomeNotifierProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
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
        onRefresh: () async {
          if (uid != null) {
            ref.invalidate(profileImageProvider(uid));
          }
          await notifier.refresh();
        },
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
                  ParentHomeSectionHeader(
                    title: s.homeParRecentTransactionsLabel,
                    trailingLabel: s.homeParSeeAll,
                    textColor: textColor,
                    mutedColor: mutedColor,
                    onTrailingTap: () {
                      context.push(AppRoutes.parentTransactionHistory);
                    },
                  ),
                  SizedBox(height: 8.h),
                  ParentTransactionListCard(
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
                  ParentHomeSectionHeader(
                    title: s.homeParAlertsLabel,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  SizedBox(height: 8.h),
                  if (statisticState.topCategories.isNotEmpty &&
                      state.selectedMember != null)
                    TopCategoryAlertCard(
                      isDark: isDark,
                      topCategory: statisticState.topCategories.first,
                      onTap: () {
                        final selectedChild = state.selectedMember;
                        if (selectedChild != null) {
                          final topCategory =
                              statisticState.topCategories.first;
                          context.push(
                            AppRoutes.parentCategoryTransactions,
                            extra: ParentCategoryTransactionsArgs(
                              childUid: selectedChild.uid,
                              categoryKey: topCategory.categoryKey,
                              categoryLabel: topCategory.categoryLabel,
                              period: statisticState.period,
                            ),
                          );
                        }
                      },
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: isDark
                            ? Border.all(color: borderColor, width: 0.5)
                            : null,
                        boxShadow: isDark
                            ? null
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      padding: EdgeInsets.all(16.r),
                      child: Center(
                        child: Text(
                          s.msgNoData,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: mutedColor,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: MainAppBar(
        avatarUrl: resolvedAvatarUrl,
        notifCount: ref.watch(parentUnreadNotificationCountProvider),
        onNotificationTap: () => context.push(AppRoutes.parentNotifications),
      ),
      body: body,
    );
  }
}

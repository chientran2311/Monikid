import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/features/parent/home/parent_home_state.dart';
import 'package:monikid/features/parent/home/widgets/alert_card.dart';
import 'package:monikid/features/parent/home/widgets/family_members_section.dart';
import 'package:monikid/features/parent/home/widgets/home_error_state.dart';
import 'package:monikid/features/parent/home/widgets/home_summary_card.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_item.dart';
import 'package:monikid/features/parent/home/widgets/no_family_empty_state.dart';
import 'package:monikid/features/parent/home/widgets/parent_home_app_bar.dart';
import 'package:monikid/features/parent/home/widgets/parent_home_skeleton.dart';
import 'package:monikid/features/parent/home/widgets/parent_home_section_header.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:monikid/shared/widgets/app_background.dart';

class HomeTabParent extends HookConsumerWidget {
  const HomeTabParent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = getIt<Logger>();
    logger.d('HomeTabParent.build: start.');

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.homeParFg;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    final notifier = ref.read(parentHomeNotifierProvider.notifier);
    final state = ref.watch(parentHomeNotifierProvider);

    final authState = ref.watch(authSessionProvider);
    final uid = authState.account?.uid ?? authState.user?.uid;
    final fallbackAvatarUrl =
        authState.account?.avatarUrl ?? authState.user?.photoURL;
    final profileImageUrl = uid == null
        ? null
        : ref
              .watch(profileImageProvider(uid))
              .maybeWhen(data: (url) => url, orElse: () => null);
    final resolvedAvatarUrl = profileImageUrl ?? fallbackAvatarUrl;
    logger.d('HomeTabParent.build: uid=$uid hasAvatar=${resolvedAvatarUrl != null}.');

    // Post-frame diagnostic: fires only if build + layout + paint complete.
    // If this log never appears for a given status, the freeze is in the
    // paint phase (e.g. heavy BackdropFilter), not in build logic.
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        logger.i('HomeTabParent: frame rendered. status=${state.status}.');
      });
      return null;
    }, [state.status]);

    final animCtrl = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );

    useEffect(() {
      Future.microtask(() => notifier.onInit());
      return null;
    }, [authState.isAuthenticated]);

    useEffect(() {
      if (!state.isLoading && state.status != ParentHomeStatus.initial) {
        animCtrl.forward();
      }
      return null;
    }, [state.isLoading, state.status]);

    ref.listen(parentHomeNotifierProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    logger.i('HomeTabParent.build: status=${state.status} '
        'isLoading=${state.isLoading} isNoFamily=${state.isNoFamily} '
        'members=${state.members.length}.');

    Widget scrollBody;

    try {
      if (state.isLoading || state.status == ParentHomeStatus.initial) {
        logger.d('HomeTabParent.build: → loading branch.');
        scrollBody = ParentHomeSkeleton(isDark: isDark);
      } else if (state.status == ParentHomeStatus.error) {
        logger.d('HomeTabParent.build: → error branch. msg=${state.errorMessage}.');
        scrollBody = HomeErrorState(
          isDark: isDark,
          message: state.errorMessage,
          onRetry: () => notifier.onInit(),
        );
      } else if (state.isNoFamily) {
        logger.d('HomeTabParent.build: → noFamily branch.');
        scrollBody = NoFamilyEmptyState(
          isDark: isDark,
          isLoading: state.isCreatingFamily,
          onCreateTap: () => notifier.createFamily(),
        );
      } else {
        logger.d('HomeTabParent.build: → hasFamily branch.');
        scrollBody = _buildHasFamilyBody(
          context,
          ref,
          state,
          notifier,
          animCtrl,
          uid,
          isDark,
          textColor,
          mutedColor,
        );
      }
    } catch (error, stackTrace) {
      logger.e(
        'HomeTabParent.build: failed to build scrollBody. status=${state.status}.',
        error: error,
        stackTrace: stackTrace,
      );
      scrollBody = HomeErrorState(
        isDark: isDark,
        message: error.toString(),
        onRetry: () => notifier.onInit(),
      );
    }

    logger.d('HomeTabParent.build: scrollBody ready, returning Scaffold.');

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      body: AppBackground(
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: ParentHomeAppBar(
                avatarUrl: resolvedAvatarUrl,
              ),
            ),
            Expanded(child: scrollBody),
          ],
        ),
      ),
    );
  }

  Widget _buildHasFamilyBody(
    BuildContext context,
    WidgetRef ref,
    ParentHomeState state,
    ParentHomeNotifier notifier,
    AnimationController animCtrl,
    String? uid,
    bool isDark,
    Color textColor,
    Color mutedColor,
  ) {
      final s = context.l10n;
      final childMembers =
          state.members.where((m) => m.isChild).toList(growable: false);
      final selectedMemberName = state.selectedMember?.displayName;
      final remaining =
          state.selectedMemberIncomeMinor - state.selectedMemberExpenseMinor;
      final showLowBalanceAlert = state.selectedMember != null &&
          state.selectedMemberIncomeMinor > 0 &&
          remaining < 10000000;

      return RefreshIndicator(
        onRefresh: () async {
          if (uid != null) ref.invalidate(profileImageProvider(uid));
          await notifier.refresh();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 8.h),
            _fadeSlide(
              FamilyMembersSection(
                isDark: isDark,
                members: childMembers,
                selectedMemberId: state.selectedMemberId,
                familyId: state.family?.familyId ?? '',
                onMemberTap: notifier.selectMember,
              ),
              0.1,
              animCtrl,
            ),
            SizedBox(height: 20.h),
            _fadeSlide(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: HomeSummaryCard(
                  isDark: isDark,
                  isLoading: state.isLoadingMemberData,
                  expenseMinor: state.selectedMemberExpenseMinor,
                  limitMinor: state.selectedMemberLimitMinor,
                ),
              ),
              0.2,
              animCtrl,
            ),
            if (showLowBalanceAlert) ...[
              SizedBox(height: 16.h),
              _fadeSlide(
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AlertCard(
                    isDark: isDark,
                    title: s.homeParLowBalanceTitle,
                    description:
                        s.homeParLowBalanceDesc(selectedMemberName ?? ''),
                    onTap: () =>
                        context.push(AppRoutes.parentTransactionHistory),
                  ),
                ),
                0.25,
                animCtrl,
              ),
            ],
            SizedBox(height: 24.h),
            _fadeSlide(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ParentHomeSectionHeader(
                  title: s.homeParRecentTransactionsLabel,
                  trailingLabel: s.homeParSeeAll,
                  textColor: textColor,
                  mutedColor: mutedColor,
                  onTrailingTap: () =>
                      context.push(AppRoutes.parentTransactionHistory),
                ),
              ),
              0.3,
              animCtrl,
            ),
            SizedBox(height: 12.h),
            if (state.isLoadingMemberData)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.selectedMemberTransactions.isEmpty)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Center(
                  child: Text(
                    s.noTransactionsYet,
                    style: TextStyle(fontSize: 14.sp, color: mutedColor),
                  ),
                ),
              )
            else
              ...state.selectedMemberTransactions.asMap().entries.map((e) {
                return _fadeSlide(
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TransactionItem(
                      transaction: e.value,
                    ),
                  ),
                  (0.35 + e.key * 0.05).clamp(0.0, 0.9),
                  animCtrl,
                );
              }),
            SizedBox(height: 120.h),
          ],
        ),
      );
  }

  Widget _fadeSlide(
    Widget child,
    double startFraction,
    AnimationController ctrl,
  ) {
    final end = (startFraction + 0.4).clamp(0.0, 1.0);
    final anim = CurvedAnimation(
      parent: ctrl,
      curve: Interval(startFraction, end, curve: Curves.easeOut),
    );
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
                .animate(anim),
        child: child,
      ),
    );
  }
}



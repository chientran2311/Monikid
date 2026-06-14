import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/parent/family_management/family_management_notifier.dart';
import 'package:monikid/features/parent/family_management/family_management_state.dart';
import 'package:monikid/features/parent/family_management/widgets/child_member_card.dart';
import 'package:monikid/features/parent/family_management/widgets/family_info_card.dart';
import 'package:monikid/features/parent/family_management/widgets/limit_dialog.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/shared/widgets/app_background.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';
import 'package:monikid/shared/widgets/glass_app_bar.dart';

class FamilyManagementScreen extends HookConsumerWidget {
  const FamilyManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    final authState = ref.watch(authSessionProvider);
    final currentUserId = authState.account?.uid ?? authState.user?.uid;

    final notifier = ref.read(familyManagementNotifierProvider.notifier);
    final state = ref.watch(familyManagementNotifierProvider);

    useEffect(() {
      Future.microtask(() => notifier.loadFamily());
      return null;
    }, const []);

    ref.listen(familyManagementNotifierProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    final isHostParent = currentUserId != null &&
        state.family?.ownerUid == currentUserId;

    Widget body;
    if (state.isLoading || state.status == FamilyManagementStatus.initial) {
      body = const Center(
        child: CircularProgressIndicator(color: AppTheme.primary),
      );
    } else {
      body = SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
          bottom: MediaQuery.of(context).padding.bottom + 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.family != null)
              FamilyInfoCard(
                family: state.family!,
                ownerDisplayName: state.parentMembers.firstOrNull?.displayName ?? '',
                nonHostParent: state.nonHostParent,
                isHostParent: isHostParent,
                onUnlinkParent: state.nonHostParent != null
                    ? () => _onUnlinkParent(
                          context: context,
                          memberUid: state.nonHostParent!.uid,
                          memberName: state.nonHostParent!.displayName,
                          notifier: notifier,
                        )
                    : null,
              ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                s.familyManagementSectionMembers,
                style: context.typo.caption.medium.copyWith(
                  color: AppTheme.textGrey,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            if (state.childMembers.isEmpty)
              _EmptyChildrenState(message: s.familyManagementEmptyChildren)
            else
              ...state.childMembers.asMap().entries.map((entry) {
                final index = entry.key;
                final member = entry.value;
                final limitMinor = state.monthlyLimits[member.uid];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: ChildMemberCard(
                    member: member,
                    limitMinor: limitMinor,
                    avatarColor: _childAvatarColor(index),
                    isHostParent: isHostParent,
                    isProcessing: state.isProcessing,
                    onSetLimit: () => _onSetLimit(
                      context: context,
                      member: member,
                      limitMinor: limitMinor,
                      notifier: notifier,
                    ),
                    onUnlink: isHostParent
                        ? () => _onUnlinkChild(
                              context: context,
                              childUid: member.uid,
                              childName: member.displayName,
                              notifier: notifier,
                            )
                        : null,
                  ),
                );
              }),
            SizedBox(height: 16.h),
            _FamilyBanner(
              title: s.familyManagementBannerTitle,
              subtitle: s.familyManagementBannerSubtitle,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: s.familyManagementTitle,
        onBackTap: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.parent);
          }
        },
      ),
      body: AppBackground(child: body),
    );
  }

  Color _childAvatarColor(int index) {
    const colors = [
      AppTheme.chartBlue,
      AppTheme.chartOrange,
      AppTheme.chartGreen,
      AppTheme.chartPurple,
    ];
    return colors[index % colors.length];
  }

  void _onUnlinkParent({
    required BuildContext context,
    required String memberUid,
    required String memberName,
    required FamilyManagementNotifier notifier,
  }) {
    final s = context.l10n;
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: s.familyManagementUnlinkConfirmTitle,
        subtitle: s.familyManagementUnlinkConfirmBody(memberName),
        confirmLabel: s.familyManagementUnlinkConfirmButton,
        cancelLabel: s.familyManagementCancel,
        isDestructive: true,
        onConfirm: () => notifier.unlinkParentMember(memberUid),
      ),
    );
  }

  void _onUnlinkChild({
    required BuildContext context,
    required String childUid,
    required String childName,
    required FamilyManagementNotifier notifier,
  }) {
    final s = context.l10n;
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: s.familyManagementUnlinkConfirmTitle,
        subtitle: s.familyManagementUnlinkConfirmBody(childName),
        confirmLabel: s.familyManagementUnlinkConfirmButton,
        cancelLabel: s.familyManagementCancel,
        isDestructive: true,
        onConfirm: () => notifier.unlinkChild(childUid),
      ),
    );
  }

  Future<void> _onSetLimit({
    required BuildContext context,
    required FamilyMemberModel member,
    required int? limitMinor,
    required FamilyManagementNotifier notifier,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => LimitDialog(
        childUid: member.uid,
        childName: member.displayName,
        currentLimitMinor: limitMinor,
        notifier: notifier,
      ),
    );
  }
}

class _EmptyChildrenState extends StatelessWidget {
  const _EmptyChildrenState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline,
              size: 64.w,
              color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: context.typo.body.medium.copyWith(
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyBanner extends StatelessWidget {
  const _FamilyBanner({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [AppTheme.greenDark, AppTheme.primary, AppTheme.chartGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10.w,
            top: -10.h,
            child: Opacity(
              opacity: 0.12,
              child: Icon(
                Icons.eco_rounded,
                size: 120.w,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: context.typo.subtitle.small.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: context.typo.caption.big.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/parent/family_management/family_management_notifier.dart';
import 'package:monikid/features/parent/family_management/family_management_state.dart';
import 'package:monikid/features/parent/family_management/widgets/child_member_card.dart';
import 'package:monikid/features/parent/family_management/widgets/family_info_card.dart';
import 'package:monikid/features/parent/family_management/widgets/limit_dialog.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';

class FamilyManagementScreen extends HookConsumerWidget {
  const FamilyManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
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
        state.family?.parentId == currentUserId;

    Widget body;
    if (state.isLoading || state.status == FamilyManagementStatus.initial) {
      body = const Center(
        child: CircularProgressIndicator(color: AppTheme.primary),
      );
    } else {
      body = SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16.h,
          bottom: MediaQuery.of(context).padding.bottom + 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.family != null)
              FamilyInfoCard(
                family: state.family!,
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
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
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
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceLight,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.textBlack,
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.familyManagementTitle,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.textBlack,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: AppTheme.borderLight, height: 1, thickness: 1),
        ),
      ),
      body: body,
    );
  }

  Color _childAvatarColor(int index) {
    const colors = [
      Color(0xFF039BE5), // sky blue
      Color(0xFFFB8C00), // orange
      Color(0xFF00897B), // teal
      Color(0xFF8E24AA), // purple
    ];
    return colors[index % colors.length];
  }

  Future<void> _onUnlinkParent({
    required BuildContext context,
    required String memberUid,
    required String memberName,
    required FamilyManagementNotifier notifier,
  }) async {
    final s = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: s.familyManagementUnlinkConfirmTitle,
        message: s.familyManagementUnlinkConfirmBody(memberName),
        confirmLabel: s.familyManagementUnlinkConfirmButton,
        cancelLabel: s.familyManagementCancel,
        confirmColor: AppTheme.redAlert,
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await notifier.unlinkParentMember(memberUid);
  }

  Future<void> _onUnlinkChild({
    required BuildContext context,
    required String childUid,
    required String childName,
    required FamilyManagementNotifier notifier,
  }) async {
    final s = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: s.familyManagementUnlinkConfirmTitle,
        message: s.familyManagementUnlinkConfirmBody(childName),
        confirmLabel: s.familyManagementUnlinkConfirmButton,
        cancelLabel: s.familyManagementCancel,
        confirmColor: AppTheme.redAlert,
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await notifier.unlinkChild(childUid);
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
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline, size: 64.w, color: AppTheme.borderLight),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

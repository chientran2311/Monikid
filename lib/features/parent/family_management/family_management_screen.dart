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
import 'package:monikid/features/parent/family_management/widgets/family_id_card.dart';
import 'package:monikid/features/parent/family_management/widgets/family_management_skeleton.dart';
import 'package:monikid/features/parent/family_management/widgets/member_list_card.dart';
import 'package:monikid/features/parent/family_management/widgets/set_child_limit_sheet.dart';
import 'package:monikid/features/parent/family_management/widgets/unlink_confirm_sheet.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/shared/widgets/app_background.dart';
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
      Future.microtask(notifier.loadFamily);
      return null;
    }, const []);

    ref.listen(familyManagementNotifierProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        context.showErrorSnackBar(next.errorMessage!);
      }
    });

    final isHostParent =
        currentUserId != null && state.hostUid == currentUserId;

    final Widget body;
    if (state.isLoading ||
        state.status == FamilyManagementStatus.initial ||
        state.family == null) {
      body = FamilyManagementSkeleton(isDark: isDark);
    } else {
      final members = state.sortedMembers;
      body = SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
          bottom: MediaQuery.of(context).padding.bottom + 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(text: s.familyManagementSectionFamily),
            FamilyIdCard(family: state.family!),
            SizedBox(height: 24.h),
            _SectionLabel(
              text: s.familyManagementSectionMembersCount(members.length),
            ),
            MemberListCard(
              members: members,
              currentUserId: currentUserId,
              isHostParent: isHostParent,
              isProcessing: state.isProcessing,
              onSetLimit: (member) => _onSetLimit(context, member),
              onUnlink: (member) => _onUnlink(context, notifier, member),
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

  Future<void> _onSetLimit(
    BuildContext context,
    FamilyMemberModel member,
  ) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SetChildLimitSheet(
        childUid: member.uid,
        childName: member.displayName,
      ),
    );
  }

  void _onUnlink(
    BuildContext context,
    FamilyManagementNotifier notifier,
    FamilyMemberModel member,
  ) {
    final s = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UnlinkConfirmSheet(
        title: s.familyManagementUnlinkSheetTitle(member.displayName),
        description: s.familyManagementUnlinkSheetDesc(member.displayName),
        onConfirm: () {
          if (member.userRole == 'parent') {
            notifier.unlinkParentMember(member.uid);
          } else {
            notifier.unlinkChild(member.uid);
          }
        },
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 16.w, 8.h),
      child: Text(
        text,
        style: context.typo.caption.big.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.textMuted,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

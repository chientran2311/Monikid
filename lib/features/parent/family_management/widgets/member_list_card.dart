import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/family_management/widgets/member_row.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';

/// Single card listing every family member (host, parents, children) as rows
/// separated by dividers. Mirrors the `.member-card` block from the design.
class MemberListCard extends StatelessWidget {
  const MemberListCard({
    super.key,
    required this.members,
    required this.currentUserId,
    required this.isHostParent,
    required this.isProcessing,
    required this.onSetLimit,
    required this.onUnlink,
  });

  final List<FamilyMemberModel> members;
  final String? currentUserId;
  final bool isHostParent;
  final bool isProcessing;
  final void Function(FamilyMemberModel member) onSetLimit;
  final void Function(FamilyMemberModel member) onUnlink;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.h),
            blurRadius: 8.r,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        children: List.generate(members.length, (index) {
          final member = members[index];
          final isCurrentUser =
              currentUserId != null && member.uid == currentUserId;

          final roleLabel = member.isHost
              ? s.familyManagementRoleHost
              : member.userRole == 'parent'
                  ? s.familyManagementRoleParent
                  : s.familyManagementRoleChild;

          return MemberRow(
            member: member,
            roleLabel: roleLabel,
            isCurrentUser: isCurrentUser,
            showSetLimit: member.isChild && isHostParent,
            showUnlink: !member.isHost && !isCurrentUser && isHostParent,
            showDivider: index < members.length - 1,
            isProcessing: isProcessing,
            onSetLimit: () => onSetLimit(member),
            onUnlink: () => onUnlink(member),
          );
        }),
      ),
    );
  }
}

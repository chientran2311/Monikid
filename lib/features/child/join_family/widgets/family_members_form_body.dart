import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class FamilyMembersFormBody extends ConsumerWidget {
  const FamilyMembersFormBody({
    required this.isDark,
    required this.state,
    required this.notifier,
    super.key,
  });

  final bool isDark;
  final JoinFamilyState state;
  final JoinFamilyNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;

    final family = ref.watch(linkedFamilyProvider).valueOrNull;
    final membersAsync = ref.watch(familyMembersProvider);
    final members = membersAsync.valueOrNull ?? [];
    final currentUid = ref.watch(
      authSessionProvider.select((a) => a.user?.uid),
    );

    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        _HeroCard(
          isDark: isDark,
          family: family,
          textColor: textColor,
          mutedColor: mutedColor,
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              border: Border(
                top: BorderSide(color: borderColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
                  child: Row(
                    children: [
                      Text(
                        s.familyMemberListLabel,
                        style: context.typo.label.medium.copyWith(
                          color: mutedColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const Spacer(),
                      if (members.isNotEmpty)
                        Text(
                          '${members.length} ${s.familyMembersUnit}',
                          style: context.typo.label.medium.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: membersAsync.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            20.w,
                            0,
                            20.w,
                            20.h,
                          ),
                          itemCount: members.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final member = members[index];
                            final isOwner =
                                family != null &&
                                member.uid == family.parentId;
                            final isCurrentUser = member.uid == currentUid;
                            return _MemberItem(
                              isDark: isDark,
                              member: member,
                              isOwner: isOwner,
                              isCurrentUser: isCurrentUser,
                              textColor: textColor,
                              mutedColor: mutedColor,
                            );
                          },
                        ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                  child: PrimaryButton.danger(
                    title: s.unlinkFamilyButtonFull,
                    isLoading: state.isBusy,
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (_) => ConfirmDialog(
                          title: s.unlinkFamilyConfirmTitle,
                          message: s.unlinkFamilyConfirmBody,
                          confirmLabel: s.unlinkFamilyButton,
                          cancelLabel: s.customCategoryCancel,
                          confirmColor: AppTheme.redAlert,
                        ),
                      );
                      if (confirmed != true || !context.mounted) return;
                      notifier.leaveFamily();
                    },
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.isDark,
    required this.family,
    required this.textColor,
    required this.mutedColor,
  });

  final bool isDark;
  final FamilyModel? family;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.primaryLight,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.h),
            blurRadius: 16.r,
            color: AppTheme.primary.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                s.familyStatusJoined,
                style: context.typo.label.small.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            family?.parentName ?? '',
            style: context.typo.title.big.copyWith(
              color: textColor,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 16.r,
                color: AppTheme.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                s.familyLinkedSuccess,
                style: context.typo.label.small.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberItem extends StatelessWidget {
  const _MemberItem({
    required this.isDark,
    required this.member,
    required this.isOwner,
    required this.isCurrentUser,
    required this.textColor,
    required this.mutedColor,
  });

  final bool isDark;
  final FamilyMemberModel member;
  final bool isOwner;
  final bool isCurrentUser;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final isParent = member.role == 'parent';

    final avatarBg = isParent ? AppTheme.primaryLight : AppTheme.surfaceLightGrey;
    final avatarFg = isParent ? AppTheme.primary : AppTheme.textGrey;

    final String subtitle;
    if (isOwner) {
      subtitle = s.familyRoleOwner;
    } else if (isParent) {
      subtitle = s.familyRoleParent;
    } else {
      subtitle = s.familyMemberActive;
    }

    final String displayName = isCurrentUser
        ? '${member.displayName} (${s.familyMemberYou})'
        : member.displayName;

    final badgeLabel = isParent ? s.familyRoleParent : s.familyRoleChild;
    final badgeBg = isParent
        ? AppTheme.primaryLight
        : (isDark ? AppTheme.surfaceVeryDark : AppTheme.surfaceLightGrey);
    final badgeFg = isParent
        ? AppTheme.primary
        : (isDark ? AppTheme.textMuted : const Color(0xFF64748B));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceVeryDark : AppTheme.surfaceVeryLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: avatarBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Text(
              member.displayName.isNotEmpty
                  ? member.displayName[0].toUpperCase()
                  : '?',
              style: context.typo.title.small.copyWith(
                color: avatarFg,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: context.typo.body.medium.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: context.typo.label.small.copyWith(color: mutedColor),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              badgeLabel,
              style: context.typo.label.small.copyWith(
                color: badgeFg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

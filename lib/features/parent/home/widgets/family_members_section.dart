import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/widgets/invite_code_sheet.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';

class FamilyMembersSection extends StatelessWidget {
  const FamilyMembersSection({
    super.key,
    required this.isDark,
    required this.members,
    required this.selectedMemberId,
    required this.inviteCode,
    required this.onMemberTap,
  });

  final bool isDark;
  final List<FamilyMemberModel> members;
  final String? selectedMemberId;
  final String inviteCode;
  final ValueChanged<String> onMemberTap;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  s.homeParFamilyMembersLabel.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: mutedColor,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 104.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const BouncingScrollPhysics(),
            children: [
              ...members.map((member) {
                final isSelected = member.uid == selectedMemberId;
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: _MemberAvatar(
                    member: member,
                    isSelected: isSelected,
                    textColor: textColor,
                    mutedColor: mutedColor,
                    onTap: () => onMemberTap(member.uid),
                  ),
                );
              }),
              _AddMemberButton(
                isDark: isDark,
                inviteCode: inviteCode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({
    required this.member,
    required this.isSelected,
    required this.textColor,
    required this.mutedColor,
    required this.onTap,
  });

  final FamilyMemberModel member;
  final bool isSelected;
  final Color textColor;
  final Color mutedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              padding: EdgeInsets.all(isSelected ? 2.r : 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppTheme.primary, width: 2)
                    : null,
              ),
              child: ClipOval(
                child: member.avatarUrl != null
                    ? Image.network(
                        member.avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _InitialAvatar(name: member.displayName),
                      )
                    : _InitialAvatar(name: member.displayName),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              member.displayName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? textColor : mutedColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _InitialAvatar extends StatelessWidget {
  const _InitialAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryLight,
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

class _AddMemberButton extends StatelessWidget {
  const _AddMemberButton({
    required this.isDark,
    required this.inviteCode,
  });

  final bool isDark;
  final String inviteCode;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final s = context.l10n;

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => InviteCodeSheet(
          inviteCode: inviteCode,
          isDark: isDark,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.add_rounded,
              size: 28.r,
              color: isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            s.homeParAddMember,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

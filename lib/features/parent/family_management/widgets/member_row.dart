import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';

/// A single member row inside [MemberListCard]. Mirrors the `.member-item`
/// block from the HTML design: avatar, name + role, optional "set limit" chip
/// for children, and an optional "unlink" pill on the trailing edge.
class MemberRow extends StatelessWidget {
  const MemberRow({
    super.key,
    required this.member,
    required this.roleLabel,
    required this.isCurrentUser,
    required this.showSetLimit,
    required this.showUnlink,
    required this.showDivider,
    required this.isProcessing,
    this.onSetLimit,
    this.onUnlink,
  });

  final FamilyMemberModel member;
  final String roleLabel;
  final bool isCurrentUser;
  final bool showSetLimit;
  final bool showUnlink;
  final bool showDivider;
  final bool isProcessing;
  final VoidCallback? onSetLimit;
  final VoidCallback? onUnlink;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final name = isCurrentUser
        ? '${member.displayName}${s.familyManagementYouSuffix}'
        : member.displayName;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Avatar(displayName: member.displayName, avatarUrl: member.avatarUrl),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.typo.body.big.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppTheme.darkTextPrimary
                            : AppTheme.textBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      roleLabel,
                      style: context.typo.label.medium.copyWith(
                        color: AppTheme.textGrey,
                      ),
                    ),
                    if (showSetLimit) ...[
                      SizedBox(height: 6.h),
                      _SetLimitChip(
                        label: s.familyManagementSetLimit,
                        onTap: isProcessing ? null : onSetLimit,
                      ),
                    ],
                  ],
                ),
              ),
              if (showUnlink) ...[
                SizedBox(width: 8.w),
                _UnlinkPill(
                  label: s.familyManagementUnlinkParent,
                  onTap: isProcessing ? null : onUnlink,
                ),
              ],
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 52.w),
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.displayName, required this.avatarUrl});

  final String displayName;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';
    final fallback = Container(
      width: 44.w,
      height: 44.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurfaceVariant : AppTheme.surfaceLightGrey,
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        style: context.typo.body.big.copyWith(
          fontWeight: FontWeight.w700,
          color: AppTheme.textGrey,
        ),
      ),
    );

    final url = avatarUrl;
    if (url == null || url.isEmpty) return fallback;

    return ClipOval(
      child: Image.network(
        url,
        width: 44.w,
        height: 44.w,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }
}

class _SetLimitChip extends StatelessWidget {
  const _SetLimitChip({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time_rounded, size: 12.w, color: AppTheme.primary),
              SizedBox(width: 4.w),
              Text(
                label,
                style: context.typo.caption.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnlinkPill extends StatelessWidget {
  const _UnlinkPill({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppTheme.dangerSurfaceStrong,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            label,
            style: context.typo.caption.medium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.redMedium,
            ),
          ),
        ),
      ),
    );
  }
}

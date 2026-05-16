import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';

class ChildMemberCard extends StatelessWidget {
  const ChildMemberCard({
    super.key,
    required this.member,
    required this.limitMinor,
    required this.avatarColor,
    required this.isHostParent,
    required this.isProcessing,
    this.onSetLimit,
    this.onUnlink,
  });

  final FamilyMemberModel member;
  final int? limitMinor;
  final Color avatarColor;
  final bool isHostParent;
  final bool isProcessing;
  final VoidCallback? onSetLimit;
  final VoidCallback? onUnlink;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final hasLimit = limitMinor != null && limitMinor! > 0;

    final card = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Color(0x08000000),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: avatarColor,
              child: Text(
                member.displayName.isNotEmpty
                    ? member.displayName[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.displayName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  _LimitChip(
                    hasLimit: hasLimit,
                    limitMinor: limitMinor,
                    noLimitLabel: s.familyManagementNoLimit,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            _ActionRow(
              isHostParent: isHostParent,
              isProcessing: isProcessing,
              setLimitLabel: s.familyManagementSetLimit,
              unlinkLabel: s.familyManagementUnlinkChild,
              onSetLimit: onSetLimit,
              onUnlink: onUnlink,
            ),
          ],
        ),
      ),
    );

    if (isProcessing) {
      return Stack(
        children: [
          card,
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return card;
  }
}

class _LimitChip extends StatelessWidget {
  const _LimitChip({
    required this.hasLimit,
    required this.limitMinor,
    required this.noLimitLabel,
  });

  final bool hasLimit;
  final int? limitMinor;
  final String noLimitLabel;

  @override
  Widget build(BuildContext context) {
    if (hasLimit) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: AppTheme.primaryLight,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          CurrencyFormatter.format(limitMinor!),
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.primary,
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLightGrey,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        noLimitLabel,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: AppTheme.textMuted,
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.isHostParent,
    required this.isProcessing,
    required this.setLimitLabel,
    required this.unlinkLabel,
    this.onSetLimit,
    this.onUnlink,
  });

  final bool isHostParent;
  final bool isProcessing;
  final String setLimitLabel;
  final String unlinkLabel;
  final VoidCallback? onSetLimit;
  final VoidCallback? onUnlink;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: isProcessing ? null : onSetLimit,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.primary,
            side: const BorderSide(color: AppTheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
          child: Text(setLimitLabel),
        ),
        if (isHostParent) ...[
          SizedBox(width: 6.w),
          TextButton(
            onPressed: isProcessing ? null : onUnlink,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.redAlert,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            child: Text(unlinkLabel),
          ),
        ],
      ],
    );
  }
}

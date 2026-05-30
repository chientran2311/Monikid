import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';

class FamilyInfoCard extends StatelessWidget {
  const FamilyInfoCard({
    super.key,
    required this.family,
    required this.nonHostParent,
    required this.isHostParent,
    this.onUnlinkParent,
  });

  final FamilyModel family;
  final FamilyMemberModel? nonHostParent;
  final bool isHostParent;
  final VoidCallback? onUnlinkParent;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final rawCode = family.inviteCode;
    final displayCode = rawCode.length == 6
        ? '${rawCode.substring(0, 3)} ${rawCode.substring(3)}'
        : rawCode;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Color(0x10000000),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ParentRow(
              displayName: family.parentName,
              avatarColor: AppTheme.primary,
              subtitle: s.familyManagementHostSubtitle,
            ),
            if (nonHostParent != null) ...[
              SizedBox(height: 12.h),
              Divider(color: AppTheme.borderLight, height: 1, thickness: 1),
              SizedBox(height: 12.h),
              _ParentRow(
                displayName: nonHostParent!.displayName,
                avatarColor: AppTheme.avatarParent,
                subtitle: s.familyManagementParentSubtitle,
                trailing: isHostParent
                    ? _UnlinkParentButton(
                        label: s.familyManagementUnlinkParent,
                        onTap: onUnlinkParent,
                      )
                    : null,
              ),
            ],
            SizedBox(height: 12.h),
            Divider(color: AppTheme.borderLight, height: 1, thickness: 1),
            SizedBox(height: 12.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.familyManagementInviteCodeLabel.toUpperCase(),
                      style: context.typo.caption.medium.copyWith(
                        color: AppTheme.textGrey,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      displayCode,
                      style: context.typo.headline.medium.copyWith(
                        color: AppTheme.primary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: rawCode));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(s.familyManagementCopySuccess),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.copy_outlined, size: 14.w),
                  label: Text(s.familyManagementCopyTooltip),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 7.h,
                    ),
                    textStyle: context.typo.caption.big.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ParentRow extends StatelessWidget {
  const _ParentRow({
    required this.displayName,
    required this.avatarColor,
    required this.subtitle,
    this.trailing,
  });

  final String displayName;
  final Color avatarColor;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: avatarColor,
          child: Text(
            displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
            style: context.typo.body.medium.copyWith(
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
                displayName,
                style: context.typo.body.big.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textBlack,
                ),
              ),
              Text(
                subtitle,
                style: context.typo.caption.big.copyWith(
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _UnlinkParentButton extends StatelessWidget {
  const _UnlinkParentButton({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.redAlert,
        side: const BorderSide(color: AppTheme.redAlert),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: context.typo.caption.big.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Text(label),
    );
  }
}

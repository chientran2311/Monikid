import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';

/// Family identity card: host avatar + family name + invite code with an
/// icon-only copy button. Matches the `.id-card` block from the HTML design.
class FamilyIdCard extends StatelessWidget {
  const FamilyIdCard({super.key, required this.family});

  final FamilyModel family;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final host = family.hostDisplayName;
    final rawCode = family.inviteCode;
    final displayCode = rawCode.length == 6
        ? '${rawCode.substring(0, 3)} ${rawCode.substring(3)}'
        : rawCode;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HostRow(
            host: host,
            avatarUrl: family.hostAvatarUrl,
            familyName: s.familyManagementFamilyName(host),
            subtitle: s.familyManagementFamilyCardSubtitle,
            isDark: isDark,
          ),
          SizedBox(height: 20.h),
          _CodeBox(
            label: s.familyManagementInviteCodeLabel.toUpperCase(),
            displayCode: displayCode,
            rawCode: rawCode,
            copiedMessage: s.familyManagementCopySuccess,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _HostRow extends StatelessWidget {
  const _HostRow({
    required this.host,
    required this.avatarUrl,
    required this.familyName,
    required this.subtitle,
    required this.isDark,
  });

  final String host;
  final String? avatarUrl;
  final String familyName;
  final String subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _HostAvatar(host: host, avatarUrl: avatarUrl),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                familyName,
                style: context.typo.subtitle.small.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: context.typo.body.small.copyWith(
                  color: AppTheme.textGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HostAvatar extends StatelessWidget {
  const _HostAvatar({required this.host, required this.avatarUrl});

  final String host;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final initial = host.isNotEmpty ? host[0].toUpperCase() : '?';
    final fallback = Container(
      width: 52.w,
      height: 52.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Text(
        initial,
        style: context.typo.title.small.copyWith(
          fontWeight: FontWeight.w800,
          color: AppTheme.primary,
        ),
      ),
    );

    final url = avatarUrl;
    if (url == null || url.isEmpty) return fallback;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: Image.network(
        url,
        width: 52.w,
        height: 52.w,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({
    required this.label,
    required this.displayCode,
    required this.rawCode,
    required this.copiedMessage,
    required this.isDark,
  });

  final String label;
  final String displayCode;
  final String rawCode;
  final String copiedMessage;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurfaceVariant : AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.typo.caption.medium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  displayCode,
                  style: context.typo.display.small.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          _CopyButton(
            rawCode: rawCode,
            copiedMessage: copiedMessage,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({
    required this.rawCode,
    required this.copiedMessage,
    required this.isDark,
  });

  final String rawCode;
  final String copiedMessage;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: rawCode));
          if (!context.mounted) return;
          context.showSuccessSnackBar(copiedMessage);
        },
        child: Container(
          width: 44.w,
          height: 44.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
            ),
          ),
          child: Icon(
            Icons.copy_outlined,
            size: 20.w,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}

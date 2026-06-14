import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/parent_home_notifier.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/shared/widgets/app_popup_menu_button.dart';

/// Glass "select child" pill in the statistic app-bar. Matches HTML
/// `.select-child-btn`: frosted white pill (blur 12), green avatar + label +
/// chevron, radius 20. Tapping opens a popup to switch the selected child.
class ParentStatisticChildSelector extends ConsumerWidget {
  const ParentStatisticChildSelector({
    super.key,
    required this.isDark,
    required this.children,
    required this.selectedChild,
  });

  /// Family members with role `child`.
  final List<FamilyMemberModel> children;

  /// Currently resolved selected child (nullable when none selected).
  final FamilyMemberModel? selectedChild;

  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final fg = isDark ? AppTheme.darkTextPrimary : AppTheme.homeParFg;
    final muted =
        isDark ? AppTheme.textMuted : AppTheme.homeParFg.withValues(alpha: 0.6);
    // "Chọn" — first word of the select-child prompt when nothing is selected.
    final label =
        selectedChild?.displayName ?? s.parentStatisticSelectChild.split(' ').first;

    return AppPopupMenuButton<String>(
      onSelected: (id) =>
          ref.read(parentHomeNotifierProvider.notifier).selectMember(id),
      itemBuilder: (_) => children
          .map<PopupMenuItem<String>>(
            (c) => PopupMenuItem<String>(
              value: c.uid,
              child: Row(
                children: [
                  _avatar(c, context, radius: 10),
                  SizedBox(width: 8.w),
                  Text(
                    c.displayName,
                    style: context.typo.body.small
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      child: ClipRRect(
        // HTML border-radius: 20px
        borderRadius: BorderRadius.circular(20.r),
        child: BackdropFilter(
          // backdrop-filter: blur(12px)
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            // padding: 6px 12px 6px 6px
            padding: EdgeInsets.fromLTRB(6.w, 6.h, 12.w, 6.h),
            decoration: BoxDecoration(
              // --surface-glass: rgba(255,255,255,0.72)
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(20.r),
              // --border: rgba(47,127,51,0.12)
              border: Border.all(color: AppTheme.primary.withValues(alpha: 0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // .child-avatar — 24×24 → radius 12
                _avatar(selectedChild, context, radius: 12),
                SizedBox(width: 8.w), // gap: 8px
                Text(
                  label,
                  style: context.typo.body.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: fg,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14.r,
                  color: muted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(
    FamilyMemberModel? c,
    BuildContext context, {
    required double radius,
  }) {
    final url = c?.avatarUrl;
    final name = c?.displayName ?? '';
    final letter = name.isNotEmpty ? name[0].toUpperCase() : 'C';
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: AppTheme.primary, // --accent
      backgroundImage: url != null
          // Diameter = 2 × radius, so decode to that display size.
          ? ResizeImage(
              NetworkImage(url),
              width: decodePixelsFor(context, radius.r * 2),
            )
          : null,
      child: url == null
          ? Text(
              letter,
              style: context.typo.caption.small.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.sp,
              ),
            )
          : null,
    );
  }
}

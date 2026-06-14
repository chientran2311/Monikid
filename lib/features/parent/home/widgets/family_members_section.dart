import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
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
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            s.homeParFamilyMembersLabel,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -0.02 * 18,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 96.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const BouncingScrollPhysics(),
            children: [
              _AddMemberButton(isDark: isDark, inviteCode: inviteCode),
              SizedBox(width: 16.w),
              ...members.map((member) {
                final isSelected = member.uid == selectedMemberId;
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: _MemberAvatar(
                    member: member,
                    isSelected: isSelected,
                    isDark: isDark,
                    textColor: textColor,
                    mutedColor: mutedColor,
                    onTap: () => onMemberTap(member.uid),
                  ),
                );
              }),
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
    required this.isDark,
    required this.textColor,
    required this.mutedColor,
    required this.onTap,
  });

  final FamilyMemberModel member;
  final bool isSelected;
  final bool isDark;
  final Color textColor;
  final Color mutedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: isSelected
                    ? Border.all(color: AppTheme.primary, width: 2)
                    : Border.all(
                        color: isDark
                            ? AppTheme.borderDark
                            : AppTheme.borderLight,
                      ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          spreadRadius: 3.r,
                          color: AppTheme.primary.withValues(alpha: 0.15),
                        ),
                      ]
                    : null,
                gradient: isSelected
                    ? null
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.lerp(AppTheme.primary, Colors.white, 0.74)!,
                          Color.lerp(AppTheme.primary, Colors.white, 0.88)!,
                        ],
                      ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19.r),
                child: member.avatarUrl != null
                    ? Image.network(
                        member.avatarUrl!,
                        fit: BoxFit.cover,
                        cacheWidth: decodePixelsFor(context, 56.r),
                        errorBuilder: (_, __, ___) =>
                            _InitialAvatar(name: member.displayName),
                      )
                    : _InitialAvatar(name: member.displayName),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              member.displayName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? textColor : mutedColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
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

/// Renders a rounded-rectangle with a dashed border, matching HTML:
///   border: 2px dashed color-mix(in oklab, var(--accent) 30%, white)
class _DashedRoundedBox extends StatelessWidget {
  const _DashedRoundedBox({
    required this.size,
    required this.radius,
    required this.isDark,
    required this.child,
  });

  final double size;
  final double radius;
  final bool isDark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark
        ? AppTheme.borderDark
        : Color.lerp(AppTheme.primary, Colors.white, 0.70)!;

    return CustomPaint(
      painter: _DashedRoundedRectPainter(
        color: borderColor,
        strokeWidth: 2.0,
        dashLength: 5.0,
        gapLength: 4.0,
        radius: radius,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(child: child),
      ),
    );
  }
}

class _DashedRoundedRectPainter extends CustomPainter {
  const _DashedRoundedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rrect);

    // Compute total path length
    final metrics = path.computeMetrics().toList();
    for (final metric in metrics) {
      double distance = 0.0;
      final total = metric.length;
      bool draw = true;
      while (distance < total) {
        final segLen = draw ? dashLength : gapLength;
        final end = (distance + segLen).clamp(0.0, total);
        if (draw) {
          canvas.drawPath(metric.extractPath(distance, end), paint);
        }
        distance = end;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRoundedRectPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.radius != radius;
}

class _AddMemberButton extends StatelessWidget {
  const _AddMemberButton({required this.isDark, required this.inviteCode});

  final bool isDark;
  final String inviteCode;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final s = context.l10n;

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => InviteCodeDialog(inviteCode: inviteCode),
      ),
      child: SizedBox(
        width: 56.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DashedRoundedBox(
              size: 56.r,
              radius: 20.r,
              isDark: isDark,
              child: Icon(
                Icons.add_rounded,
                size: 26.r,
                color: mutedColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              s.homeParAddMember,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: mutedColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

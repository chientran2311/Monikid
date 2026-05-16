import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class InviteCodeSheet extends StatelessWidget {
  const InviteCodeSheet({
    super.key,
    required this.inviteCode,
    required this.isDark,
  });

  final String inviteCode;
  final bool isDark;

  String get _formattedCode {
    if (inviteCode.length == 6) {
      return '${inviteCode.substring(0, 3)} ${inviteCode.substring(3)}';
    }
    return inviteCode;
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor =
        isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Container(
      margin: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.link_rounded,
              size: 24.r,
              color: AppTheme.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            s.homeParInviteTitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            s.homeParInviteCodeLabel,
            style: TextStyle(fontSize: 13.sp, color: mutedColor),
          ),
          SizedBox(height: 16.h),

          // Code display
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding:
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : const Color(0xFFF4F4F5),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: borderColor, width: 0.5),
            ),
            child: Text(
              _formattedCode,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 8,
                color: AppTheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),

          // Copy button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Clipboard.setData(
                      ClipboardData(text: inviteCode));
                  if (!context.mounted) return;
                  context.showSuccessSnackBar(s.homeParCodeCopied);
                  context.pop();
                },
                icon: Icon(Icons.copy_rounded, size: 18.r),
                label: Text(
                  s.homeParCopyCode,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ProfileEditFormRow extends StatelessWidget {
  const ProfileEditFormRow({
    super.key,
    required this.icon,
    required this.label,
    required this.child,
    this.trailingWidget,
    this.onTap,
    this.showDivider = true,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final Widget child;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final bool showDivider;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 18.r, color: AppTheme.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: context.typo.caption.big.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textGrey,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                child,
              ],
            ),
          ),
          if (trailingWidget != null) ...[
            SizedBox(width: 8.w),
            trailingWidget!,
          ],
        ],
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        onTap != null
            ? InkWell(onTap: onTap, child: content)
            : content,
        if (showDivider)
          Padding(
            padding: EdgeInsets.only(left: 52.w),
            child: Divider(
              height: 1,
              thickness: 1,
              color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
            ),
          ),
      ],
    );
  }
}

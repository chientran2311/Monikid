import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// SettingItemV2 — Redesigned based on setting-page-child.html
/// 
/// Key differences from original SettingItem:
/// - Larger icon container (44x44 vs 32x32)
/// - More padding (17h vs 12h)
/// - Larger border radius (14r vs 8r)
/// - Optional subtitle support
/// - Gradient background support (via iconBgGradient)
class SettingItemV2 extends StatelessWidget {
  const SettingItemV2({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconBgColor,
    this.iconBgGradient,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.showChevron = true,
    this.showBorder = true,
  }) : assert(
          iconBgColor != null || iconBgGradient != null,
          'Must provide either iconBgColor or iconBgGradient',
        );

  final IconData icon;
  final Color iconColor;
  final Color? iconBgColor;
  final Gradient? iconBgGradient;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showChevron;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final subtitleColor = isDark ? AppTheme.textGreyMedium : AppTheme.textGrey;
    final chevronColor = isDark ? AppTheme.textGreyMedium : AppTheme.textGreyDark;

    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: borderColor, width: 0.5))
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon container — 44x44 with gradient support
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: iconBgGradient == null ? iconBgColor : null,
                    gradient: iconBgGradient,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(icon, color: iconColor, size: 22.r),
                ),
                SizedBox(width: 14.w),
                
                // Text area — Expanded to fill available space
                Expanded(
                  child: subtitle != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              style: context.typo.body.medium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              subtitle!,
                              style: context.typo.body.medium.copyWith(
                                color: subtitleColor,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          title,
                          style: context.typo.body.medium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                ),
                
                // Optional trailing widget
                if (trailing != null) ...[
                  SizedBox(width: 8.w),
                  trailing!,
                ],
                
                // Chevron
                if (showChevron) ...[
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20.r,
                    color: chevronColor,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

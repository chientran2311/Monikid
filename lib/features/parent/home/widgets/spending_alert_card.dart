import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class SpendingAlertCard extends StatelessWidget {
  const SpendingAlertCard({
    super.key,
    required this.isDark,
    required this.isWarning,
    required this.memberName,
    required this.todayExpenseMinor,
    required this.limitMinor,
    this.onTap,
  });

  final bool isDark;
  final bool isWarning;
  final String memberName;
  final int todayExpenseMinor;
  final int limitMinor;
  final VoidCallback? onTap;

  static String _fmt(int minor) {
    final formatted = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    ).format(minor);
    return '${formatted.trim()}đ';
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    final iconData = isWarning
        ? Icons.warning_amber_rounded
        : Icons.check_circle_outline_rounded;
    final iconColor = isWarning ? AppTheme.amberText : AppTheme.primary;

    final iconBgColor = isWarning
        ? (isDark
            ? AppTheme.amberFill.withValues(alpha: 0.2)
            : AppTheme.warningSurface)
        : (isDark
            ? AppTheme.darkPrimaryContainer
            : AppTheme.primaryLight);

    final iconBorderColor = isWarning
        ? (isDark
            ? AppTheme.amberText.withValues(alpha: 0.3)
            : AppTheme.amberText.withValues(alpha: 0.18))
        : (isDark
            ? AppTheme.darkPrimaryAccent.withValues(alpha: 0.3)
            : AppTheme.primary.withValues(alpha: 0.25));

    final cardBg = isWarning
        ? (isDark
            ? AppTheme.surfaceDark
            : Colors.white.withValues(alpha: 0.84))
        : (isDark
            ? AppTheme.darkPrimaryContainer
            : AppTheme.primaryLight);

    final cardBorder = isWarning
        ? (isDark ? AppTheme.borderDark : AppTheme.borderLight)
        : (isDark
            ? AppTheme.darkPrimaryAccent.withValues(alpha: 0.2)
            : AppTheme.primary.withValues(alpha: 0.2));

    final title = isWarning
        ? s.homeParSpendingWarningTitle
        : s.homeParSpendingSafeTitle;
    final threshold = (limitMinor * 0.05).round();
    final description = isWarning
        ? s.homeParSpendingWarningDesc(
            memberName,
            _fmt(todayExpenseMinor),
            _fmt(threshold),
          )
        : s.homeParSpendingSafeDesc(memberName);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          border: Border.all(color: cardBorder),
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                border: Border.all(color: iconBorderColor),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(iconData, size: 22.r, color: iconColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.typo.body.medium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      letterSpacing: -0.01 * 14,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    description,
                    style: context.typo.caption.big.copyWith(
                      color: mutedColor,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.chevron_right_rounded,
                size: 20.r,
                color: mutedColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

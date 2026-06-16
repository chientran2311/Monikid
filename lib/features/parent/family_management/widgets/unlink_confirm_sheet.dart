import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Bottom sheet confirming a destructive unlink action. Confirm-only — it does
/// not collect a password. Mirrors the `.bottom-sheet` block from the design.
class UnlinkConfirmSheet extends StatelessWidget {
  const UnlinkConfirmSheet({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
  });

  final String title;
  final String description;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 44.h),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 5.h,
              margin: EdgeInsets.only(bottom: 24.h),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                borderRadius: BorderRadius.circular(999.r),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.typo.title.medium.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.typo.body.medium.copyWith(
                color: AppTheme.textGrey,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            _SheetButton(
              label: s.familyManagementUnlinkSheetConfirm,
              background: AppTheme.redAlert,
              foreground: Colors.white,
              onTap: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
            SizedBox(height: 12.h),
            _SheetButton(
              label: s.familyManagementUnlinkSheetCancel,
              background:
                  isDark ? AppTheme.darkSurfaceVariant : AppTheme.surfaceLightGrey,
              foreground: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(999.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999.r),
          child: Center(
            child: Text(
              label,
              style: context.typo.button.medium.copyWith(color: foreground),
            ),
          ),
        ),
      ),
    );
  }
}

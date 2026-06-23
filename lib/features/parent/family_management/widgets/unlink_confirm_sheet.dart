import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

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
            PrimaryButton.danger(
              title: s.familyManagementUnlinkSheetConfirm,
              onTap: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
            SizedBox(height: 12.h),
            PrimaryButton.secondary(
              title: s.familyManagementUnlinkSheetCancel,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

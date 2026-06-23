import 'package:flutter/material.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Pill-shaped "Done" action chip for dialogs and bottom sheets.
///
/// Tinted primary background, rounded border, primary label.
/// Label is always [AppLocalizations.actionDone].
///
/// Usage:
///   DoneChip(onTap: () => context.pop())
class DoneChip extends StatelessWidget {
  const DoneChip({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.primary.withValues(alpha: 0.15)
              : AppTheme.primaryLight,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppTheme.primary.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Text(
          context.l10n.actionDone,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

/// Error state for the parent home tab — glass card with a retry action.
/// Shown when `ParentHomeStatus.error`; [onRetry] re-runs `onInit()`.
class HomeErrorState extends StatelessWidget {
  const HomeErrorState({
    super.key,
    required this.isDark,
    required this.onRetry,
    this.message,
  });

  final bool isDark;
  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final titleColor = isDark ? AppTheme.textWhite : AppTheme.homeParFg;
    final mutedColor = isDark
        ? AppTheme.textMuted
        : AppTheme.homeParFg.withValues(alpha: 0.6);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 80.h, 24.w, 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Glass warning circle.
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 96.r,
                height: 96.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.orangeWarning.withValues(alpha: 0.12),
                  border: Border.all(
                    color: AppTheme.orangeWarning.withValues(alpha: 0.24),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 44.r,
                  color: AppTheme.orangeWarning,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            s.homeParErrorTitle,
            textAlign: TextAlign.center,
            style: context.typo.title.big.copyWith(
              fontWeight: FontWeight.w800,
              color: titleColor,
            ),
          ),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              message ?? s.homeParErrorDesc,
              textAlign: TextAlign.center,
              style: context.typo.body.big.copyWith(
                color: mutedColor,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 28.h),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh_rounded, size: 20.r),
            label: Text(s.actionRetry),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

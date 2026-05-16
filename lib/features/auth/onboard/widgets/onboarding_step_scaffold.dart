import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class OnboardingStepScaffold extends StatelessWidget {
  const OnboardingStepScaffold({
    super.key,
    required this.isFinishing,
    required this.onSkip,
    required this.onContinue,
    required this.continueLabel,
    required this.child,
  });

  final bool isFinishing;
  final VoidCallback onSkip;
  final VoidCallback onContinue;
  final String continueLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    return ColoredBox(
      color: backgroundColor,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 2.h),
              child: TextButton(
                onPressed: isFinishing ? null : onSkip,
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  minimumSize: Size(64.w, 40.h),
                ),
                child: Text(
                  context.l10n.actionSkip,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.textMedium,
                    weight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: child),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: isFinishing ? null : onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.textWhite,
                  elevation: 0,
                  shadowColor: AppTheme.primary.withValues(alpha: 0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      continueLabel,
                      style: AppTextStyleFactory.style(
                        size: AppFontSizes.textLarge,
                        weight: FontWeight.w800,
                        color: AppTheme.textWhite,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (isFinishing)
                      SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.r,
                          color: AppTheme.textWhite,
                        ),
                      )
                    else
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppTheme.textWhite,
                        size: 22.r,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

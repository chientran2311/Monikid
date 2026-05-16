import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.message,
    this.backgroundColor,
    this.progressColor = AppTheme.primary,
  });

  final String? message;
  final Color? backgroundColor;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedBackgroundColor =
        backgroundColor ??
        (isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight)
            .withValues(alpha: 0.92);
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;

    return Material(
      color: resolvedBackgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 36.r,
              height: 36.r,
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: progressColor,
              ),
            ),
            if (message != null && message!.trim().isNotEmpty) ...[
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

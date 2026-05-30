import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/pin/widgets/pin_keypad_widget.dart';

class PinScreenBody extends StatelessWidget {
  const PinScreenBody({
    required this.title,
    required this.description,
    required this.currentPin,
    required this.onAddNumber,
    required this.onRemoveNumber,
    this.hasError = false,
    this.isLoading = false,
    this.isInputDisabled = false,
    this.message,
    super.key,
  });

  final String title;
  final String description;
  final String currentPin;
  final void Function(String digit) onAddNumber;
  final VoidCallback onRemoveNumber;
  final bool hasError;
  final bool isLoading;
  final bool isInputDisabled;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 40.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 88.r,
                    height: 88.r,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                  ),
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 12.h),
                          blurRadius: 24.r,
                          color: AppTheme.primary.withValues(alpha: 0.08),
                        ),
                      ],
                    ),
                    child: Icon(Icons.lock_rounded, color: AppTheme.primary, size: 32.r),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.typo.title.big.copyWith(
                  color: isDark ? AppTheme.surfaceLightGrey : AppTheme.textBlack,
                  fontWeight: FontWeight.w800,
                  letterSpacing: AppFontSizes.titleBig * -0.02,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.typo.body.big.copyWith(
                  color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        if (message != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              message!,
              textAlign: TextAlign.center,
              style: context.typo.subtitle.small.copyWith(
                color: hasError
                    ? AppTheme.redAlert
                    : (isDark ? AppTheme.iconLight : AppTheme.borderDark),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
        PinKeypadWidget(
          currentPin: currentPin,
          hasError: hasError,
          isLoading: isLoading,
          isDisabled: isInputDisabled,
          onAddNumber: onAddNumber,
          onRemoveNumber: onRemoveNumber,
        ),
      ],
    );
  }
}

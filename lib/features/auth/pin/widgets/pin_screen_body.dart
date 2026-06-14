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
    final screenH = MediaQuery.sizeOf(context).height;
    final outerIconSize = (screenH * 0.105).clamp(60.0, 88.0);
    final innerIconSize = (screenH * 0.076).clamp(44.0, 64.0);
    final iconBorderRadius = outerIconSize * 0.364;
    final innerBorderRadius = innerIconSize * 0.313;
    final lockIconSize = innerIconSize * 0.5;
    final gapBelowContent = (screenH * 0.025).clamp(8.0, 24.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: outerIconSize,
                      height: outerIconSize,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(iconBorderRadius),
                      ),
                    ),
                    Container(
                      width: innerIconSize,
                      height: innerIconSize,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
                        borderRadius: BorderRadius.circular(innerBorderRadius),
                        border: Border.all(color: AppTheme.borderLight),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, innerIconSize * 0.1875),
                            blurRadius: innerIconSize * 0.375,
                            color: AppTheme.primary.withValues(alpha: 0.08),
                          ),
                        ],
                      ),
                      child: Icon(Icons.lock_rounded, color: AppTheme.primary, size: lockIconSize),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
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
                if (message != null) ...[
                  SizedBox(height: 12.h),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: context.typo.subtitle.small.copyWith(
                      color: hasError
                          ? AppTheme.redAlert
                          : (isDark ? AppTheme.iconLight : AppTheme.borderDark),
                    ),
                  ),
                ],
                SizedBox(height: gapBelowContent),
              ],
            ),
          ),
        ),
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

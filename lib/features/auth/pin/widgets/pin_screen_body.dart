import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.only(top: 32, bottom: 24, left: 24, right: 24),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: AppTheme.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.typo.title.medium.copyWith(
                  color: isDark
                      ? AppTheme.surfaceLightGrey
                      : AppTheme.surfaceVeryDark,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.typo.text.medium.copyWith(
                  color:
                      isDark ? AppTheme.textMuted : AppTheme.textGrey,
                ),
              ),
            ],
          ),
        ),
        if (message != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message!,
              textAlign: TextAlign.center,
              style: context.typo.subtitle.small.copyWith(
                color: hasError
                    ? AppTheme.redAlert
                    : (isDark
                          ? AppTheme.iconLight
                          : AppTheme.borderDark),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        PinKeypadWidget(
          currentPin: currentPin,
          hasError: hasError,
          isLoading: isLoading,
          isDisabled: isInputDisabled,
          onAddNumber: onAddNumber,
          onRemoveNumber: onRemoveNumber,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          color: AppTheme.primary.withValues(alpha: isDark ? 0.1 : 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_rounded,
                color: AppTheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'KẾT NỐI BẢO MẬT BỞI MONIKID',
                style: context.typo.caption.small.copyWith(
                  letterSpacing: 1.2,
                  color: AppTheme.primary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

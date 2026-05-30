import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionSubmitButton extends StatelessWidget {
  const TransactionSubmitButton({
    required this.onPressed,
    required this.label,
    required this.enabled,
    required this.backgroundColor,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final bool enabled;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withValues(alpha: 0.0),
              backgroundColor.withValues(alpha: 0.9),
              backgroundColor,
            ],
          ),
        ),
        child: GestureDetector(
          onTap: enabled ? onPressed : null,
          child: AnimatedScale(
            scale: enabled ? 1.0 : 0.97,
            duration: const Duration(milliseconds: 120),
            child: Container(
              height: 58.h,
              decoration: BoxDecoration(
                gradient: enabled ? AppTheme.primaryButtonGradient : null,
                color: enabled ? null : AppTheme.borderLight,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: enabled
                    ? [
                        BoxShadow(
                          offset: Offset(0, 16.h),
                          blurRadius: 32.r,
                          color: AppTheme.primary.withValues(alpha: 0.25),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  label,
                  style: context.typo.button.big.copyWith(
                    fontWeight: FontWeight.w800,
                    color: enabled ? AppTheme.textWhite : AppTheme.textMuted,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

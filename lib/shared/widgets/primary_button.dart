import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/bounce_tap.dart';

enum _Variant { primary, secondary, danger }

/// Three-variant app button with built-in bounce animation.
///
/// ```dart
/// // Green gradient — main CTA
/// PrimaryButton(title: 'Tiếp tục', onTap: onContinue)
///
/// // Grey outline — dismiss / skip
/// PrimaryButton.secondary(title: 'Để sau', onTap: onSkip)
///
/// // Red filled — destructive action
/// PrimaryButton.danger(title: 'Xoá', onTap: onDelete)
///
/// // With leading icon
/// PrimaryButton(title: 'Gửi', icon: const Icon(Icons.send_rounded), onTap: onSend)
/// ```
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.height,
    this.borderRadius,
  }) : _variant = _Variant.primary;

  const PrimaryButton.secondary({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.height,
    this.borderRadius,
  }) : _variant = _Variant.secondary;

  const PrimaryButton.danger({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.height,
    this.borderRadius,
  }) : _variant = _Variant.danger;

  final String title;
  final VoidCallback? onTap;
  final Widget? icon;
  final bool isLoading;

  /// Defaults to 65.h when null.
  final double? height;

  /// Corner radius. Defaults to 18.r when null. Pass a large value for a pill.
  final double? borderRadius;

  final _Variant _variant;

  bool get _tappable => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: _tappable ? onTap : null,
      child: SizedBox(
        width: double.infinity,
        height: height ?? 65.h,
        child: switch (_variant) {
          _Variant.primary   => _PrimaryBody(title: title, icon: icon, isLoading: isLoading, enabled: _tappable, radius: borderRadius),
          _Variant.secondary => _SecondaryBody(title: title, icon: icon, isLoading: isLoading, enabled: _tappable, radius: borderRadius),
          _Variant.danger    => _DangerBody(title: title, icon: icon, isLoading: isLoading, enabled: _tappable, radius: borderRadius),
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────

Widget _label(String title, Color color) => Text(
      title,
      style: AppTextStyleFactory.style(
        size: AppFontSizes.bodyBig,
        weight: FontWeight.w900,
        color: color,
        letterSpacing: -0.02,
      ),
    );

Widget _spinner(Color color) => SizedBox(
      width: 20.r,
      height: 20.r,
      child: CircularProgressIndicator(strokeWidth: 2.r, color: color),
    );

Widget _content(String title, Widget? icon, bool isLoading, Color fg) {
  if (isLoading) return _spinner(fg);
  if (icon == null) return _label(title, fg);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconTheme(data: IconThemeData(color: fg, size: 18.r), child: icon),
      SizedBox(width: 8.w),
      _label(title, fg),
    ],
  );
}

// ─────────────────────────────────────────────
// Primary — green gradient
// ─────────────────────────────────────────────

class _PrimaryBody extends StatelessWidget {
  const _PrimaryBody({
    required this.title,
    required this.icon,
    required this.isLoading,
    required this.enabled,
    this.radius,
  });

  final String title;
  final Widget? icon;
  final bool isLoading;
  final bool enabled;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryButtonGradient,
          borderRadius: BorderRadius.circular(radius ?? 18.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 16.h),
              blurRadius: 28.r,
              color: AppTheme.primary.withValues(alpha: 0.24),
            ),
          ],
        ),
        child: Center(
          child: _content(title, icon, isLoading, AppTheme.textWhite),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Secondary — grey outline (dismiss / skip)
// ─────────────────────────────────────────────

class _SecondaryBody extends StatelessWidget {
  const _SecondaryBody({
    required this.title,
    required this.icon,
    required this.isLoading,
    required this.enabled,
    this.radius,
  });

  final String title;
  final Widget? icon;
  final bool isLoading;
  final bool enabled;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final border = Color.lerp(AppTheme.primary, Colors.white, 0.82)!;

    return Opacity(
      opacity: enabled ? 1.0 : 0.45,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 18.r),
          border: Border.all(color: border),
        ),
        child: Center(
          child: _content(title, icon, isLoading, AppTheme.textGrey),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Danger — red border + red text
// ─────────────────────────────────────────────

class _DangerBody extends StatelessWidget {
  const _DangerBody({
    required this.title,
    required this.icon,
    required this.isLoading,
    required this.enabled,
    this.radius,
  });

  final String title;
  final Widget? icon;
  final bool isLoading;
  final bool enabled;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.45,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.redDark,
          borderRadius: BorderRadius.circular(radius ?? 18.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 8.h),
              blurRadius: 20.r,
              color: AppTheme.redDark.withValues(alpha: 0.24),
            ),
          ],
        ),
        child: Center(
          child: _content(title, icon, isLoading, AppTheme.textWhite),
        ),
      ),
    );
  }
}

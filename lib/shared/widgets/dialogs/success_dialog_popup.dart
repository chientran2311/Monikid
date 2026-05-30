import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/l10n/app_localizations.dart';

/// Success dialog popup with checkmark icon, title, message, and action button.
///
/// Reusable component that can be customized via parameters.
/// Default text is localized via l10n.
///
/// Usage:
/// ```dart
/// showDialog(
///   context: context,
///   barrierColor: const Color(0x2E0D1D0F), // rgba(13,29,15,.18)
///   builder: (context) => SuccessDialogPopup(
///     title: 'Custom Title',
///     message: 'Custom message here',
///     buttonText: 'Got it',
///     onPressed: () => Navigator.pop(context),
///   ),
/// );
/// ```
class SuccessDialogPopup extends StatelessWidget {
  const SuccessDialogPopup({
    super.key,
    this.title,
    this.message,
    this.buttonText,
    this.onPressed,
  });

  /// Dialog title. Falls back to localized default if null.
  final String? title;

  /// Dialog message/description. Falls back to localized default if null.
  final String? message;

  /// Button text. Falls back to localized default if null.
  final String? buttonText;

  /// Button action. Defaults to Navigator.pop if null.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        constraints: BoxConstraints(maxWidth: 328.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color.fromRGBO(0x2F, 0x7F, 0x33, 0.18),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0x15, 0x34, 0x16, 0.16),
              blurRadius: 60.r,
              offset: Offset(0, 28.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuccessVisual(),
              SizedBox(height: 16.h),
              _buildTitle(context, l10n),
              SizedBox(height: 10.h),
              _buildMessage(context, l10n),
              SizedBox(height: 18.h),
              _buildButton(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessVisual() {
    return SizedBox(
      width: 88.w,
      height: 88.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  Color.fromRGBO(0x2F, 0x7F, 0x33, 0.18),
                  Color.fromRGBO(255, 255, 255, 0.72),
                  Colors.transparent,
                ],
                stops: [0.0, 0.62, 0.70],
              ),
            ),
          ),
          // Dashed ring
          Container(
            width: 72.w,
            height: 72.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(
                color: Color.fromRGBO(0x2F, 0x7F, 0x33, 0.20),
                width: 1,
                strokeAlign: BorderSide.strokeAlignInside,
              )),
            ),
            child: const CustomPaint(
              painter: _DashedCirclePainter(
                color: Color.fromRGBO(0x2F, 0x7F, 0x33, 0.20),
                strokeWidth: 1,
                dashLength: 4,
                gapLength: 4,
              ),
            ),
          ),
          // Success icon core
          Container(
            width: 58.w,
            height: 58.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0x2F, 0x7F, 0x33, 0.12),
                  Colors.white,
                ],
              ),
              border: Border.all(
                color: const Color.fromRGBO(0x2F, 0x7F, 0x33, 0.24),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0x2F, 0x7F, 0x33, 0.14),
                  blurRadius: 30.r,
                  offset: Offset(0, 16.h),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '✓',
                style: AppTextStyleFactory.style(
                  size: 28,
                  weight: FontWeight.w900,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, AppLocalizations l10n) {
    final displayTitle = title ?? l10n.successDialogDefaultTitle;

    return Text(
      displayTitle,
      textAlign: TextAlign.center,
      style: AppTextStyleFactory.style(
        size: 26,
        weight: FontWeight.w900,
        letterSpacing: -0.03,
        height: 1.08,
      ),
    );
  }

  Widget _buildMessage(BuildContext context, AppLocalizations l10n) {
    final displayMessage = message ?? l10n.successDialogDefaultMessage;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 336.w), // ~24ch approximation (14px * 24)
      child: Text(
        displayMessage,
        textAlign: TextAlign.center,
        style: AppTextStyleFactory.style(
          size: 14,
          weight: FontWeight.normal,
          color: AppTheme.textMuted,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, AppLocalizations l10n) {
    final displayButtonText = buttonText ?? l10n.successDialogDefaultButton;
    final action = onPressed ?? () => Navigator.of(context).pop();

    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryButtonGradient,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0x2F, 0x7F, 0x33, 0.24),
                blurRadius: 28.r,
                offset: Offset(0, 16.h),
              ),
            ],
          ),
          child: Center(
            child: Text(
              displayButtonText,
              style: AppTextStyleFactory.style(
                size: 16,
                weight: FontWeight.w900,
                letterSpacing: -0.02,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for dashed circle ring
class _DashedCirclePainter extends CustomPainter {
  const _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final circumference = 2 * 3.14159 * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashLength + gapLength) / radius);
      final sweepAngle = dashLength / radius;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
